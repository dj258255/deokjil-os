# 테마

GTK/아이콘 테마는 보통 시스템에 설치된 테마 이름으로 지정해요(`apt`나 수동 설치).
`~/.config/deokjil/user.conf`에서:

```
DEOKJIL_GTK_THEME="Yaru-dark"
DEOKJIL_ICON_THEME="Papirus-Dark"
```

직접 만든/내려받은 테마 폴더를 번들하고 싶다면 여기(`themes/<이름>/`)에 두고,
`apply.sh`가 `~/.themes` 또는 `~/.local/share/themes`로 복사하도록 모듈을 확장하면 됩니다(향후).
비워두면 현재 테마를 유지합니다.
