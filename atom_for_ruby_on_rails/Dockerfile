FROM rmoraes/atom:v1

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

LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

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

COPY .ruby-version /tmp
COPY . /tmp/app

# Install rails
RUN curl -o /tmp/app/install_rails.sh \
    https://raw.githubusercontent.com/rafaelmoraes/shell_scripts/master/debian/installers/install_ruby_on_rails.sh
RUN su -c 'chmod +x /tmp/app/install_rails.sh && cd /tmp/app && ./install_rails.sh'

# Maintains bash history
RUN su -c 'echo "export HISTFILE=/dot_files/.bash_history" >> ~/.bashrc'
RUN su -c 'echo "cd $(pwd)" >> ~/.bashrc'

#Cleanup
RUN su -c 'rm -rf /var/lib/apt/lists/*'
