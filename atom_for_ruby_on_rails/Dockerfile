FROM rmoraes/atom:latest
# URL of base image dockerfile
# https://github.com/rafaelmoraes/dockerfiles/tree/master/atom

# AUTHOR: Rafael Moraes <roliveira.moraes@gmail.com>
# DESCRIPTION: Create a container with a Atom editor with support to develop on Ruby On Rails
# USAGE:
#   # Get dockerfile
#   wget https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/atom/Dockerfile
#
#   # Build the image
#   docker build -t <image_name> .
#
#   # Maybe you need run 'xhost local:root' before run the container
#
#   # Run the container
#   docker run --rm \
#     -v `pwd`:/development:rw \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -w /development \
#     -e DISPLAY=unix$DISPLAY <image_name>
#

LABEL maintainer='Rafael Moraes <roliveira.moraes@gmail.com>'

# Set debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install Atom extensions
RUN apm install \
  emmet \
  linter \
  linter-ui-default \
  linter-rubocop \
  highlight-selected \
  intentions \
  busy-signal \
  ruby-block \
  ruby-solargraph

# COPY .ruby-version /tmp
COPY . /tmp/app

# Maintains bash history
RUN echo 'export HISTFILE=/dot_files/.bash_history' >> ~/.bashrc
RUN echo 'cd /development' >> ~/.bashrc

# Install rails
RUN sh -c "cd /tmp/app && \
  $(curl -fsSL https://raw.githubusercontent.com/rafaelmoraes/shell_scripts/master/debian/installers/install_ruby_on_rails.sh)"

# Fix rubocop path to atom extension
RUN ln -s /root/.rbenv/shims/rubocop /usr/bin/rubocop

#Install firefox and geckodriver to support the system tests
RUN sh -c "cd /tmp/app && \
  $(curl -fsSL https://raw.githubusercontent.com/rafaelmoraes/shell_scripts/master/debian/installers/install_firefox_esr_with_geckodriver.sh)"

#Cleanup
RUN rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
