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
                          locales \
                          openssh-server \
                          sudo \
                          tmux \
                          unzip \
                          wget \
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
    
# install python
RUN wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/.miniconda \
    && rm miniconda.sh
ENV PATH="/opt/.miniconda/bin:$PATH"
# to enable pip/conda install for users
RUN chmod 777 -R /opt/.miniconda
 
RUN conda install -y numpy scipy matplotlib pandas ipython tqdm \
    && conda clean -ay \
    && pip install --no-cache-dir neovim

USER root
RUN echo "root:Docker!" | chpasswd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
