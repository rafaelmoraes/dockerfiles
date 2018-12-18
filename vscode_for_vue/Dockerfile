FROM rmoraes/vscode:latest
# URL of base image dockerfile
# https://github.com/rafaelmoraes/dockerfiles/tree/master/vscode

# AUTHOR: Rafael Moraes <roliveira.moraes@gmail.com>
# DESCRIPTION: Create a container with a Visual Studio Code editor with support to develop on Vue JS
# USAGE:
#   # Get dockerfile
#   wget https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/vscode_for_vue/Dockerfile
#
#   # Build the image
#   docker build -t <image_name> .
#
#   # Maybe you need run 'xhost local:root' before run the container
#
#   # Run the container
#   docker run -it --rm \
#     -v `pwd`:/development:rw \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -w /development \
#     -p 8080:8080 \
#     -e DISPLAY=unix$DISPLAY <image_name>

LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

# Set debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Update and Upgrade the system
RUN apt-get update && apt-get upgrade -y

# Install vscode extensions
RUN code --install-extension anseki.vscode-color
RUN code --install-extension christian-kohler.path-intellisense
RUN code --install-extension PeterJausovec.vscode-docker
RUN code --install-extension streetsidesoftware.code-spell-checker
RUN code --install-extension Tyriar.sort-lines
RUN code --install-extension wayou.vscode-todo-highlight
RUN code --install-extension wmaurer.change-case

RUN code --install-extension octref.vetur

# Maintains bash history
RUN echo "export HISTFILE=/dot_files/.bash_history" >> ~/.bashrc
RUN echo "cd /development" >> ~/.bashrc

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y yarn

# Install Vue JS CLI
RUN yarn global add @vue/cli

#Cleanup
RUN rm -rf /var/lib/apt/lists/*
