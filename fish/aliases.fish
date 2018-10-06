alias autobrew "brew update; and brew outdated | awk ' {print $1} ' | xargs brew upgrade; and brew cleanup"
alias macchange "sudo ifconfig en0 ether $MAC_ADDRESS"
alias pythonserver "python3 -m http.server 9290 --bind 127.0.0.1"
alias autoclean "rm -r ~/.electron; rm -r node_modules/electron-prebuilt"
