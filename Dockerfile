ARG image_name
FROM ${image_name}

USER root
ARG user_name
RUN useradd -ms /bin/zsh ${user_name} \
    && echo "${user_name}:Docker!" | chpasswd ${user_name} \
    && chown -R ${user_name} /opt/.miniconda \
    && mkdir /home/${user_name}/.ssh \
    && touch /home/${user_name}/.ssh/authorized_keys \
    && chown ${user_name}  /home/${user_name}/.ssh/authorized_keys \
    && chown ${user_name} /etc/profile
ENV PATH "/opt/.miniconda/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

CMD ["/usr/sbin/sshd", "-D"]
