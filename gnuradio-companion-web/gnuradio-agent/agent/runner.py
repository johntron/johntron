from .xml_to_flowgraph import xml_to_flowgraph
from .python_from_flowgraph import save_flowgraph_as_top_block
from .run_top_block import run_top_block

incrementor = 0

class Runner(object):
    def __init__(self):
        global incrementor
        self.id = incrementor
        self.buffer = []
        incrementor += 1

    def run(self, xml):
        flowgraph = xml_to_flowgraph(xml)
        path = save_flowgraph_as_top_block(flowgraph)
        self.process = run_top_block(path, self.id)

    def terminate(self):
        self.process.terminate()

    def data(self, data):
        self.buffer.append(data)

    def clear_buffer(self):
        self.buffer = []