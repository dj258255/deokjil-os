#!/usr/bin/env bash
# apply.sh — 현재 설정(config)을 외형에 적용한다 (패키지 설치는 안 함, sudo 불필요).
set -uo pipefail

export DEOKJIL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/common.sh
source "$DEOKJIL_ROOT/lib/common.sh"

log "Deokjil OS — 설정 적용"
load_config

if ! has_gnome; then
  warn "여기는 GNOME 환경이 아니에요(gsettings 없음). 우분투 GNOME에서 실행해야 실제로 적용됩니다."
  warn "지금은 설정 로딩만 확인합니다."
fi

# 모듈을 번호순으로 source (로그 함수·설정값 공유)
for module in "$DEOKJIL_ROOT"/modules/*.sh; do
  # shellcheck source=/dev/null
  source "$module"
done

ok "적용 완료. (일부 항목은 로그아웃/재로그인 후 반영될 수 있어요.)"
