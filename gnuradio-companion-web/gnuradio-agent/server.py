print 'running'
from flask import Flask, request
from .agent.runner import Runner
from json import dumps

app = Flask(__name__)

running = {}

@app.route('/', methods=['POST'])
def run():
    xml = request.json['grc']
    runner = Runner()
    runner.run(xml)
    running[str(runner.id)] = runner
    message = "started {} (pid {})".format(runner.id, runner.process.pid)
    print(message)
    print(running)
    return message

@app.route('/stop', methods=['POST'])
def stop():
    global running
    stopped_ids = []
    stopped_pids = []
    for (id, runner) in running.iteritems():
        stopped_ids.append(str(runner.id))
        stopped_pids.append(str(runner.process.pid))
        runner.terminate()
    running = {}
    message = "stopped {}, pids {}".format(", ".join(stopped_ids), ", ".join(stopped_pids))
    print(message)
    return message

@app.route('/data', methods=['POST'])
def data():
    data = request.json
    runner = running[str(data['id'])]
    runner.data(data['data'])
    print 'data', data
    print('id {}, pid {}'.format(runner.id, runner.process.pid))
    return 'gotcha'

@app.route('/all_buffers', methods=['GET'])
def all_buffers():
    payload = {}
    for (id, runner) in running.iteritems():
        payload[id] = runner.buffer
        runner.clear_buffer()
    print payload
    return dumps(payload)