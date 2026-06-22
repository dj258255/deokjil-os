# 20-accent — 강조색 (Ubuntu 24.04+ / GNOME 47+)

if ! has_gnome; then
  return 0 2>/dev/null || exit 0
fi

if [ -n "${DEOKJIL_ACCENT:-}" ]; then
  if gsettings writable org.gnome.desktop.interface accent-color >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.interface accent-color "$DEOKJIL_ACCENT"
    ok "강조색: $DEOKJIL_ACCENT"
  else
    warn "이 GNOME 버전은 accent-color 미지원(24.04+/GNOME47+ 필요) — 강조색 건너뜀"
  fi
fi
