#!/usr/bin/env bash

DOTFILES_ROOT=$(cd -P "$(dirname "$0")" && pwd -P)

chmod +x ./**/**.sh

echo $DOTFILES_ROOT

find "$DOTFILES_ROOT" -name '*install.sh' -executable -type f -exec {} \;

