#!/usr/bin/env bash
# common.sh — 공통 함수: 로깅 / 환경 감지 / 설정 로딩
# (각 스크립트에서 source 해서 쓴다)

# ── 로깅 (이모지 없이 ASCII 마커) ─────────────────────
log()  { printf '\033[0;36m%s\033[0m\n' "$*"; }
ok()   { printf '\033[0;32m[ok]\033[0m %s\n' "$*"; }
warn() { printf '\033[0;33m[!]\033[0m %s\n' "$*"; }
err()  { printf '\033[0;31m[x]\033[0m %s\n' "$*" >&2; }

# ── 환경 감지 ─────────────────────────────────────────
is_linux()  { [ "$(uname -s)" = "Linux" ]; }
# 리눅스 + gsettings + GNOME 스키마가 실제로 설치돼 있을 때만 true.
# (맥에도 Homebrew glib로 gsettings가 깔릴 수 있어 단순 command -v로는 오탐)
has_gnome() {
  is_linux && command -v gsettings >/dev/null 2>&1 &&
    gsettings list-schemas 2>/dev/null | grep -q '^org.gnome.desktop.interface$'
}
is_ubuntu() { is_linux && grep -qi ubuntu /etc/os-release 2>/dev/null; }

# ── 설정 로딩 ─────────────────────────────────────────
# default.conf 를 먼저, 그다음 사용자의 user.conf 가 있으면 덮어쓴다.
load_config() {
  : "${DEOKJIL_ROOT:?DEOKJIL_ROOT 미설정}"
  # shellcheck source=/dev/null
  source "$DEOKJIL_ROOT/config/default.conf"

  local user_conf="${XDG_CONFIG_HOME:-$HOME/.config}/deokjil/user.conf"
  if [ -f "$user_conf" ]; then
    # shellcheck source=/dev/null
    source "$user_conf"
    log "사용자 설정 적용: $user_conf"
  else
    warn "user.conf 없음 — 기본 설정 사용 (config/default.conf). customize.sh로 만들 수 있어요."
  fi
}
