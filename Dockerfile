FROM ubuntu:bionic

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates wget gnupg2

# Resolving Postgres installation issue
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list

COPY stack/geolibs.sh \
    stack/imagemagick.sh \
    stack/wkhtmltox.sh \
    stack/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb \
    /

RUN apt-get update \
    && apt-get install -qyy --fix-missing -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
        build-essential \
        checkinstall \
        coffeescript \
        fontconfig \
        g++ \
        gcc \
        git \
        lib32ncurses5-dev \
        libc-dev \
        libffi-dev \
        libffi6 \
        libgeos-dev \
        libjpeg-dev \
        libjpeg-turbo8-dev \
        libmagic-dev \
        libpcre3 \
        libpcre3-dev \
        libpq-dev \
        libreadline-dev \
        libssl-dev \
        libxext6 \
        libxml2-dev \
        libxrender1 \
        libxslt1-dev \
        libzmq3-dev \
        make \
        musl-dev \
        ncurses-dev \
        nginx \
        node-less \
        openssl \
        patch \
        postgresql-client-9.6 \
        pypy \
        python3.6 \
        python3.6-dev \
        python3.6-minimal \
        python-pil \
        python3-pip \
        python-setuptools \
        python-zmq \
        supervisor \
        xfonts-75dpi \
        xfonts-base \
        xvfb \
        yui-compressor \
    && apt-get clean

RUN sh /geolibs.sh
RUN sh /imagemagick.sh

RUN rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/*

RUN wget -qO- https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g bower less coffeescript

RUN echo "deb http://security.ubuntu.com/ubuntu xenial-security main" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y libpng12-0

RUN sh /wkhtmltox.sh

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*[~]$

CMD ["/bin/bash"]