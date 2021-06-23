FROM ubuntu:focal
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y curl gnupg2 ca-certificates lsb-release git libmaxminddb-dev build-essential zlib1g-dev libpcre3 libpcre3-dev libtool autoconf automake
RUN echo "deb http://nginx.org/packages/mainline/`lsb_release -is | tr '[:upper:]' '[:lower:]'` `lsb_release -cs` nginx" > /etc/apt/sources.list.d/nginx.list
RUN echo "deb-src http://nginx.org/packages/mainline/`lsb_release -is | tr '[:upper:]' '[:lower:]'` `lsb_release -cs` nginx" >> /etc/apt/sources.list.d/nginx.list
RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN apt-get update
RUN apt-get build-dep -y nginx
WORKDIR /usr/src/
RUN apt-get source nginx
RUN git clone https://github.com/chaizhenhua/ngx-ip2location.git
RUN git clone https://github.com/leev/ngx_http_geoip2_module.git
RUN git clone https://github.com/google/ngx_brotli.git
WORKDIR /usr/src/ngx_brotli
RUN git submodule update --init
WORKDIR /usr/src/
RUN git clone --depth 1 --branch 8.0.1 https://github.com/chrislim2888/IP2Location-C-Library.git
WORKDIR /usr/src/IP2Location-C-Library
RUN autoreconf -i -v --force && ./configure && make && make install
RUN cd /usr/src/nginx-1* && sed -i '0,/--with-stream_ssl_preread_module/s//--with-stream_ssl_preread_module --add-module=\/usr\/src\/ngx-ip2location --add-module=\/usr\/src\/ngx_http_geoip2_module --add-module=\/usr\/src\/ngx_brotli /' debian/rules && sed -i 's/dh_shlibdeps -a/dh_shlibdeps --dpkg-shlibdeps-params=--ignore-missing-info/g' debian/rules
RUN cd /usr/src/nginx-1* && dpkg-buildpackage -b


