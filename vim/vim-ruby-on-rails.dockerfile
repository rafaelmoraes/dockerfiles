FROM rmoraes/vim
LABEL version="0.0.1"
LABEL name="rmoraes/vim-ruby-on-rails"
LABEL maintainer="Rafael Moraes <roliveira.moraes@gmail.com>"

USER root

ENV HOME /root

RUN ln -s /home/developer/.vim /root/.vim

RUN ln -s /home/developer/.vimrc /root/.vimrc

RUN apt update && \
    apt install --no-install-recommends -y \
	apt-transport-https \
	ca-certificates \
	gnupg && \
    apt upgrade -y

COPY . /tmp/app

# Maintains bash history
RUN echo 'export HISTFILE=/dot_files/.bash_history' >> $HOME/.bashrc

# Install rails
RUN cd /tmp/app && \
    curl -o install_ruby_on_rails.sh \
            https://raw.githubusercontent.com/rafaelmoraes/shell_scripts/master/debian/installers/install_ruby_on_rails.sh && \
    chmod +x install_ruby_on_rails.sh && \
    ./install_ruby_on_rails.sh

# Fix bin path
RUN ln -s $HOME/.rbenv/shims/rubocop /usr/bin/rubocop
RUN ln -s $HOME/.rbenv/shims/brakeman /usr/bin/brakeman
RUN ln -s $HOME/.rbenv/shims/solargraph /usr/bin/solargraph
RUN ln -s $HOME/.rbenv/shims/solargraph-runtime /usr/bin/solargraph-runtime

#Install firefox and geckodriver to support the system tests
RUN cd /tmp/app && \
    curl -o install_firefox_esr_with_geckodriver.sh \
            https://raw.githubusercontent.com/rafaelmoraes/shell_scripts/master/debian/installers/install_firefox_esr_with_geckodriver.sh && \
    chmod +x install_firefox_esr_with_geckodriver.sh && \
    ./install_firefox_esr_with_geckodriver.sh

#Cleanup
RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/development"]
WORKDIR /development

EXPOSE 3000

# CMD ["vim"]
