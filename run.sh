#!/bin/bash
echo "--------Day 34 Boilerplate Node JS----------"

argv1="$1"

# arg 가 없을 때 선택하는 옵션
select_course() {
  PS3='번호를 선택하세요 : '
  options=("Local 환경" "Dev 환경" "Prod 환경" "나가기")
  select opt in "${options[@]}"
  do
    case $opt in
      "Local 환경")
        echo "Local 환경 실행을 구성합니다."
        argv1='local'
        break;;
      "Dev 환경")
        echo "Dev 환경 실행을 구성합니다."
        argv1='dev'
        break;;
      "Prod 환경")
        echo "Prod 환경 실행을 구성합니다."
        argv1='prod'
        break;;
      "나가기")
        echo "종료합니다."
        exit 0
        esac
    done
}

exec_docker() {
  # .env 파일을 local, dev, prod 로 구분하여 Env 에 Export 함
  set -o allexport
    [[ -f .env."$argv1" ]] && source .env."$argv1"
  set +o allexport

  echo "APP Environment Mode : $APP_ENV"
  echo "APP SERVER_HOST : $SERVER_HOST"
  echo "APP SERVER_PORT : $SERVER_PORT"

  # local은 바로 컨테이너 실행 dev, prod는 빌드만 하고 Repository에 Upload함
  if [ "$APP_ENV" == "local" ]; then
    echo "Docker-Compose Build 후 컨테이너를 실행합니다..."
    docker-compose up --build
  elif [ "$APP_ENV" == "dev" ]; then
    echo "Docker-Compose Build 후 Docker Hub에 업로드"
     # 바꿔야함 ! 빌드하고 Docker Hub 에 Push.... 개발 서버 Deploy를 위해...
    docker-compose up --build
  elif [ "$APP_ENV" == "Prod" ]; then
    echo "Docker-Compose Build 후 Docker Hub에 업로드"
     # 바꿔야함 ! 빌드하고 Docker Hub 에 Push.... 운영 서버 Deploy를 위해...
    docker-compose up --build
  fi
}

# arg 가 있을 때 argv1 에 값을 넣어줌
if [ $# -eq 0 ]; then
  select_course
elif [ $# -eq 1 ]; then
  if [ "$1" != "local" ] && [ "$1" != "dev" ] && [ "$1" != "prod" ]; then
    echo "Argument는 local, dev, prod 만 가능합니다."
    exit 0
  fi
else
  echo "Argument는 하나만 사용해 주세요."
  exit 0
fi

exec_docker

exit 0