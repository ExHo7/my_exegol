#!/bin/bash
# Installing my_exegol resources
set -euo pipefail

REPO_URL="https://github.com/ExHo7/my_exegol.git"
RESOURCES_DIR="$HOME/.exegol/my-resources/setup/"
MYRES_BIN="$HOME/.exegol/my-resources/bin"
TMP_DIR=""

# Colored output helpers
info()  { echo -e "\033[1;34m[*]\033[0m $*"; }
ok()    { echo -e "\033[1;32m[+]\033[0m $*"; }
error() { echo -e "\033[1;31m[-]\033[0m $*" >&2; }

# Cleanup temp clone on exit (success or failure)
cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
  fi
}
trap cleanup EXIT

# Report the failing line on error
on_error() {
  error "Installation failed (line $1). Aborting."
  exit 1
}
trap 'on_error $LINENO' ERR

# Check required commands are available
for cmd in git cp wget; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    error "Required command not found: $cmd"
    exit 1
  fi
done

info "Installing resources..."

# Clone repo into an isolated temp directory
TMP_DIR="$(mktemp -d)"
info "Cloning repository..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR/my_exegol"
cd "$TMP_DIR/my_exegol"

# Ensure target directories exist
mkdir -p "$RESOURCES_DIR/tmux" "$RESOURCES_DIR/zsh" "$RESOURCES_DIR/apt" "$MYRES_BIN"

# Copy configuration files
info "Copying configuration files..."
cp conf/tmux.conf "$RESOURCES_DIR/tmux/tmux.conf"
cp conf/aliases   "$RESOURCES_DIR/zsh/aliases"
cp conf/apt-packages.list "$RESOURCES_DIR/apt/packages.list"
cp bash/load_user_setup.sh "$RESOURCES_DIR/load_user_setup.sh"
chmod +x "$RESOURCES_DIR/load_user_setup.sh"

# Deploy the prebuilt Sliver GUI binary onto the container PATH.
# ~/.exegol/my-resources/bin is mounted as /opt/my-resources/bin, which Exegol
# adds to PATH in every container, so 'sliver-gui' becomes directly callable.
if [ -f bin/sliver-gui ]; then
  info "Installing Sliver GUI binary..."
  cp bin/sliver-gui "$MYRES_BIN/sliver-gui"
  chmod +x "$MYRES_BIN/sliver-gui"
else
  error "bin/sliver-gui not found in the repository (did you commit and push it?). Skipping."
fi

ok "Resources successfully installed !"
