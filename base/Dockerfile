ARG version
FROM nvidia/cuda:${version}

RUN apt-get update && apt-get install -y software-properties-common  \
    && add-apt-repository ppa:neovim-ppa/stable \
    && apt-get update && apt-get install -y \
                          apt-utils \
                          bzip2 \
                          cmake \
                          curl \
                          gcc \
                          git \
                          neovim \
                          libav-tools \
                          libboost-all-dev \
                          libjpeg-dev \
                          libsdl2-dev \
                          locales \
                          openssh-server \
                          sshfs \
                          sudo \
                          swig \
                          tmux \
                          unzip \
                          xorg-dev \ 
                          xvfb \
                          wget \
                          zlib1g-dev \
                          zsh \
    && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# for ssh
RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# nvidia-docker does't have these
RUN echo "export PATH=$PATH" >> /etc/profile && \
    echo "ldconfig" >> /etc/profile
    
USER root
RUN echo "root:Docker!" | chpasswd
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
