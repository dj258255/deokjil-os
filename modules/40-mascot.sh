# 40-mascot — 마스코트 (선택). 비우면 중립 기본 = 사용자의 자유.
#
# 특정 캐릭터를 강제하지 않는다. 사용자가 mascots/<이름>/ 으로 팩을 넣고
# user.conf에 DEOKJIL_MASCOT="<이름>"을 지정하면 적용된다.

if [ -z "${DEOKJIL_MASCOT:-}" ]; then
  log "마스코트 미설정(중립 기본). mascots/ 에 팩을 추가하고 user.conf에서 지정하세요."
  return 0 2>/dev/null || exit 0
fi

pack="$DEOKJIL_ROOT/mascots/$DEOKJIL_MASCOT"
if [ ! -d "$pack" ]; then
  warn "마스코트 팩 없음: $pack — 건너뜀"
  return 0 2>/dev/null || exit 0
fi

dest="${XDG_DATA_HOME:-$HOME/.local/share}/deokjil/mascot"
mkdir -p "$dest"
cp -r "$pack/." "$dest/" 2>/dev/null
ok "마스코트 적용: $DEOKJIL_MASCOT → $dest"

# 프로필 사진(avatar.png 있으면 .face로)
if [ -f "$pack/avatar.png" ]; then
  cp "$pack/avatar.png" "$HOME/.face" 2>/dev/null && ok "프로필 사진(.face) 설정"
fi

# 팩에 wallpaper가 있고 사용자가 따로 배경을 지정 안 했으면 그걸 배경으로
if [ -z "${DEOKJIL_WALLPAPER:-}" ] && [ -f "$dest/wallpaper.png" ] && has_gnome; then
  uri="file://$dest/wallpaper.png"
  gsettings set org.gnome.desktop.background picture-uri "$uri"
  gsettings set org.gnome.desktop.background picture-uri-dark "$uri"
  ok "마스코트 팩 배경화면 적용"
fi

log "움직이는 데스크톱 펫을 원하면: 'sudo apt install oneko && oneko' 또는 conky 위젯을 별도로 설정하세요."
