export SLACK_VERSION?=3.2.1
export SLACK_DEB=slack-desktop-$(SLACK_VERSION)-amd64.deb
export FLASH_TAR=flash_player_ppapi_linux.x86_64.tar.gz
export GO_VERSION?=1.10.3
export GO_TAR=go$(GO_VERSION).linux-amd64.tar.gz
export IJ_VERSION?=2017.2.2
export IJ_TAR=ideaIU-$(IJ_VERSION).tar.gz
export ZSH_CUSTOM=~/.oh-my-zsh/custom

initial_setup:
	- make defaults
	- make eOS
	- make zsh
	- make profile
	- make i3wm
programming_languages:
	- make ruby
	- make java
	- make node
	- make golang
	- make scheme
editors:
	- make atom
	- make intellij
	- make vim
browsers:
	- make chromium
	- make google_chrome
	- make firefox
	- make opera
media:
	- sudo apt install -y redshift
	- sudo apt install -y vlc
	- sudo apt-get install -y shutter
	- make flash_player
	- make spotify
	- make slack
devops:
	- make databases
	- make gcloud
	- make docker
	- make drone

# initial_setup >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
	# powerline fonts
	- git clone https://github.com/powerline/fonts.git
	- ./fonts/install.sh
	- rm -rf fonts
	# jq
	- sudo apt-get install -y jq
	# ccat
	- go get -u github.com/jingweno/ccat
font-awesome:
	- curl https://use.fontawesome.com/releases/v5.2.0/fontawesome-free-5.2.0-desktop.zip -o fa.zip
	- unzip fa.zip
	- sudo mkdir -p /usr/share/fonts/opentype/font-awesome
	- sudo cp fontawesome-free-5.2.0-desktop/otfs/* /usr/share/fonts/opentype/font-awesome
	- rm -rf fa.zip
	- rm -rf fontawesome-free-5.2.0-desktop
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
zsh:
	- sudo apt-get install -y zsh
	- sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	- sudo chsh -s $(which zsh)
	- git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM}/themes/spaceship-prompt
	- ln -s ${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM}/themes/spaceship.zsh-theme
	- git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM}/plugins/zsh-alias-tips
	- git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM}/plugins/zsh-history-substring-search
	- git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
	- git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git:
	- sudo apt-get install -y git
	- git config --global user.email "franz.vonderlippe@gmail.com"
	- git config --global user.name "Franz von der Lippe"
profile:
	- cp profile.template ~/.profile
	- cp zshrc.template ~/.zshrc
i3wm:
	- sudo apt-get install -y scrot
	- sudo apt-get install -y i3lock
	- sudo apt-get install -y i3blocks
	- sudo apt-get install -y imagemagick
	- sudo apt-get install -y feh
	- sudo apt-get install -y arandr
	- sudo apt-get install -y rofi
	- sudo apt-get install -y compton
	- touch ~/.config/gtk-3.0/gtk.css
	- echo ".window-frame { box-shadow: none; margin: 0; }" > ~/.config/gtk-3.0/gtk.css

# media >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
flash_player:
	- sudo curl -O https://fpdownload.adobe.com/pub/flashplayer/pdc/26.0.0.151/$(FLASH_TAR)
	- sudo tar -C /usr/local -xzf $(FLASH_TAR)
	- rm $(FLASH_TAR)
spotify:
	- sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
	- echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	- sudo apt-get update -y
	- sudo apt-get install -y spotify-client
slack:
	- curl -O https://downloads.slack-edge.com/linux_releases/$(SLACK_DEB)
	- sudo dpkg -i $(SLACK_DEB)
	- sudo rm $(SLACK_DEB)

# programming_languages >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
golang:
	- sudo mkdir -p ~/PROGRAMMERING/GO
	- sudo curl -O https://storage.googleapis.com/golang/$(GO_TAR)
	- sudo tar -C /usr/local -xzf $(GO_TAR)
	- sudo rm $(GO_TAR)
node:
	- curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
	- source ~/.zshrc
	- nvm install node
	- npm install --global vue-cli
java:
	- sudo apt-get install default-jdk
	- sudo add-apt-repository ppa:webupd8team/java
	- sudo apt-get update
	- sudo apt-get install oracle-java9-installer
ruby:
	- sudo apt-get install ruby
scheme:
	- sudo add-apt-repository ppa:plt/racket
	- sudo apt-get update
	- sudo apt-get install racket
python:
	# python3 will be installed with eOS, but need pip3
	- sudo apt-get install python3-pip

# editors >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
vim:
	- sudo apt-get install -y vim
atom:
	- sudo add-apt-repository ppa:webupd8team/atom
	- sudo apt-get update
	- sudo apt-get install -y atom
	- apm install sync-settings
intellij:
	# requires install by going to /usr/local/your_ij_installation/bin and running ./install.sh
	- sudo curl -O https://download-cf.jetbrains.com/idea/$(IJ_TAR)
	- sudo tar -C /usr/local -xzf $(IJ_TAR)
	- sudo rm $(IJ_TAR)
latex:
	- sudo apt-get install -y latexmk
	- sudo apt-get install -y texlive-latex-recommended

# devops >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
databases:
	# POSTGRES
	- sudo echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list
	- sudo apt-get install -y postgresql-9.6 postgresql-contrib
	# MYSQL
	- sudo apt-get install -y mysql-client mysql-server
gcloud:
	- curl https://sdk.cloud.google.com | bash
	- gcloud init
	- gcloud components install kubectl
docker:
	- sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	- sudo chmod +x /usr/local/bin/docker-compose
	- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	- sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	- sudo apt-get update
	- sudo apt-get install -y docker-ce
drone:
	- curl -L https://github.com/drone/drone-cli/releases/download/v0.8.5/drone_linux_amd64.tar.gz | tar zx
	- sudo install -t /usr/local/bin drone

# browsers >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
chromium:
	- sudo apt-get install -y chromium-browser
google_chrome:
	- wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	- sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	- sudo apt-get update
	- sudo apt-get install -y google-chrome-stable
firefox:
	- sudo apt-get install -y firefox
opera:
	- wget http://download4.operacdn.com/ftp/pub/opera/desktop/40.0.2308.62/linux/opera-stable_40.0.2308.62_amd64.deb
	- sudo apt install apt-transport-https libcurl3
	- sudo dpkg -i opera-stable*.deb
