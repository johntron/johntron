FROM ubuntu:latest as build
RUN apt-get update
RUN apt install -y git \
    cmake \
    libboost-all-dev \
    libcppunit-dev \
    libfftw3-dev \
    python-dev \
    swig \
    python-numpy \
    python-mako \
    python-six \
    libgmp-dev \
    ninja-build
#    subversion \
#    axel \
#    wget \
#    zip \
#    unzip \
#    build-essential \
#    git-core \
#    g++ \
#    pkg-config \
#    libboost1.55-all-dev \
#    libgsl0-dev \
#    libusb-dev \
#    libsdl1.2-dev \
#    python-wxgtk2.8 \
#    python-cheetah \
#    python-lxml \
#    doxygen \
#    libxi-dev \
#    python-sip \
#    libqt4-opengl-dev \
#    libqwt-dev \
#    libfontconfig1-dev \
#    libxrender-dev \
#    python-sip \
#    python-sip-dev \
#    libusb-1.0
RUN git clone https://github.com/gnuradio/gnuradio.git
WORKDIR gnuradio
RUN git pull --recurse-submodules=on && \
    git submodule update --init
RUN mkdir build && \
    ls -al
WORKDIR build
RUN mkdir ../install
RUN cmake -GNinja -DCMAKE_INSTALL_PREFIX=../install \
    -DENABLE_STATIC_LIBS=true \
    -DENABLE_TESTING_SUPPORT=false \
    -DENABLE_GNURADIO_COMPANION=false \
    -DENABLE_DOXYGEN=false \
    -DENABLE_SPHINX=false \
    -DENABLE_GR_CTRLPORT=false \
    -DENABLE_GR_COMEDI=false \
    -DENABLE_GR_QTGUI=false \
    -DENABLE_GR_UHD=false \
    -DENABLE_GR_FCD=false \
    -DENABLE_GR_WXGUI=false \
    -DENABLE_GR_ZEROMQ=false \
    -DENABLE_PERFORMANCE_COUNTERS=false \
    ..
RUN ninja
#RUN ninja test
RUN ninja install
WORKDIR ../install

#FROM ubuntu:latest
#COPY --from=build gnuradio/install/ .
CMD ["grcc"]
