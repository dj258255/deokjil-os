#!/usr/bin/env bash
# customize.sh — 대화형 커스터마이저. user.conf를 만들고 즉시 적용할 수 있다.
# 맥에서도 설정 편집은 가능(적용만 우분투에서).
set -uo pipefail

export DEOKJIL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/common.sh
source "$DEOKJIL_ROOT/lib/common.sh"

USER_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/deokjil/user.conf"

# 현재 값 로드(없으면 기본값). 모든 DEOKJIL_* 변수가 채워진다.
load_config >/dev/null 2>&1 || source "$DEOKJIL_ROOT/config/default.conf"

save_conf() {
  mkdir -p "$(dirname "$USER_CONF")"
  cat > "$USER_CONF" <<EOF
# Deokjil OS 사용자 설정 (customize.sh가 생성)
DEOKJIL_DARK="${DEOKJIL_DARK}"
DEOKJIL_GTK_THEME="${DEOKJIL_GTK_THEME}"
DEOKJIL_ICON_THEME="${DEOKJIL_ICON_THEME}"
DEOKJIL_ACCENT="${DEOKJIL_ACCENT}"
DEOKJIL_WALLPAPER="${DEOKJIL_WALLPAPER}"
DEOKJIL_MASCOT="${DEOKJIL_MASCOT}"
EOF
  ok "저장됨: $USER_CONF"
}

while true; do
  echo
  log "===== Deokjil OS 커스터마이저 ====="
  echo "  1) 다크 모드   : ${DEOKJIL_DARK}"
  echo "  2) GTK 테마     : ${DEOKJIL_GTK_THEME:-(기본)}"
  echo "  3) 아이콘 테마  : ${DEOKJIL_ICON_THEME:-(기본)}"
  echo "  4) 강조색       : ${DEOKJIL_ACCENT:-(기본)}"
  echo "  5) 배경화면     : ${DEOKJIL_WALLPAPER:-(없음)}"
  echo "  6) 마스코트     : ${DEOKJIL_MASCOT:-(없음)}"
  echo "  s) 저장    a) 저장+적용    q) 종료"
  printf "> 선택: "
  read -r choice
  case "$choice" in
    1) printf "다크 모드 (true/false): "; read -r DEOKJIL_DARK ;;
    2) printf "GTK 테마 이름 (빈칸=기본): "; read -r DEOKJIL_GTK_THEME ;;
    3) printf "아이콘 테마 이름 (빈칸=기본): "; read -r DEOKJIL_ICON_THEME ;;
    4) printf "강조색 (blue/teal/green/yellow/orange/red/pink/purple/slate): "; read -r DEOKJIL_ACCENT ;;
    5) echo "  wallpapers/:"; ls "$DEOKJIL_ROOT/wallpapers" 2>/dev/null | grep -vi readme || echo "   (비어있음)"
       printf "배경 파일명 또는 절대경로 (빈칸=변경안함): "; read -r DEOKJIL_WALLPAPER ;;
    6) echo "  mascots/:"; (ls -d "$DEOKJIL_ROOT"/mascots/*/ 2>/dev/null | xargs -n1 basename 2>/dev/null) || echo "   (없음)"
       printf "마스코트 팩 이름 (빈칸=없음): "; read -r DEOKJIL_MASCOT ;;
    s|S) save_conf ;;
    a|A) save_conf; bash "$DEOKJIL_ROOT/apply.sh" ;;
    q|Q) break ;;
    *) warn "알 수 없는 선택: $choice" ;;
  esac
done
