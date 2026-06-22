# 30-wallpaper — 배경화면 (GNOME)

if ! has_gnome; then
  return 0 2>/dev/null || exit 0
fi
if [ -z "${DEOKJIL_WALLPAPER:-}" ]; then
  return 0 2>/dev/null || exit 0
fi

# 절대경로면 그대로, 아니면 wallpapers/ 안에서 찾는다.
wp="$DEOKJIL_WALLPAPER"
case "$wp" in
  /*) : ;;                              # 절대경로
  *)  wp="$DEOKJIL_ROOT/wallpapers/$wp" ;;
esac

if [ ! -f "$wp" ]; then
  warn "배경화면 파일 없음: $wp — 건너뜀"
  return 0 2>/dev/null || exit 0
fi

uri="file://$wp"
gsettings set org.gnome.desktop.background picture-uri "$uri"
gsettings set org.gnome.desktop.background picture-uri-dark "$uri"
gsettings set org.gnome.desktop.background picture-options 'zoom'
ok "배경화면: $wp"
