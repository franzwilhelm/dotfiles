export SLACK_VERSION?=2.7.1
export SLACK_DEB=slack-desktop-$(SLACK_VERSION)-amd64.deb
export FLASH_TAR=flash_player_ppapi_linux.x86_64.tar.gz
export GO_VERSION?=1.9
export GO_TAR=go$(GO_VERSION).linux-amd64.tar.gz
export IJ_VERSION?=2017.2.2
export IJ_TAR=ideaIU-$(IJ_VERSION).tar.gz

profile:
	- sudo mv profile.template ~/.profile

defaults:
	- sudo apt-get update
	# make add-apt-repository possible
	- sudo apt install software-properties-common
	- sudo apt-get install -y ppa-purge
	# key and window controls
	- sudo apt-get install -y xbindkeys
	- sudo apt-get install -y xdotool
	- sudo apt-get install -y wmctrl
	# interactive sudo
	- sudo apt-get install -y gksu

zsh:
	- sudo apt-get install -y zsh
	- sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	- echo "source ~/.profile" >> ~/.zshrc
	- sudo chsh -s $(which zsh)

eOS:
	- rm -rf ~/Public ~/Templates
	- sudo add-apt-repository ppa:philip.scott/elementary-tweaks
	- sudo apt-get update
	- sudo apt-get install -y elementary-tweaks
	# save battery and prevent samba
	- sudo apt install -y tlp tlp-rdw
	- sudo chmod 744 /usr/lib/gvfs/gvfsd-smb-browse
	# DCONF-EDITOR - for editing registry
	- sudo apt-get install -y dconf-editor

i3_:
	- sudo apt-get install -y scrot
	- sudo apt-get install -y i3lock
	- sudo apt-get install -y i3blocks
	- sudo apt-get install -y imagemagick
	- sudo apt-get install -y feh
	- sudo apt-get install -y arandr
	- sudo apt-get install -y rofi
	- sudo apt-get install -y compton

slack:
	- curl -O https://downloads.slack-edge.com/linux_releases/$(SLACK_DEB)
	- sudo dpkg -i $(SLACK_DEB)
	- sudo rm $(SLACK_DEB)

media:
	- sudo apt install -y redshift
	- sudo apt install -y vlc
	- sudo apt-get install -y shutter
	# FLASH PLAYER
	- sudo curl -O https://fpdownload.adobe.com/pub/flashplayer/pdc/26.0.0.151/$(FLASH_TAR)
	- sudo tar -C /usr/local -xzf $(FLASH_TAR)
	- rm $(FLASH_TAR)

ruby:
	- sudo apt-get install ruby

java:
	- sudo apt-get install default-jdk
	- sudo add-apt-repository ppa:webupd8team/java
	- sudo apt-get update
	- sudo apt-get install oracle-java9-installer

node:
	- curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
	- source ~/.zshrc
	- nvm install node
	- npm install --global vue-cli

golang:
	- sudo mkdir -p ~/PROGRAMMERING/GO
	- sudo curl -O https://storage.googleapis.com/golang/$(GO_TAR)
	- sudo tar -C /usr/local -xzf $(GO_TAR)
	- sudo rm $(GO_TAR)

scheme:
	- sudo mkdir -p ~/PROGRAMMERING/GO
	- sudo curl -O https://storage.googleapis.com/golang/$(GO_TAR)
	- sudo tar -C /usr/local -xzf $(GO_TAR)
	- sudo rm $(GO_TAR)

gcloud:
	- curl https://sdk.cloud.google.com | bash
	- source ~/.zshrc
	- gcloud init

editors:
	# ATOM
	- sudo add-apt-repository ppa:webupd8team/atom
	- sudo apt-get update
	- sudo apt-get install atom
	# INTELLIJ - requires install by going to /usr/local/your_ij_installation/bin and running ./install.sh
	- sudo curl -O https://download-cf.jetbrains.com/idea/$(IJ_TAR)
	- sudo tar -C /usr/local -xzf $(IJ_TAR)
	- sudo rm $(IJ_TAR)
	# VIM
	- sudo apt-get install vim

databases:
	# POSTGRES
	- sudo apt-get install postgresql postgresql-contrib
	# MYSQL
	- sudo apt-get install mysql-client mysql-server

browsers:
	- sudo apt-get update
	# CHROMIUM
	- sudo apt-get install -y chromium-browser
	# GOOGLE CHROME
	- wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	- sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	- sudo apt-get update
	- sudo apt-get install -y google-chrome-stable
	# FIREFOX
	- sudo apt-get install -y firefox
	# OPERA
	- wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
	- sudo sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
	- sudo apt-get update
	- sudo apt-get install -y opera
