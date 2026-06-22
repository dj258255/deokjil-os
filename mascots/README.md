# 마스코트 팩

Deokjil OS는 **특정 캐릭터를 강제하지 않습니다.** 원하는 마스코트를 직접 팩으로 넣어 쓰세요.

## 추가 방법

`mascots/<이름>/` 폴더를 만들고, `~/.config/deokjil/user.conf`에 지정:

```
DEOKJIL_MASCOT="<이름>"
```

## 팩 구조 (권장 파일)

```
mascots/<이름>/
├── avatar.png      # 계정 프로필 사진(.face)으로 설정됨 (선택)
├── wallpaper.png   # 배경화면 (사용자가 따로 배경 지정 안 했을 때 사용, 선택)
└── preview.png     # 커스터마이저 미리보기용 (선택)
```

비워두면(`DEOKJIL_MASCOT=""`) 마스코트 없이 중립 기본으로 동작합니다 — 이게 기본값이에요.
움직이는 데스크톱 펫이 필요하면 `oneko`나 conky 위젯을 별도로 설치/설정하세요.
