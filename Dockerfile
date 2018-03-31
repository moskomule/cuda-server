ARG image_name
FROM ${image_name}

USER root
ARG user_name
RUN useradd -ms /bin/zsh ${user_name} \
    && echo "${user_name}:Docker!" | chpasswd ${user_name} \
    && chown -R ${user_name} /opt/.miniconda

CMD ["/usr/sbin/sshd", "-D"]
