#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/proot-tool"

C_RESET='\033[0m'; C_BLUE='\033[1;34m'; C_GREEN='\033[1;32m'; C_YELLOW='\033[1;33m'; C_RED='\033[1;31m'
info(){ printf "%b[INFO]%b %s\n" "$C_BLUE" "$C_RESET" "$*"; }
ok(){ printf "%b[OK]%b %s\n" "$C_GREEN" "$C_RESET" "$*"; }
warn(){ printf "%b[WARN]%b %s\n" "$C_YELLOW" "$C_RESET" "$*"; }
fail(){ printf "%b[ERROR]%b %s\n" "$C_RED" "$C_RESET" "$*" >&2; exit 1; }

[[ -n "${PREFIX:-}" && "$PREFIX" == *com.termux* ]] || fail "Run this installer inside Termux."
command -v pkg >/dev/null 2>&1 || fail "Termux package manager 'pkg' was not found."

info "Updating Termux repositories..."
pkg update -y
info "Installing required packages..."
pkg install -y proot-distro git curl wget tar

mkdir -p "$BIN_DIR" "$CONFIG_DIR"
install -m 755 "$PROJECT_DIR/bin/proot-tool" "$BIN_DIR/proot-tool"
install -m 644 "$PROJECT_DIR/config/default.conf" "$CONFIG_DIR/default.conf"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    printf '\n# Termux Proot Distro Tool\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$HOME/.bashrc"
    warn "Added ~/.local/bin to PATH in ~/.bashrc."
    ;;
esac

ok "Installation complete."
printf '\nRun now:\n  %s\n\n' "$BIN_DIR/proot-tool"
printf 'Later, reopen Termux or run:\n  source ~/.bashrc\n  proot-tool\n'
