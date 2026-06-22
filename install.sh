#!/usr/bin/env bash
# install.sh — 패키지 설치(apt) 후 외형 적용. 우분투/데비안 계열에서 실행.
set -uo pipefail

export DEOKJIL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/common.sh
source "$DEOKJIL_ROOT/lib/common.sh"

log "Deokjil OS — 설치 (패키지 + 적용)"

if ! is_linux; then
  err "리눅스에서 실행하세요 (현재: $(uname -s)). 맥에선 customize.sh로 설정만 편집할 수 있어요."
  exit 1
fi

# 패키지 설치
if command -v apt >/dev/null 2>&1; then
  list="$DEOKJIL_ROOT/packages/base.list"
  pkgs="$(grep -vE '^\s*#|^\s*$' "$list" | tr '\n' ' ')"
  log "설치할 패키지: $pkgs"
  sudo apt update
  # shellcheck disable=SC2086
  sudo apt install -y $pkgs && ok "패키지 설치 완료" || warn "일부 패키지 설치 실패 — 계속 진행"
else
  warn "apt 없음 — 패키지 설치 건너뜀(우분투/데비안 계열에서 실행하세요)"
fi

# 외형 적용
bash "$DEOKJIL_ROOT/apply.sh"
