FROM debian:stable-slim

# AUTHOR: Rafael Moraes <roliveira.moraes@gmail.com>
# DESCRIPTION: Create a container with a default Atom instance
# USAGE:
#   # Get dockerfile
#   wget https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/atom/Dockerfile
#
#   # Build the image
#   docker build -t atom .
#
#   # Maybe you need run 'xhost local:root' before run the container
#
#   # Run the container
#   docker run --rm \
#     -v `pwd`:/development:rw \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -w /development \
#     -e DISPLAY=unix$DISPLAY atom
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

# Add the atom debian repo
RUN curl -sSL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

# Install dependencies
RUN apt-get update && apt-get install -y \
	atom \
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

# Configure Atom
RUN sh -c 'mkdir /root/.atom'
RUN curl -o /root/.atom/config.cson \
  https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/atom/config.cson

# Install font Roboto Mono for Powerline
RUN sh -c 'mkdir -p /root/.local/share/fonts'
RUN curl -fLo '/root/.local/share/fonts/Roboto Mono for Powerline.ttf' \
	https://raw.githubusercontent.com/powerline/fonts/master/RobotoMono/Roboto%20Mono%20for%20Powerline.ttf
RUN curl -o /etc/fonts/local.conf \
	https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/atom/local.conf
RUN sh -c 'fc-cache -vf /root/.local/share/fonts/'

# Autorun atom
CMD [ "atom", "--foreground", "/development" ]
