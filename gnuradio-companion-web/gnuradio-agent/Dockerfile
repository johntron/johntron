FROM 1a63031f8a8e
#RUN apt-get update
#RUN apt install -y gnuradio-dev
##COPY gnuradio-runtime.conf /etc/gnuradio/conf.d/gnuradio-runtime.conf
COPY custom_sink/grc/custom_sink_sink.xml /usr/share/gnuradio/grc/blocks/
COPY custom_sink/python/__init__.py /usr/lib/python2.7/dist-packages/gnuradio/custom_sink/
COPY custom_sink/python/sink.py /usr/lib/python2.7/dist-packages/gnuradio/custom_sink/
#
#RUN apt install -y python-pip
#RUN pip install Flask \
#    lxml \
#    Cheetah
RUN mkdir server
WORKDIR server
COPY server.py .
COPY __init__.py .
COPY agent/ agent/
ENV FLASK_APP ./server.py
ENV FLASK_ENV development
ENV FLASK_DEBUG 0
EXPOSE 5000
CMD python -m flask run --host=0.0.0.0
##WORKDIR /
#CMD /usr/bin/gnuradio-companion