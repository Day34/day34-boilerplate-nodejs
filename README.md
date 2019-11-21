# 실행
```sh
cp .env.example .env
docker-compose up --build
```

# API 동작 확인
## GET
### 모든 아이템 조회
* 실행
```sh
curl -X GET \
  http://127.0.0.1:8080/api/sample/item
```
* 결과
```sh
{
    "success": true,
    "message": "정상적으로 처리되었습니다.",
    "data": [
        {
            "name": "items",
            "age": 18,
            "memo": "와우!"
        }
    ]
}
```

### 특정 아이템 조회
* 실행
```sh
curl -X GET \
  http://127.0.0.1:8080/api/sample/item/1
```

* 결과
```sh
{
    "success": true,
    "message": "정상적으로 처리되었습니다.",
    "data": {
        "itemId": "1",
        "name": "item",
        "age": 18,
        "memo": "와우!"
    }
}
```

## POST
### 아이템 추가
* 실행
```sh
curl -X POST \
  http://127.0.0.1:8080/api/sample/item \
  -H 'Content-Type: application/json' \
  -d '{
	"name" : "Day34",
	"age" : 34,
	"memo" :"Day34 API"
  }'
```

* 결과
```sh
{
    "success": true,
    "message": "name : Day34, age : 34, memo : Day34 API 저장 성공",
    "data": {
        "name": "Day34",
        "age": 34,
        "memo": "Day34 API"
    }
}
```

## PUT
### 아이템 갱신
* 실행
```sh
curl -X PUT \
  http://127.0.0.1:8080/api/sample/item \
  -H 'Content-Type: application/json' \
  -d '{
	"name" : "Day34",
	"age" : 34,
	"memo" :"Day34 API UPDATED"
  }'
```

* 결과
```sh
{
    "success": true,
    "message": "name : Day34, age : 34, memo : Day34 API UPDATED 수정 성공",
    "data": {
        "name": "Day34",
        "age": 34,
        "memo": "Day34 API UPDATED"
    }
}
```

## DELETE
### 아이템 삭제
* 실행
```sh
curl -X DELETE \
  http://127.0.0.1:8080/api/sample/item/1
```

* 결과
```sh
{
    "success": true,
    "message": "정상적으로 처리되었습니다.",
    "data": "itemId : 1 삭제 성공"
}
```



---

# Github Label 세팅

## Github 액세스 토큰 발급
[https://github.com/settings/tokens](https://github.com/settings/tokens)
- `Generate new token` 클릭
- 원하는 이름 입력
- `scopes`에서 repo 선택

[](https://www.notion.so/947b39af498e464ba6402326bcdff23e#12b6f9faab0246d49391e7631573b65a)

## 실행 전 확인
```sh
npx github-label-sync --dry-run --access-token xxxxxx --labels day34-labels.json Day34/repo-name
```

## 실행
위의 명령에서 `--dry-run` 플래그 제거

```sh
npx github-label-sync --access-token xxxxxx --labels day34-labels.json Day34/repo-name
```