FROM ubuntu:23.10
LABEL maintainer="John <john@nowhere.com"
ARG DEBIAN_FRONTEND=noninteractive
RUN set -x \
    && groupadd --system --gid 101 nginx \
    && useradd --system --gid nginx --no-create-home --home /nonexistent --comment "nginx user" --shell /bin/false --uid 101 nginx \
    && apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y --no-install-recommends --no-install-suggests install net-tools iproute2 procps nginx gnupg1 gnupg2 gpg ca-certificates \
# create a docker-entrypoint.d directory
    && mkdir /docker-entrypoint.d
COPY ./default-site.conf /etc/nginx/sites-available/default
COPY ./web-site.conf /etc/nginx/sites-available
RUN  ln -sf /etc/nginx/sites-available/web-site.conf /etc/nginx/sites-enabled/web-site.conf 
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /var/www/nginx/html/index.html
COPY ./docker-entrypoint.sh  /
COPY ./cmd-nginx.sh /usr/bin
COPY ./entrypoint.envsh /docker-entrypoint.d
COPY ./entrypoint.sh /docker-entrypoint.d
EXPOSE 80/tcp 81/tcp 82/tcp
ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
STOPSIGNAL SIGQUIT
CMD ["cmd-nginx.sh"]


# forward request and error logs to docker log collector
#    && ln -sf /dev/stdout /var/log/nginx/access.log \
#    && ln -sf /dev/stderr /var/log/nginx/error.log \

