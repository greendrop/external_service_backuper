FROM ubuntu:22.04

RUN set -ex \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  sudo \
  locales \
  tzdata \
  vim \
  cron \
  apt-transport-https \
  ca-certificates \
  gnupg \
  curl \
  python3 \
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
  && apt-get update && apt-get install google-cloud-cli \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && echo 'ja_JP.UTF-8 UTF-8' > /etc/locale.gen \
  && locale-gen \
  && update-locale LANG=ja_JP.UTF-8 \
  && cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV LANG ja_JP.UTF-8

# RUN echo '* * * * * echo Hello World >  /var/log/cron.log' > /etc/cron.d/crontab
# RUN chmod 0644 /etc/cron.d/crontab
# RUN /usr/bin/crontab /etc/cron.d/crontab

CMD ["cron", "-f"]
