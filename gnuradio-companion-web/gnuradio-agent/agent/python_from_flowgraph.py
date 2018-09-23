from gnuradio.grc.core.generator.Generator import TopBlockGenerator
from os.path import dirname

DATA_DIR = dirname(__file__)

def save_flowgraph_as_top_block(fg):
    '''Generate Python from flowgraph with grc.core.generator.Generator.TopBlockGenerator#_build_python_code_from_template'''
    generator = TopBlockGenerator(fg, DATA_DIR)
    generator.write()
    return generator.get_file_path()
