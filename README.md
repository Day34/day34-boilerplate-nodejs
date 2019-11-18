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