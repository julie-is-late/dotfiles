#!/bin/sh

cat ~/.config/Code/User/installed_extensions.txt | xargs -i{} code --install-extension {}
