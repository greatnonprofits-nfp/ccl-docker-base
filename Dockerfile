FROM ubuntu:xenial

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get install wget -y
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    apt-key add -

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
        libpython-dev \
        libreadline6 \
        libreadline6-dev \
        libssl-dev \
        libxext6 \
        libxml2-dev \
        libxrender1 \
        libxslt1-dev \
        libzmq-dev \
        make \
        musl-dev \
        ncurses-dev \
        nginx \
        node-less \
        openssl \
        patch \
        postgresql-client-9.6 \
        pypy \
        python-dev \
        python-imaging \
        python-pip \
        python-setuptools \
        python-virtualenv \
        python-zmq \
        supervisor \
        xfonts-75dpi \
        xfonts-base \
        xvfb \
        yui-compressor \
    && apt-get clean

RUN sh /geolibs.sh
RUN sh /imagemagick.sh
RUN sh /wkhtmltox.sh

RUN apt-get remove python-urllib3 \ 
    python-chardet \
    python-six \
    python-colorama -y

RUN wget -qO- https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g bower
RUN npm install -g less
RUN npm install -g coffee-script

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*[~]$

CMD ["/bin/bash"]