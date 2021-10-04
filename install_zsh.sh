#!/bin/bash

systemInfo=`cat /proc/version`
if [[ $systemInfo =~ "Ubuntu" ]]
then
	echo "contains"
	packageCommand="apt"
elif [[ $systemInfo =~ "Centos" ]]; then
	#statements
	echo "not contains"
	packageCommand="yum"
fi

sudo $packageCommand install -y zsh 

sudo $packageCommand install -y git 

sudo $packageCommand install -y curl


/bin/bash zsh/install_zsh_official.sh

sudo chsh -s /bin/zsh

git clone git@github.com:lixiangyang09/.dotfile.git

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

cp .dotfile/zsh/.zshrc ~
cp .dotfile/zsh/my-theme.zsh-theme ~/.oh-my-zsh/themes
source ~/.zshrc
