FROM ubuntu:16.04

RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
         git \
         automake \
         build-essential \
         libtool \
         autotools-dev \
         autoconf \
         pkg-config \
         libssl-dev 
         libboost-all-dev \
         libevent-dev \
         vim \
         software-properties-common

RUN add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
          libdb4.8-dev \
          libdb4.8++-dev \
          libminiupnpc-dev 

WORKDIR /nero


RUN git clone https://github.com/NeroProject/nero.git . && \
    ./autogen.sh && \
    ./configure && \
    make

VOLUME ["/root/.nerocore"]

EXPOSE 12777

CMD /nero/src/nerod && tail -f /root/.nerocore/debug.log
