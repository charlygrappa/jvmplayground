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
    sysstat

RUN cd ~ && \
    git clone https://github.com/jvm-profiling-tools/async-profiler && \
    cd /root/async-profiler && \
    make

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
