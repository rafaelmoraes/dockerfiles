FROM debian:stable-slim

LABEL name="rmoraes/vim"
LABEL version="0.0.1"
LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

# Set system language and encoding
ENV LC_ALL C
ENV LANG en_US.utf8
ENV LANGUAGE en_US.utf8

# Set debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install --no-install-recommends -y \
	apt-transport-https \
	ca-certificates \
	gnupg && \
    apt upgrade -y

RUN apt install --no-install-recommends -y \
    sudo \
    xserver-xorg-core \
    vim-athena \
	curl \
    git \
    exuberant-ctags \
    ncurses-term \
    xsel \
    xclip \
    make \
    build-essential

#Install nodejs and npm
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install --no-install-recommends -y \
        nodejs \
        npm

# Install linters
RUN apt install --no-install-recommends -y \
        shellcheck \
        yamllint python3-pkg-resources \
        tidy # HTMLlinter

RUN npm install -g --no-optional \
        markdownlint@latest \
        csslint@latest \
        fixjson@latest \
        dockerfile_lint@latest \
        eslint@latest \
        prettier@latest \
        vue-language-server

# Replace 1000 for the UID(user id) from the host machine that you wish to use.
RUN useradd developer -m -u 1000 -G sudo && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer

ENV HOME /home/developer

COPY vimrc $HOME/.vimrc

RUN vim -E -s -u $HOME/.vimrc +PlugInstall +qall

RUN chown -R developer:developer $HOME

RUN apt remove -y --purge \
        make \
        build-essential
RUN apt autoclean -y
RUN apt autoremove -f -y
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /usr/share/locale/*
RUN rm -rf /usr/share/doc/*
RUN rm -rf /usr/share/man/*

USER developer

CMD ["vim"]
