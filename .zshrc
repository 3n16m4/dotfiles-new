alias l='ls -lh'

setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL

export PS1='%n %F{1}::%f %F{2}%~%f %F{4}'$'\U00BB''%f '
export EDITOR='vim'
export PATH="/Applications/CMake.app/Contents/bin":"$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/llvm/bin:$PATH"
