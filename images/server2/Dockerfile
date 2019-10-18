FROM fedora:30

RUN dnf install -y postfix iproute iputils bind-utils telnet dovecot passwd;

RUN systemctl enable postfix;
RUN systemctl enable dovecot;

ADD images/server2/bootstrap.sh /usr/bin/bootstrap
ADD images/server2/bootstrap.service /etc/systemd/system/bootstrap.service

RUN systemctl enable bootstrap;

ADD /images/server2/configs/postfix/main.cf /etc/postfix/main.cf

RUN echo 'export MAIL=$HOME/Maildir' >> /etc/profile.d/mail.sh

EXPOSE 25
EXPOSE 143
EXPOSE 110

CMD [ "/sbin/init" ]
