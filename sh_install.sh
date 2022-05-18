#!/usr/bin/bash
# License: GNU GPLv3
# Designed for Pop_OS! 22.04
# Run from your home directory (cd ~) and as root (sudo bash sh_install.sh)
sudo apt update
sudo apt upgrade -y
# Overcomes "dpkg was interrupted, you must manually run 'sudo dpkg --configure -a' to correct the problem" error
# sudo dpkg --configure -a


# Download and install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh -O miniconda.sh
sudo bash miniconda.sh -b -p miniconda
rm miniconda.sh
miniconda/bin/conda init
miniconda/bin/conda config --add channels conda-forge


# Install base R (https://cloud.r-project.org/bin/linux/ubuntu/)
# update indices
sudo apt update -qq
# install two helper packages we need
sudo apt install -y software-properties-common dirmngr 
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" -y
sudo apt update
# Install R
sudo apt install r-base r-base-dev -y
# Removed these from install because they broke things 
# echo "deb https://ppa.launchpadcontent.net/c2d4u.team/c2d4u4.0+/ubuntu/ focal main" > /etc/apt/sources.list.d/c2d4u_team-ubuntu-c2d4u4_0_-jammy.list
# apt update

# Install R dependencies (https://blog.zenggyu.com/en/post/2018-01-29/installing-r-r-packages-e-g-tidyverse-and-rstudio-on-ubuntu-linux/)
# required by tidyverse
sudo apt install -y libcurl4-openssl-dev libssl-dev libxml2-dev
# required by r-base-core
sudo apt install -y zip unzip libpaper-utils xdg-utils libbz2-1.0 libc6 libcairo2 libcurl4 libglib2.0-0 libgomp1 libicu70 libjpeg8 liblzma5 libpango-1.0-0 libpangocairo-1.0-0 libpcre2-8-0 libpng16-16 libreadline8 libtcl8.6 libtiff5 libtirpc3 libtk8.6 libx11-6 libxt6 zlib1g ucf ca-certificates libcurl4-gnutls-dev
# required by r-base-dev
sudo apt install -y build-essential gcc g++ gfortran libatlas-base-dev libncurses5-dev libreadline-dev libjpeg-dev libpcre2-dev libpcre3-dev libpng-dev zlib1g-dev libbz2-dev liblzma-dev libicu-dev xauth pkg-config
# required for viewing graphics on-screen (configure R with `--with-x=no` if it is not needed)
sudo apt install -y xorg-dev
# required by r-base-dev to build PDF help pages (optional; note that these dependencies are quite heavy, and since html help pages are already included, PDF ones are usually unnecessary)
sudo apt install -y texlive-base texlive-latex-base texlive-plain-generic texlive-fonts-recommended texlive-fonts-extra texlive-extra-utils texlive-latex-recommended texlive-latex-extra texinfo

# Install essential packages
sudo apt install -y curl neovim make r-cran-tidyverse neofetch tree build-essential git ranger flatpak

# Neovim setup
# make a home for init.vim
mkdir -p .config/nvim/
wget -O .config/nvim/init.vim https://raw.githubusercontent.com/asieminski/ubuntu-installation-script/main/init.vim
# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Install nodejs for coc autocompletion plugin
curl -sL install-node.vercel.app/lts | bash -s -- -y

# neovim utilities install
miniconda/bin/conda install -y jedi pynvim radian
sudo R -e "install.packages('languageserver')"

# Change bashrc setup
echo "alias r=\"radian\"" >> .bashrc
echo "neofetch" >> .bashrc

# nvim into dotfiles/nvim/.config/nvim and run 
# :PlugInstall
# Install coc (autcompletion extensions https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)
# :CocInstall coc-clangd coc-dot-complete coc-docker coc-jedi coc-r-lsp coc-sh 
