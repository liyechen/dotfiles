source "$(cd -P "$(dirname "$0")" && pwd -P)/../base.sh"

do_install() {
    link_file "$src_conf/tigrc" "${ZDOTDIR:-$HOME}/.tigrc"
}

install

