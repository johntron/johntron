## Decision tree

[Mermaid] syntax:

    graph LR
    B(Build and run rtl_tcp)
    C(Compile GRC w/gro-osmocom)
    B-->D(Test rtl_tcp source block w/Docker)
    C-->D
    G(Webserver)-->H(Run gr subprocess)
    H-->I(Load / run XML)
    J(FFT sink)-->K(FFT visualization)
    E(Audio streaming?)
    F(Control and data protocols?)


## Running

Start the runner (from gnuradio-runner directory):

    docker run --interactive \
        --env PYTHONPATH=/gnuradio/install/lib/python2.7/dist-packages \
        --env LD_LIBRARY_PATH=/gnuradio/install/lib \
        --volume `pwd`:/saves \
         grcc python < top_block.py


## Reference
* [Building GNU Radio]
* [TCP enabled version of librtlsdr]
* [Blocks XML]
* [Other blocks XML]
* [Blocks tree]
* [Flow graph DTD]
* [JSON / XML conversion] (data2xml)


[Mermaid]: https://mermaidjs.github.io/mermaid-live-editor/
[Building GNU Radio]: https://www.gnuradio.org/doc/doxygen/build_guide.html
[TCP enabled version of librtlsdr]: https://www.rtl-sdr.com/tcp-enabled-version-librtlsdr/
[Blocks XML]: https://github.com/gnuradio/gnuradio/tree/adaa7a265eef17d3b2f9a991e944fe20677b069b/grc/blocks
[Other blocks XML]: https://github.com/gnuradio/gnuradio/tree/adaa7a265eef17d3b2f9a991e944fe20677b069b/gr-blocks/grc
[Blocks tree]: https://github.com/gnuradio/gnuradio/blob/adaa7a265eef17d3b2f9a991e944fe20677b069b/gr-blocks/grc/blocks_block_tree.xml
[Flow graph DTD]: https://github.com/gnuradio/gnuradio/blob/adaa7a265eef17d3b2f9a991e944fe20677b069b/grc/core/flow_graph.dtd
[JSON / XML conversion]: https://npms.io/search?q=json+to+xml