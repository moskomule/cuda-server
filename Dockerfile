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
    
# might not be needed
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
WORKDIR /opt

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
COPY setup.sh /opt/
CMD ["/usr/sbin/sshd", "-D"]
