const { promisify } = require('util');
const { readFileSync, appendFile } = require('fs')
const append = promisify(appendFile);

module.exports = class Timeline {
  constructor(path) {
    this.path = path;
    this.events = [];
    this.pending = [];
  }

  async save() {
    const pending = this.pending.map(i => this.events[i])
        .map(JSON.stringify)
        .join('\n') + '\n';
    await append(this.path, pending);
    this.pending = []
  }

  loadSync() {
    const events = String(readFileSync(this.path)).trim();
    if (events) {
      this.events = events.split('\n').map(JSON.parse);
    }
  }

  event(event) {
    this.events.push(event);
    this.pending.push(this.events.length - 1);
  }
}