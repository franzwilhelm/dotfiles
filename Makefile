export FLASH_TAR=flash_player_ppapi_linux.x86_64.tar.gz

# done with make pre_setup SHELL=/bin/bash
pre_setup:
	sudo apt-get update
	make git
	make zsh

everything:
	make setup
	make editors
	make browsers
	make media
	make devops

setup:
	make programming_languages
	make defaults
	make font-awesome
	make eOS
	make i3wm
programming_languages:
	make ruby
	make java
	make node
	make golang
	make scheme
	make python
editors:
	make atom
	make intellij
	make vim
browsers:
	make google_chrome
	make firefox
	make opera
media:
	sudo apt install -y redshift
	sudo apt install -y vlc
	sudo apt-get install -y shutter
devops:
	make postgres
	make gcloud
	make docker
optional:
	make flash_player
	make spotify
	make discord

# initial_setup >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
git:
	sudo apt-get install -y git
	git config --global user.email "franz.vonderlippe@gmail.com"
	git config --global user.name "Franz von der Lippe"
zsh:
	./setup.sh
defaults:
	sudo apt-get install -y snapd
	# make add-apt-repository possible etc...
	sudo apt-get install -y apt-transport-https
	sudo apt-get install -y ca-certificates
	sudo apt-get install -y curl
	sudo apt-get install -y gnupg-agent
	sudo apt-get install -y software-properties-common
	sudo apt-get install -y ppa-purge
	# key and window controls
	sudo apt-get install -y xbindkeys
	sudo apt-get install -y xdotool
	sudo apt-get install -y wmctrl
	# powerline fonts
	git clone https://github.com/powerline/fonts.git
	./fonts/install.sh
	rm -rf fonts
	# jq
	sudo apt-get install -y jq
	# ccat
	go get -u github.com/jingweno/ccat
	sudo npm install -g @rafaelrinaldi/whereami
	# for download-watcher
	sudo apt-get install inotify-tools
font-awesome:
	curl https://use.fontawesome.com/releases/v5.2.0/fontawesome-free-5.2.0-desktop.zip -o fa.zip
	unzip fa.zip
	sudo mkdir -p /usr/share/fonts/opentype/font-awesome
	sudo cp fontawesome-free-5.2.0-desktop/otfs/* /usr/share/fonts/opentype/font-awesome
	rm -rf fa.zip
	rm -rf fontawesome-free-5.2.0-desktop
eOS:
	rm -rf ~/Public ~/Templates
	sudo add-apt-repository -y ppa:philip.scott/elementary-tweaks
	sudo apt-get update
	sudo apt-get install -y elementary-tweaks
	# DCONF-EDITOR - for editing registry
	sudo apt-get install -y dconf-editor
i3wm:
	make i3-gaps
	sudo apt-get install -y scrot
	sudo apt-get install -y i3lock
	sudo apt-get install -y i3blocks
	sudo apt-get install -y imagemagick
	sudo apt-get install -y feh
	sudo apt-get install -y arandr
	sudo apt-get install -y rofi
	sudo apt-get install -y compton
	pip3 install autotiling
	make dunst-notifications
i3-gaps:
	sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev \
	libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
	python3 python3-pip python3-setuptools \
 	python3-wheel ninja-build \
	autoconf libxcb-xrm-dev
	git clone https://github.com/resloved/i3 /tmp/i3gaps
	cd /tmp/i3gaps && \
	autoreconf --force --install && \
	rm -rf build/ && \
	mkdir -p build && cd build/ && \
	../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers && \
	make && \
	sudo make install

dunst-notifications:
	sudo apt-get install -y libdbus-glib-1-dev libnotify-dev libxinerama-dev libxrandr-dev libxss-dev glibc-source libsdl-pango-dev libgtk-3-dev
	git clone https://github.com/dunst-project/dunst.git /tmp/dunst
	cd /tmp/dunst && \
	make && \
	sudo make install

# media >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
flash_player:
	sudo curl -O https://fpdownload.adobe.com/pub/flashplayer/pdc/26.0.0.151/$(FLASH_TAR)
	sudo tar -C /usr/local -xzf $(FLASH_TAR)
	rm $(FLASH_TAR)
spotify:
	sudo snap install spotify
discord:
	wget 'https://discordapp.com/api/download?platform=linux&format=deb' -o discord.deb
	sudo dpkg -i discord.deb

# programming_languages >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
golang:
	mkdir -p ~/PROGRAMMERING/GO
	curl -O https://storage.googleapis.com/golang/$(shell curl -s https://golang.org/dl/ | grep -oPm 1 'go[\d\.]+\d').linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf $(shell curl -s https://golang.org/dl/ | grep -oPm 1 'go[\d\.]+\d').linux-amd64.tar.gz
	sudo rm $(shell curl -s https://golang.org/dl/ | grep -oPm 1 'go[\d\.]+\d').linux-amd64.tar.gz
node:
	sudo apt-get install -y nodejs npm
	sudo npm i -g npm
	sudo npm i -g n
	sudo n stable
java:
	sudo apt-get install -y openjdk-11-jdk openjdk-11-jre
ruby:
	sudo apt-get install -y ruby
python:
	# python3 will be installed with eOS, but need pip3
	sudo apt-get install -y python3-pip

# editors >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
vim:
	sudo apt-get install -y vim
atom:
	sudo apt-get update -y && sudo apt install -y software-properties-common apt-transport-https wget
	wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
	sudo apt-get install -y atom
	apm install sync-settings
intellij:
	sudo snap install intellij-idea-ultimate --classic

latex:
	sudo apt-get install -y latexmk
	sudo apt-get install -y texlive-latex-recommended

# devops >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
postgres:
	sudo apt-get install -y curl ca-certificates gnupg && curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
	sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
	sudo apt-get update -y && sudo apt-get install -y postgresql-12 pgadmin4
gcloud:
	curl https://sdk.cloud.google.com | bash
	source $HOME/.zshrc
	gcloud init
	gcloud components install kubectl
docker:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-add-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	sudo apt-get update
	sudo apt-get install docker-ce

# browsers >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
google_chrome:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt-get update
	sudo apt-get install -y google-chrome-stable
firefox:
	sudo apt-get install -y firefox
opera:
	wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
	sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
	sudo apt install -y opera-stable

# reMarkable >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
reMarkable-setup:
	# Adding remarkable as a ssh-alias
	echo "host remarkable\n	Hostname $(hostname)\n	User root" >> ~/.ssh/config
	# Authenticating with reMarkable
	ssh-copy-id remarkable
	# Success!

reMarkable-templates:
	scp reMarkable/templates/* remarkable:/usr/share/remarkable/templates/

reMarkable-jagged-lines-fix:
	git -C /tmp/recept pull || git clone https://github.com/funkey/recept /tmp/recept
	/tmp/recept/install.sh
