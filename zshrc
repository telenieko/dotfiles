autoload -U compinit zrecompile

_zshrc_main () {
    local zsh_cache zshrc_snipplet
    setopt extended_glob

    zsh_cache=${HOME}/.zsh_cache
    if [ ! -d $zsh_cache ]; then
      mkdir $zsh_cache
    fi

    if [ $UID -eq 0 ]; then
        compinit
    else
        compinit -d $zsh_cache/zcomp-$HOST

        for f in ~/.zshrc $zsh_cache/zcomp-$HOST; do
            zrecompile -p $f && rm -f $f.zwc.old
        done
    fi

    for zshrc_snipplet in ~/.zsh/[0-9][0-9][^.]#; do
        source $zshrc_snipplet
    done
}
_zshrc_main

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

if [ -f ~/.profile.local ]; then
    source ~/.profile.local
fi
