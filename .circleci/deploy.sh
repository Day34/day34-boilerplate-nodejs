#!/bin/bash
set -eo pipefail

deploy_cluster() {
  make_container_definition
  register_definition

  desired_count=$(aws ecs describe-services --cluster "$CLUSTER_NAME" --services "$SERVICE_NAME" | $JQ '.services[0].desiredCount')
  echo "Desired count: $desired_count"

  if [[ $(aws ecs update-service --cluster "$CLUSTER_NAME" --service "$SERVICE_NAME" --desired-count "$desired_count" --task-definition "$revision" | \
        $JQ '.service.taskDefinition') != "$revision" ]]; then
    echo "Error updating service."
    return 1
  else
    echo "Success updating service."
  fi

  # wait for older revisions to disappear
  # not really necessary, but nice for demos
  for attempt in {1..30}; do
    if stale=$(aws ecs describe-services --cluster "$CLUSTER_NAME" --services "$SERVICE_NAME" | \
                   $JQ ".services[0].deployments | .[] | select(.taskDefinition != \"$revision\") | .taskDefinition"); then
      echo "Waiting for stale deployment(s):"
      echo "$stale"
        sleep 30
    else
      echo "Deployed!"
      return 0
    fi
  done
  echo "Service update took too long - please check the status of the deployment on the AWS ECS console"
  return 0
}

make_container_definition() {
  container_definition="[
    {
      \"name\": \"$TASK_NAME\",
      \"image\": \"$REPOSITORY_URL\",
      \"portMappings\": [
        {
          \"containerPort\": 80,
          \"hostPort\": 80,
          \"protocol\": \"tcp\"
        }
      ],
      \"logConfiguration\": {
        \"logDriver\": \"awslogs\",
        \"options\": {
          \"awslogs-group\": \"/ecs/$PROJECT\",
          \"awslogs-region\": \"$AWS_DEFAULT_REGION\",
          \"awslogs-stream-prefix\": \"ecs\"
        }
      },
      \"essential\": true,
      \"environment\": [
        {
          \"name\": \"SERVER_HOST\",
          \"value\": \"$SERVER_HOST\"
        },
        {
          \"name\": \"SERVER_PORT\",
          \"value\": \"$SERVER_PORT\"
        },
        {
          \"name\": \"API_END_POINT\",
          \"value\": \"$API_END_POINT\"
        }
      ]
    }
  ]"

  print_container_definition
}

print_container_definition() {
  echo "$container_definition"
}

register_definition() {
  if revision=$(aws ecs register-task-definition \
    --container-definitions "$container_definition" \
    --family "$FAMILY_NAME" \
    --execution-role-arn "arn:aws:iam::$AWS_ACCOUNT_ID:role/ecsTaskExecutionRole" \
    --network-mode "awsvpc" \
    --requires-compatibilities "FARGATE" \
    --cpu "$AWS_ECS_CONTAINER_CPU" \
    --memory "$AWS_ECS_CONTAINER_MEMORY" | $JQ '.taskDefinition.taskDefinitionArn'); then
    echo "Revision: ${revision}"
  else
    echo "Failed to register task definition"
    return 1
  fi
}

set_env_variables() {
  # arg 체크
  if [ $# -eq 1 ]; then
    if [ "$1" != "dev" ] && [ "$1" != "prod" ]; then
      echo "Argument는 dev, prod 만 가능합니다."
      exit 0
    elif [ "$1" == "dev" ]; then
      echo "DEV 환경 변수 생성"
      CLUSTER_NAME="$AWS_ECS_CLUSTER_NAME-dev"
      IMAGE_TAG="develop"
    elif [ "$1" == "prod" ]; then
      echo "PROD 환경 변수 생성"
      CLUSTER_NAME="$AWS_ECS_CLUSTER_NAME"
      IMAGE_TAG="$CIRCLE_SHA1"
    fi
  else
    echo "올바른 입력이 아닙니다."
    exit 0
  fi

  FAMILY_NAME="$PROJECT"
  SERVICE_NAME="$PROJECT"
  TASK_NAME="$PROJECT"
  REPOSITORY_URL="$DOCKER_REPOSITORY:$IMAGE_TAG"

  JQ="jq --raw-output --exit-status"

  print_env_variables
}

print_env_variables() {
  echo "$CLUSTER_NAME"
  echo "$IMAGE_TAG"
  echo "$FAMILY_NAME"
  echo "$SERVICE_NAME"
  echo "$TASK_NAME"
  echo "$REPOSITORY_URL"
}

configure_aws_cli() {
  aws --version
  aws configure set default.region "$AWS_DEFAULT_REGION"
  aws configure set default.output json
}

set_env_variables "$@"
configure_aws_cli
deploy_cluster