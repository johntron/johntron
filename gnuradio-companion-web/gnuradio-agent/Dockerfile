FROM ubuntu

# Setup timezones so it doesn't break headless installs when it can't figure out which zone to use
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies / packages
RUN apt-get update
RUN apt install -y \
    git \
    gnuradio-dev \
    gr-osmosdr \
    python-pip
#   gqrx-sdr
RUN pip install Flask
#    numpy \
#    scipy \
#    lxml \
#    Cheetah
RUN git clone https://git.osmocom.org/op25
RUN apt install -y cmake ninja-build
# Install op25 GNU radio blocks
WORKDIR op25
#RUN apt build-dep -y gnuradio
RUN apt install -y gnuradio-dev gr-osmosdr librtlsdr-dev libitpp-dev libpcap-dev swig build-essential pkg-config doxygen
RUN rm -rf op25/gr-op25_repeater
COPY op25-cmakelist CMakeLists.txt
RUN mkdir build
WORKDIR build
RUN cmake ../
RUN make
RUN make install
RUN ldconfig

##COPY gnuradio-runtime.conf /etc/gnuradio/conf.d/gnuradio-runtime.conf

# Custom sink for gnuradio-web
COPY custom_sink/grc/custom_sink_sink.xml /usr/share/gnuradio/grc/blocks/
COPY custom_sink/python/__init__.py /usr/lib/python2.7/dist-packages/gnuradio/custom_sink/
COPY custom_sink/python/sink.py /usr/lib/python2.7/dist-packages/gnuradio/custom_sink/

# gnuradio-agent
RUN mkdir server
WORKDIR server
COPY server.py .
COPY __init__.py .
COPY agent/ agent/
ENV FLASK_APP ./server.py
ENV FLASK_ENV development
ENV FLASK_DEBUG 0
EXPOSE 5000
WORKDIR /
CMD python -m flask run --host=0.0.0.0

CMD /usr/bin/gnuradio-companion