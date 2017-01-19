FROM debian:jessie

MAINTAINER Silvia Puglisi [Hiro] <hiro@torproject.org>
WORKDIR /$APPROOT

RUN apt-get update -qq
RUN apt-get upgrade -y
RUN apt-get install -y --fix-missing wget git gcc g++ automake cmake make libglib2.0 libglib2.0-dev \
                       libigraph0 libigraph0-dev libevent-dev openssl libssl-dev python

RUN git clone https://git.torproject.org/tor.git -b release-0.2.7
WORKDIR /tor
RUN ./autogen.sh
RUN ./configure --disable-asciidoc
RUN make

WORKDIR /$APPROOT
RUN git clone https://github.com/shadow/shadow.git
WORKDIR /shadow/src/plugin/shadow-plugin-tgen
RUN mkdir build
WORKDIR /shadow/src/plugin/shadow-plugin-tgen/build
RUN cmake .. -DSKIP_SHADOW=ON -DCMAKE_MODULE_PATH=`pwd`/../../../../cmake/
RUN make

WORKDIR /$APPROOT
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN git clone https://github.com/robgjansen/onionperf.git
WORKDIR /onionperf
RUN apt-get install -y python-dev libxml2 libxml2-dev libxslt1-dev \
                       libpng-dev libfreetype6
RUN pip install stem lxml twisted networkx scipy numpy matplotlib
RUN python setup.py build
RUN python setup.py install
