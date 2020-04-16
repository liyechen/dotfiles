# alias
alias docker_start="sudo systemctl start docker"
alias docker_stop="sudo systemctl stop docker"

alias monitor_start="sudo systemctl start netdata.service"
alias monitor_stop="sudo systemctl stop netdata.service"

alias vim="nvim"
alias vi="nvim"


# zshrc
alias zshconfig="nvim ~/.zshrc"
alias sourcezshrc="source ~/.zshrc"

# git
alias gl="git pull"
alias gck="git checkout"
alias gs="git status"
alias gd="git diff"
alias gpo="git push origin"
alias gpom="git push origin master"
alias gcb="git checkout -b"
alias gcm="git checkout master"
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gdem='git branch | grep -v "master" | xargs git branch -D '
alias grm='git rebase master'
alias grb='git rebase'


# terminal
alias c="clear"
alias open="xdg-open"

# nvidia
alias open_nvidia_drive="sudo tee /proc/acpi/bbswitch <<< ON"
alias close_nvidia_drive="sudo tee /proc/acpi/bbswitch <<< OFF"

# thefuck
eval $(thefuck --alias)

# blog
alias ssh-blog="ssh liyechen-blog"
alias update-blog="scp -P 8190 -r /home/haduluoke/Documents/LiyechenBlog/public/* liyechen@165.22.155.42:/home/liyechen/nginx/www/blog/"

alias pid_search="ps aux | grep"
alias process_search="ps -ef | grep"

# system
alias wifi="nmcli"
alias wifi-list="nmcli device wifi"
alias wifi-connect="nmcli device wifi connect"

# goto some folders
alias G_Drive="cd ~/GoogleDrive"

# toggle random alacritty theme
alias random_theme="alacritty-colorscheme -c ~/.config/alacritty/alacritty.yml -C ~/.config/alacritty/alacritty-theme/themes -T"
alias theme_name="alacritty-colorscheme -s"

# folder disk usage
alias folder_usage='du --summarize --human-readable *'

# exa
alias ls="exa"
alias ll="exa -l"
alias la="exa -la"

# docker
alias dke="docker exec -it"

extend_alias() {
    functions[_expand-aliases]=$@ 2>/dev/null
    if declare -f _expand-aliases >/dev/null; then
        print ${functions[_expand-aliases]#$'\t'}
        unset -f _expand-aliases
    else
        print $@
    fi
}
