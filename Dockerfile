FROM azul/zulu-openjdk:17.0.5

RUN apt update && \
    apt install -y \
    htop \
    gcc \
    g++ \
    git \
    make \
    python3 \
    python3-pip \
    vim \
    lsof \
    inetutils-ping \
    curl \
    sysstat \
    graphviz \
    unzip \
    autoconf

RUN cd ~ && \
    git clone https://github.com/jvm-profiling-tools/async-profiler && \
    cd /root/async-profiler && \
    make

RUN cd ~ && \
   git clone https://github.com/jemalloc/jemalloc.git && \
   cd /root/jemalloc && \
   autoconf && ./configure --enable-stats --enable-prof && \
   make && make install

ENV PATH="${PATH}:/root/async-profiler/build/bin:/root/proj"

RUN pip3 install notebook && \
    cd /root/ && \
    git clone https://github.com/apple/GCGC && \
    pip3 install \
      matplotlib \
      pandas \
      numpy

COPY . /root/proj/

WORKDIR /root/proj/

EXPOSE 8888
EXPOSE 9898
EXPOSE 8080
