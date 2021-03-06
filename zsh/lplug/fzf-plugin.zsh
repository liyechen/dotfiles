if (( $+commands[fzf] )) && [[ $- =~ i ]]; then
    set -- '--color=fg:-1,bg:-1,hl:#7d8acc,fg+:15,bg+:#383c4a,hl+:#7d8acc' \
    '--color=gutter:-1,info:2,prompt:12,pointer:1,marker:3,spinner:12,header:12,border:#d3dae3' \
    '--bind=ctrl-t:top,change:top'

    FZF_DEFAULT_OPTS=$*

    if (( $+commands[xsel] )); then
        FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS,ctrl-y:'execute-silent(echo {} | xsel -i -b)'"
    elif (( $+commands[xclip] )); then
        FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS,ctrl-y:'execute-silent(echo {} | xclip -i -selection clipboard)'"
    fi

    export FZF_DEFAULT_OPTS

    if [[ -n $TMUX ]] && (( $+commands[fzf-tmux-popup] )); then
        FZF_CMD=$commands[fzf-tmux-popup]
    else
        FZF_CMD=$commands[fzf]
    fi

    _fzf_fpath=${0:h}/fzf
    fpath+=$_fzf_fpath
    autoload -U $_fzf_fpath/*(.:t)
    unset _fzf_fpath

    fzf-redraw-prompt() {
        local precmd
        for precmd in $precmd_functions; do
            $precmd
        done
        zle reset-prompt
    }
    zle -N fzf-redraw-prompt

    zle -N fzf-find-widget
    bindkey '^T' fzf-find-widget

    fzf-cd-widget() {
        local tokens=(${(z)LBUFFER})
        if (( $#tokens <= 1 )); then
            zle fzf-find-widget 'only_dir'
            if [[ -d $LBUFFER ]]; then
                cd $LBUFFER
                local ret=$?
                LBUFFER=
                zle fzf-redraw-prompt
                return $ret
            fi
        fi
    }
    zle -N fzf-cd-widget
    bindkey '\ec' fzf-cd-widget

    fzf-history-widget() {
        local num=$(fhistory $LBUFFER)
        local ret=$?
        if [[ -n $num ]]; then
            zle vi-fetch-history -n $num
        fi
        zle reset-prompt
        return $ret
    }
    zle -N fzf-history-widget
    bindkey '^R' fzf-history-widget

    fzf-z-cd-widget() {
        local dir=$(fzi)
        if [[ -z $dir ]]; then
            zle redisplay
            return 0
        fi
        cd $dir
        local ret=$?
        zle fzf-redraw-prompt
        return $ret
    }
    zle -N fzf-z-cd-widget
    bindkey '^G' fzf-z-cd-widget

    fzf-z-stack-widget() {
        local dir=$(fzs)
        if [[ -z $dir ]]; then
            zle redisplay
            return 0
        fi
        cd $dir
        local ret=$?
        zle fzf-redraw-prompt
        return $ret
    }
    zle -N fzf-z-stack-widget
    bindkey '^S' fzf-z-stack-widget

    zle -N fzf-completion-widget
    bindkey '^I' fzf-completion-widget
fi
