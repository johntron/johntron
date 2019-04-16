from subprocess import Popen

def run_top_block(path, pid):
    '''Spawn flowgraph Python as subprocess'''
    return Popen(['python', path, 'localhost:5000', str(pid)])
