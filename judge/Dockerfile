FROM node:22-alpine3.22

ENV PATH=/opt/kotlinc/bin:$PATH
ENV PATH=/root/.ghcup/bin:$PATH

# 启用 main/community/testing 仓库
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.22/main"       >  /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.22/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing"    >> /etc/apk/repositories && \
    apk update

# 安装基础工具链
RUN apk add --no-cache \
      build-base \
      gcc \
      g++ \
      openjdk21 \
      rust \
      go \
      ruby \
      mono \
      bash \
      php \
      php-cli \
      nodejs \
      python3 \
      py3-pip \
      pypy3 \
      wget \
      curl \
      ca-certificates \
      linux-headers \
      git \
      fpc \
      ncurses-dev \
      gmp-dev \
      zlib-dev \
      tar \
      xz \
      unzip \
      make

# 安装 Python2.7.18
RUN wget https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz && \
    tar -xzf Python-2.7.18.tgz && \
    cd Python-2.7.18 && \
    ./configure --prefix=/usr/local && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && rm -rf Python-2.7.18* && \
    ln -sf /usr/local/bin/python2.7 /usr/bin/python2

# 安装 Kotlin 1.9.25
RUN wget https://github.com/JetBrains/kotlin/releases/download/v1.9.25/kotlin-compiler-1.9.25.zip && \
    unzip kotlin-compiler-1.9.25.zip -d /opt && \
    rm kotlin-compiler-1.9.25.zip

# 建立 python3 软链接
RUN ln -sf /usr/bin/python3 /usr/bin/python

# 安装 ghcup + GHC + Cabal
RUN curl -L https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup -o /usr/bin/ghcup && \
    chmod +x /usr/bin/ghcup && \
    export HOME=/root && \
    ghcup install ghc latest && \
    ghcup install cabal latest && \
    ghcup set ghc latest && \
    ghcup set cabal latest

# 验证安装结果
RUN gcc --version && \
    g++ --version && \
    fpc -iV && \
    javac -version && \
    rustc --version && \
    go version && \
    ruby --version && \
    mono --version && \
    kotlinc -version && \
    php --version && \
    node --version && \
    python2 --version && \
    python3 --version && \
    pypy3 --version && \
    ghc --version && \
    cabal --version

ADD ./entrypoint.sh /root/entrypoint.sh
ADD ./judge.yaml /root/judge.yaml
ADD ./judge.yaml /root/.hydro/judge.yaml
RUN chmod +x /root/entrypoint.sh

# 安装 pm2 与 hydrojudge，并自动根据架构下载 sandbox
RUN yarn global add pm2 @hydrooj/hydrojudge && \
    arch=$(apk --print-arch) && \
    case "$arch" in \
      x86_64)  url="https://github.com/criyle/go-judge/releases/download/v1.8.0/go-judge_1.8.0_linux_amd64" ;; \
      aarch64) url="https://github.com/criyle/go-judge/releases/download/v1.8.0/go-judge_1.8.0_linux_arm64" ;; \
      *) echo "Unsupported architecture: $arch" && exit 1 ;; \
    esac && \
    wget "$url" -O /usr/bin/sandbox && \
    chmod +x /usr/bin/sandbox

ENTRYPOINT ["/root/entrypoint.sh"]
