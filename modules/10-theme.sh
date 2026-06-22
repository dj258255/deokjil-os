# 10-theme — 다크/라이트 + GTK 테마 + 아이콘 테마 (GNOME)
# apply.sh가 source 한다. 설정값과 로그 함수는 상위에서 주입됨.

if ! has_gnome; then
  warn "GNOME(gsettings) 없음 — 테마 모듈 건너뜀"
  return 0 2>/dev/null || exit 0
fi

# 다크/라이트 모드
case "${DEOKJIL_DARK:-}" in
  true)  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'; ok "다크 모드 ON" ;;
  false) gsettings set org.gnome.desktop.interface color-scheme 'default';     ok "라이트 모드" ;;
esac

# GTK 테마 (비어있으면 건너뜀)
if [ -n "${DEOKJIL_GTK_THEME:-}" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme "$DEOKJIL_GTK_THEME"
  ok "GTK 테마: $DEOKJIL_GTK_THEME"
fi

# 아이콘 테마
if [ -n "${DEOKJIL_ICON_THEME:-}" ]; then
  gsettings set org.gnome.desktop.interface icon-theme "$DEOKJIL_ICON_THEME"
  ok "아이콘 테마: $DEOKJIL_ICON_THEME"
fi
