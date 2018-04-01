# jshap's DankPad custom zshrc


# zsh command completion for primusrun and optirun
compdef _command primusrun optirun
alias primusrun="vblank_mode=0 primusrun"
#alias primusrun="PRIMUS_SYNC=1 primusrun"

export CHROME_BIN="/usr/bin/google-chrome-beta"

alias nvidia='primusrun nvidia-settings -c :8'

alias steam-wine='WINEDEBUG=-all primusrun wine ~/.wine/dosdevices/d:/steam/Steam.exe >/dev/null 2>&1 &'
