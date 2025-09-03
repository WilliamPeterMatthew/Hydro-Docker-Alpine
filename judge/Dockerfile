FROM node:22

RUN apt-get -qq update && \
    apt-get install -y \
    gcc \
    python3 \
    pypy3 \
    g++ \
    fpc \
    fp-compiler \
    openjdk-17-jdk-headless \
    rustc \
    ghc \
    cabal-install \
    libjavascriptcoregtk-4.0-bin \
    golang \
    ruby \
    mono-runtime \
    mono-mcs \
    kotlin \
    php \
    php-cli \
    nodejs \
    bash

RUN wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
RUN tar -xf Python-2.7.18.tgz
RUN cd /Python-2.7.18 && ./configure --with-pydebug
RUN cd /Python-2.7.18 && make -s -j16
RUN export PATH=$PATH:/Python-2.7.18/
RUN ln -s /Python-2.7.18/python /usr/bin/python
RUN ln -s /Python-2.7.18/python /usr/bin/python2

ADD ./entrypoint.sh /root/entrypoint.sh
ADD ./judge.yaml /root/judge.yaml
ADD ./judge.yaml /root/.hydro/judge.yaml
RUN chmod +x /root/entrypoint.sh

RUN yarn global add pm2 @hydrooj/hydrojudge && \
    wget https://github.com/criyle/go-judge/releases/download/v1.8.0/go-judge_1.8.0_linux_amd64 -O /usr/bin/sandbox && \
    chmod +x /usr/bin/sandbox

ENTRYPOINT /root/entrypoint.sh
