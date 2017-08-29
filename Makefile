profile:
	- sudo mv profile.template $(HOME)/.profile 

defaults:
	- sudo apt-get update
	- sudo apt-get upgrade
	# make add-apt-repository possible
	- sudo apt install software-properties-common
	- sudo apt-get install ppa-purge
	# key and window controls	
	- sudo apt-get install xbindkeys
	- sudo apt-get install xdotool
	- sudo apt-get install wmctrl
	# interactive sudo 
	- sudo apt-get install gksu
	# ohmyzsh
	- sudo apt-get install zsh
	- sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	- cat "source $HOME/.profile" >> $(HOME)/.zshrc
	- sudo chsh -s $(which zsh)

eOS:
	- rm -rf $(HOME)/Public $(HOME)/Templates
	- sudo add-apt-repository ppa:philip.scott/elementary-tweaks
	- sudo apt-get update
	- sudo apt-get install elementary-tweaks
	# save battery and prevent samba
	- sudo apt install tlp tlp-rdw
	- sudo chmod 744 /usr/lib/gvfs/gvfsd-smb-browse
	# DCONF-EDITOR - for editing registry
	- sudo apt-get install dconf-editor

i3:
	- sudo apt-get install scrot
	- sudo apt-get install i3lock
	- sudo apt-get install imagemagick

export SLACK_VERSION?=2.7.1
export SLACK_DEB=slack-desktop-$(SLACK_VERSION)-amd64.deb
media:
	# SLACK
	- curl -O https://downloads.slack-edge.com/linux_releases/$(SLACK_DEB)
	- sudo dpkg -i $(SLACK_DEB)
	- sudo rm $(SLACK_DEB)
	# REDSHIFT
	- sudo apt install redshift
	# VLC
	- sudo apt install vlc
	# SHUTTER
	- sudo apt-get install shutter
	- sudo apt-get install i3blocks
	- sudo apt-get install fonts-font-awesome
	- sudo apt-get install compton

export GO_VERSION?=1.9
export GO_TAR=go$(GO_VERSION).linux-amd64.tar.gz
programming-languages:
	# JAVA
	- sudo apt-get install default-jdk
	- sudo add-apt-repository ppa:webupd8team/java
	- sudo apt-get update
	- sudo apt-get install oracle-java9-installer
	# GOLANG
	- sudo mkdir -p $(HOME)/PROGRAMMERING/GO
	- sudo curl -O https://storage.googleapis.com/golang/$(GO_TAR)
	- sudo tar -C /usr/local -xzf $(GO_TAR)
	- sudo rm $(GO_TAR)
	# NODEJS & NPM
	- curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
	- sudo apt-get install -y nodejs
	- sudo apt-get install npm
	- sudo npm install --global vue-cli

export IJ_VERSION?=2017.2.2
export IJ_TAR=ideaIU-$(IJ_VERSION).tar.gz
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
	- sudo apt-get install chromium-browser
	# GOOGLE CHROME
	- wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	- sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	- sudo apt-get update 
	- sudo apt-get install google-chrome-stable
	# FIREFOX
	- sudo apt-get install firefox
	# OPERA
	- wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
	- sudo sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
	- sudo apt-get update 
	- sudo apt-get install opera

