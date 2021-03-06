FROM jwilder/nginx-proxy
EXPOSE 80 443 25
RUN { \
      echo 'server_tokens off;'; \
      echo 'client_max_body_size 200m;'; \
      echo 'disable_symlinks off;'; \
    } > /etc/nginx/conf.d/my_proxy.conf
