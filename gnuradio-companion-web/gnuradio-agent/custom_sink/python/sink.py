from gnuradio import gr
from argparse import ArgumentParser
from httplib import HTTPConnection
from json import dumps

parser = ArgumentParser()
parser.add_argument('server')
parser.add_argument('id')

class sink(gr.sync_block):
    """
    docstring for block sink
    """
    def __init__(self, item_type, vector_length):
        gr.sync_block.__init__(self,
            name="sink",
            in_sig=[(item_type, vector_length)],
            out_sig=None)
        args = parser.parse_args()
        self.server = args.server
        self.data_url = "/data"
        self.id = args.id

    def work(self, input_items, output_items):
        in0 = input_items[0].tolist()
        payload = {
            "id": self.id,
            "data": in0
        }
        print 'sending'
        self.conn = HTTPConnection(self.server)
        self.conn.request("POST", self.data_url, headers={'content-type': 'application/json'}, body=dumps(payload))
        # result = self.conn.getresponse()
        # print('result', result.read())
        return len(input_items[0])

