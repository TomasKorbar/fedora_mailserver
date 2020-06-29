FROM fedora:rawhide

RUN dnf install -y postfix iproute iputils bind-utils telnet dovecot passwd opendkim perl-Getopt-Long;

RUN systemctl enable postfix;
RUN systemctl enable dovecot;
RUN systemctl enable opendkim;

ADD images/server1/bootstrap.sh /usr/bin/bootstrap
ADD images/server1/bootstrap.service /etc/systemd/system/bootstrap.service

RUN systemctl enable bootstrap;

ADD /images/server1/configs/postfix/main.cf /etc/postfix/main.cf
ADD /images/server1/configs/opendkim/opendkim.conf /etc/opendkim.conf

RUN echo 'export MAIL=$HOME/Maildir' >> /etc/profile.d/mail.sh
RUN echo "2019._domainkey.first-domain.com first-domain.com:2019:/etc/opendkim/keys/first-domain.com/2019.private" > /etc/opendkim/KeyTable
RUN printf "*@first-domain.com 2019._domainkey.first-domain.com\n*@tom.first-domain.com 2019._domainkey.first-domain.com\n" > /etc/opendkim/SigningTable

RUN mkdir -p /etc/opendkim/keys/first-domain.com
COPY ./images/server1/configs/opendkim/2019.private /etc/opendkim/keys/first-domain.com/2019.private
RUN chown opendkim:opendkim /etc/opendkim/keys/first-domain.com/2019.private
RUN chmod 600 /etc/opendkim/keys/first-domain.com/2019.private

EXPOSE 25
EXPOSE 143
EXPOSE 110

CMD [ "/sbin/init" ]
