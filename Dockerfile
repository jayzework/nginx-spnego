ARG NGINX_VERSION=1.25.4
FROM nginx:${NGINX_VERSION}-alpine

CMD ["nginx", "-g", "daemon off;"]  

RUN set -ex \
  && apk add --no-cache \
    git \
    krb5 \
    krb5-dev \
    ca-certificates \
    libressl \
    pcre \
    zlib \
    bash \
  && apk add --no-cache --virtual .build-deps \
    build-base \
    linux-headers \
    libressl-dev \
    pcre-dev \
    wget \
    zlib-dev \
  && cd /tmp \
  && wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar xzf nginx-${NGINX_VERSION}.tar.gz \
  && git clone https://github.com/stnoonan/spnego-http-auth-nginx-module.git nginx-${NGINX_VERSION}/spnego-http-auth-nginx-module 


WORKDIR /tmp/nginx-${NGINX_VERSION} 

RUN ./configure --with-compat --add-dynamic-module=spnego-http-auth-nginx-module \
     && make modules \
     && cp objs/ngx_http_auth_spnego_module.so /usr/lib/nginx/modules/

WORKDIR /etc/nginx

