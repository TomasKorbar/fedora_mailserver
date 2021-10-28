FROM fedora:rawhide

RUN dnf install -y postfix iproute iputils bind-utils telnet dovecot passwd opendkim perl-Getopt-Long;

RUN systemctl enable postfix;
RUN systemctl enable dovecot;
RUN systemctl enable opendkim;

ADD images/server2/bootstrap.sh /usr/bin/bootstrap
ADD images/server2/bootstrap.service /etc/systemd/system/bootstrap.service

RUN systemctl enable bootstrap;

ADD /images/server2/configs/postfix/main.cf /etc/postfix/main.cf
ADD /images/server2/configs/opendkim/opendkim.conf /etc/opendkim.conf
ADD /images/server2/configs/dovecot/conf.d/* /etc/dovecot/conf.d
ADD /images/server2/configs/dovecot/dovecot.conf /etc/dovecot/dovecot.conf

RUN echo "export MAIL=$HOME/Maildir" >> /etc/profile.d/mail.sh
RUN echo "2019._domainkey.second-domain.com second-domain.com:2019:/etc/opendkim/keys/second-domain.com/2019.private" > /etc/opendkim/KeyTable
RUN printf "*@second-domain.com 2019._domainkey.second-domain.com\n*@jerry.second-domain.com 2019._domainkey.second-domain.com\n" > /etc/opendkim/SigningTable

RUN mkdir -p /etc/opendkim/keys/second-domain.com
COPY ./images/server2/configs/opendkim/2019.private /etc/opendkim/keys/second-domain.com/2019.private
RUN chown opendkim:opendkim /etc/opendkim/keys/second-domain.com/2019.private
RUN chmod 600 /etc/opendkim/keys/second-domain.com/2019.private

EXPOSE 25
EXPOSE 143
EXPOSE 110

CMD [ "/sbin/init" ]
