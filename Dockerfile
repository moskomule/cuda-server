ARG image_name
FROM ${image_name}:latest

USER root
ARG user_name
RUN useradd -ms /bin/zsh ${user_name} \
    && echo "${user_name}:Docker!" | chpasswd ${user_name}
COPY setups /home/${user_name}
RUN chmod 777 /home/${user_name}/setup.sh

CMD ["/usr/sbin/sshd", "-D"]
