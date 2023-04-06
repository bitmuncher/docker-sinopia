FROM debian:buster

MAINTAINER Frank Fuhrmann, frank@ff-sec.eu

RUN apt-get update && \
	apt-get install -y libterm-readline-perl-perl npm && \
  npm i npm@latest -g && \
  npm install -g sinopia && \
  useradd -ms /bin/bash sinopia && \
  mkdir -p /home/sinopia/storage && \
  apt-get -y remove gcc gcc-8 g++ g++-8 make && \
  apt-get -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/start.sh /home/sinopia/start.sh
ADD config/config.yaml /home/sinopia/config.yaml
ADD config/htpasswd /home/sinopia/htpasswd

RUN chown -R sinopia:sinopia /home/sinopia && \
  chmod ug+rx /home/sinopia/start.sh

USER sinopia
WORKDIR /home/sinopia

CMD ["/home/sinopia/start.sh"]

EXPOSE 4873
