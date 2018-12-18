#!/bin/bash

echo "This script will first install:"
echo "- node version manager"
echo "- the latest stable node version"
echo "- the updated npm version"
echo "- install and configure git"
echo "- create a bunch of aliases and utils for the cli"
read -n 1 -p  "Press any key to continue..."

sudo apt-get install git net-tools -y || exit 1;
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm ls-remote
nvm install stable
npm i -g npm
sudo setcap 'cap_net_bind_service=+ep' `which node`

echo "Changing max notify watcher from $(cat /proc/sys/fs/inotify/max_user_watches) to 524288 (max value)"
echo "fs.inotify.max_user_watches=524288" | sudo tee -a  /etc/sysctl.conf

read -p "Email for git config: " git_email
read -p "Full name for git config: " git_name

git config --global --replace-all user.email $git_email
git config --global --replace-all user.name $git_name
git config --global --replace-all credential.helper cache

git config --global --replace-all color.ui auto
git config --global --replace-all alias.b "branch -a"
git config --global --replace-all alias.aaa "add . --all && commit --amend --no-edit"
git config --global --replace-all alias.rbi "rebase upstream/master -i"
git config --global --replace-all alias.ph "push heroku master"
git config --global --replace-all alias.aa "add -A"
git config --global --replace-all alias.d "diff"
git config --global --replace-all alias.s "status"
git config --global --replace-all alias.co "checkout"
git config --global --replace-all alias.cp "cherry-pick"
git config --global --replace-all alias.ci "commit"
git config --global --replace-all alias.rb "rebase -i"
git config --global --replace-all alias.p "pull"
git config --global --replace-all alias.pp "push origin"
git config --global --replace-all alias.fa "fetch --all"
git config --global --replace-all alias.fu "fetch upstream"
git config --global --replace-all alias.rh "reset --hard"
git config --global --replace-all alias.mt "mergetool"
git config --global --replace-all core.editor "nano"
git config --global --replace-all push.default "tracking"
git config --global --replace-all alias.l "log --oneline --graph"

curl -o- https://raw.githubusercontent.com/zeachco/git-setup/master/bash_custom.sh > ~/bash_custom.sh
chmod +x ~/bash_custom.sh
echo "source ~/bash_custom.sh" >> ~/.bashrc

echo "Done with base script, install additionnal tools?"
echo ""
echo "This will install :"
echo "- shutter screenshoot tool"
echo "- slack chat client"
echo "- vscode text/ide"
echo ""
read -n 1 -p  "Press Ctrl-C to cancel, or any key to continue..."

sudo apt install shutter slack vscode -y
