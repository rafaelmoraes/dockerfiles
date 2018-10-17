FROM rmoraes/vscode:v1
# URL of base image dockerfile
# https://github.com/rafaelmoraes/dockerfiles/tree/master/vscode

# AUTHOR: Rafael Moraes <roliveira.moraes@gmail.com>
# DESCRIPTION: Create a container with a Visual Studio Code editor with support to develop on Ruby On Rails
# USAGE:
#   # Get dockerfile
#   wget https://raw.githubusercontent.com/rafaelmoraes/dockerfiles/master/vscode_for_ruby_on_rails/Dockerfile
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
#     -e DISPLAY=unix$DISPLAY <image_name>
#

LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

# Set debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Get ruby on rails dependencies
COPY .ruby-version /tmp
COPY . /tmp/app

# Maintains bash history
RUN echo "export HISTFILE=/dot_files/.bash_history" >> ~/.bashrc
RUN echo "cd /development" >> ~/.bashrc

# Install vscode extensions
RUN code --install-extension anseki.vscode-color
RUN code --install-extension castwide.solargraph
RUN code --install-extension christian-kohler.path-intellisense
RUN code --install-extension Hridoy.rails-snippets
RUN code --install-extension misogi.ruby-rubocop
RUN code --install-extension PeterJausovec.vscode-docker
RUN code --install-extension rebornix.ruby
RUN code --install-extension streetsidesoftware.code-spell-checker
RUN code --install-extension Tyriar.sort-lines
RUN code --install-extension wayou.vscode-todo-highlight
RUN code --install-extension wmaurer.change-case
RUN code --install-extension ZneuRay.erb-vscode-snippets

# Install rails
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/rafaelmoraes/shell_scripts/master/debian/installers/install_ruby_on_rails.sh)"

# # Fix rubocop and solargraph path
RUN ln -s /root/.rbenv/shims/rubocop /usr/bin/rubocop
RUN ln -s /root/.rbenv/shims/solargraph /usr/bin/solargraph

#Cleanup
RUN rm -rf /var/lib/apt/lists/* && rm -rf /tmp
