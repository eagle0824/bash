#! /bin/bash
rm -rf ~/.config/SogouPY* ~/.config/sogou*
pidof fcitx | xargs kill
pidof sogou-qimpanel | xargs kill
nohup fcitx  1>/dev/null 2>/dev/null &
nohup sogou-qimpanel  1>/dev/null 2>/dev/null &
