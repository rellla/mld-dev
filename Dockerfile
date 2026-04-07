FROM debian:bookworm

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
    gawk wget git-core diffstat unzip texinfo gcc-aarch64-linux-gnu build-essential chrpath socat cpio python3 python3-pip python3-pexpect python3-venv xz-utils debianutils iputils-ping libsdl1.2-dev xterm locales locales-all default-jre acl file \
    openssh-server nginx sudo \
    vim htop zstd lz4 \
 && apt clean

RUN python3 -m venv /opt/kas-env \
 && /opt/kas-env/bin/pip install kas \
 && ln -s /opt/kas-env/bin/kas /usr/local/bin/kas

# nginx für Zugriff auf die deb Pakete
RUN echo "server {\n listen 80;\n server_name _;\n location ~ ^/$ {\n  autoindex on;\n  alias /home/\$user;\n }\n location ~ ^/firmware/(?<file>.*)$ {\n  absolute_redirect off;\n  autoindex on;\n  alias /home/firmware/\$file;\n }\n location ~ ^/(?<user>[^/]*)/(?<file>.*)$ {\n  absolute_redirect off;\n  autoindex on;\n  alias /home/\$user/mld-dev/deploy/\$file;\n }\n location ~ ^/favicon.ico$ {\n  alias /var/www/html/favicon.ico;\n }\n}" > /etc/nginx/sites-available/apt \
 && echo "server {\n listen 80;\n server_name alpha.minidvblinux.de;\n location ~ ^/favicon.ico$ {\n  alias /var/www/html/favicon.ico;\n location ~ ^/(?<file>.*)$ {\n  absolute_redirect off;\n  autoindex on;\n  alias /home/nightbuild/mld-dev/deploy/images/\$file;\n }\n }\n}" >> /etc/nginx/sites-available/apt \
 && ln -s /etc/nginx/sites-available/apt /etc/nginx/sites-enabled/apt

RUN groupadd -g ${GROUP_ID} mld || true \
 && useradd -l -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash -G sudo -m mld \
 && echo "%sudo ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && echo 'de_DE.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

RUN echo '/etc/init.d/ssh start\n/etc/init.d/nginx start\nsleep infinity' >> /init.sh \
 && chmod a+x /init.sh

EXPOSE 22
EXPOSE 80

USER mld
WORKDIR /home/mld

CMD /init.sh
