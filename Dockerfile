FROM elixir:1.7-alpine

RUN \
      mkdir -p /opt/app && \
      chmod -R 777 /opt/app && \
      apk update && \
      apk --no-cache --update add \
      bash git make g++ wget curl inotify-tools \
      nodejs=8.11.4-r0 npm=8.11.4-r0 && \
      npm i -g npm --no-progress && \
      update-ca-certificates --fresh && \
      rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
      mix local.rebar --force && \
      mix archive.install https://github.com/phoenixframework/archives/raw/master/1.4-dev/phx_new.ez --force

ENV PS1='$MIX_ENV-${debian_chroot:+($debian_chroot))}\u@\h:\w\$ ' \
      TERM=xterm \
      PROJECT_HOME=/opt/app

WORKDIR $PROJECT_HOME

CMD sh -c "/bin/bash"
