#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias vlc='QT_QPA_PLATFORM=wayland vlc'

export PATH=$PATH:/home/felip/.spicetify

. "$HOME/.local/share/../bin/env"
eval "$(starship init bash)"
alias tty-clock='tty-clock -c -s -C 7'

fastfetch() {
    local imgs=(/home/felip/fastfetch-images/bordered/lain*.jpeg)
    local img=${imgs[$RANDOM % ${#imgs[@]}]}
    local tmp_config=/tmp/fastfetch-random.jsonc

    python3 -c "
import json
with open('/home/felip/.config/fastfetch/config.jsonc') as f:
    data = json.load(f)
data['logo']['source'] = '$img'
with open('$tmp_config', 'w') as f:
    json.dump(data, f, indent=4)
"
    command fastfetch --config "$tmp_config" "$@"
}

fastfetch
. "$HOME/.cargo/env"
export PATH="$(npm config get prefix)/bin:$PATH"
