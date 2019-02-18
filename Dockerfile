FROM ubuntu:latest

# Set locale to "en_US.UTF-8" (copied from Postgres Dockerfile)
RUN apt-get update && \
    apt-get install -y \
        sudo \
        locales \
        coreutils \
        build-essential \
        cmake \
        bash-completion \
        manpages-dev \
        man-db \
        git \
        vim \
        python \
        python-pip \
        python3 \
        python3-pip \
        curl \
        wget \
        && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    git clone https://github.com/cadizm/bin.git /home/dev/bin && \
    git clone https://github.com/cadizm/dotfiles.git /dotfiles && \
    pip install dotfiles && \
    dotfiles --sync --force --home=/home/dev --repo=/dotfiles

ENV LANG en_US.utf8

# https://askubuntu.com/questions/422975/e-package-python-software-properties-has-no-installation-candidate
# https://askubuntu.com/questions/777388/unable-to-locate-package-libqt4-core-and-libqt4-gui-on-ubuntu-16
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps \\
        | sed s/python-software-properties/software-properties-common/ \
        | sed s/libqt4-core/libqtcore4/ \
        | sed s/libqt4-gui/libqtgui4/ \
        | bash && \
    git clone https://github.com/torch/distro.git /torch --recursive && \
    cd /torch && ./install.sh -b

RUN . /torch/install/bin/torch-activate && \
    luarocks install nngraph && \
    luarocks install optim && \
    luarocks install nn

RUN groupadd -r dev --gid=222 && useradd -r -g dev --uid=222 dev && \
    chown -R dev:dev ~dev && \
    echo ". /torch/install/bin/torch-activate" >> ~dev/.bashrc

USER dev
