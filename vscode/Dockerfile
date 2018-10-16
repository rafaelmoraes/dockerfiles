FROM debian:stable-slim

# AUTHOR: Rafael Moraes <roliveira.moraes@gmail.com>
# DESCRIPTION: Create a container with a default Visual Studio Code instalation
# USAGE:
#   # Get dockerfile
#   wget https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/vscode/Dockerfile
#
#   # Build the image
#   docker build -t <image-name> .
#
#   # Maybe you need run 'xhost local:root' before run the container
#
#   # Run the container
#   docker -it run --rm \
#     -v `pwd`:/development:rw \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -w /development \
#     -e DISPLAY=unix$DISPLAY <image-name>
#

LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

# Set debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
  --no-install-recommends

# Set system language and encoding
ENV LC_ALL C
ENV LANG en_US.utf8
ENV LANGUAGE en_US.utf8

# Add vscode repository
RUN sh -c 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg'
RUN sh -c 'install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/'
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

# Install dependencies
RUN apt-get update && apt-get install -y \
	code \
	git \
	gconf2 \
	gconf-service \
	gvfs-bin \
	libasound2 \
	libcap2 \
	libgconf-2-4 \
	libgtk2.0-0 \
	libnotify4 \
	libnss3 \
	libxkbfile1 \
	libxss1 \
	libxtst6 \
	libx11-xcb-dev \
	xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /development

# Create user to run vscode
RUN sh -c 'useradd -m developer'

# # Configure Visual Studio Code
RUN sh -c 'mkdir -p /home/developer/.config/Code/User'
RUN curl -o /home/developer/.config/Code/User/settings.json \
  https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/vscode/settings.json

# Install font Roboto Mono for Powerline
RUN sh -c 'mkdir -p /home/developer/.local/share/fonts'
RUN curl -fLo '/home/developer/.local/share/fonts/Roboto Mono for Powerline.ttf' \
	https://raw.githubusercontent.com/powerline/fonts/master/RobotoMono/Roboto%20Mono%20for%20Powerline.ttf
RUN curl -o /etc/fonts/local.conf \
	https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/vscode/local.conf
RUN chown -R developer:developer /home/developer
RUN sh -c 'fc-cache -vf /home/developer/.local/share/fonts/'

# Create code runable alternative
RUN sh -c 'mv /usr/bin/code /usr/bin/vscode'
RUN echo 'su - developer -c "vscode ${@:-/development}"' > /usr/bin/code && chmod +x /usr/bin/code
