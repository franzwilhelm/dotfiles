SHELL := /usr/bin/zsh
export FLASH_TAR=flash_player_ppapi_linux.x86_64.tar.gz
export ZSH_CUSTOM=~/.oh-my-zsh/custom

# done with make pre_setup SHELL=/bin/bash
pre_setup:
	sudo apt-get update
	make git
	make zsh
	make profile

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
	- make ruby
	- make java
	- make node
	- make golang
	- make scheme
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
	sudo apt-get install zsh
	curl -fsSLo install-zsh.sh "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
	chmod +x $(shell pwd)/install-zsh.sh
	RUNZSH=no ./install-zsh.sh
	rm $(shell pwd)/install-zsh.sh
	git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM}/themes/spaceship-prompt
	ln -s ${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM}/themes/spaceship.zsh-theme
	git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM}/plugins/alias-tips
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM}/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
profile:
	cp profile.template ~/.profile
	cp zshrc.template ~/.zshrc
	zsh
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
	sudo apt-get install -y i3
	sudo apt-get install -y scrot
	sudo apt-get install -y i3lock
	sudo apt-get install -y i3blocks
	sudo apt-get install -y imagemagick
	sudo apt-get install -y feh
	sudo apt-get install -y arandr
	sudo apt-get install -y rofi
	sudo apt-get install -y compton
	touch ~/.config/gtk-3.0/gtk.css
	echo ".window-frame { box-shadow: none; margin: 0; }" > ~/.config/gtk-3.0/gtk.css
	make dunst-notifications
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
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update -y
	sudo apt-get install -y spotify-client
discord:
	wget 'https://discordapp.com/api/download?platform=linux&format=deb' -o discord.deb
	sudo dpkg -i discord.deb

# programming_languages >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
golang:
	mkdir -p ~/PROGRAMMERING/GO
	curl -O https://storage.googleapis.com/golang/$(shell curl -s https://golang.org/dl/ | grep -oPm 1 'go[\d\.]+\d').linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf $(GO_TAR)
	sudo rm $(GO_TAR)
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
