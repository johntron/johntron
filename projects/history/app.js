const express = require('express');
const request_logger = require('./request_logger.js');
const config = require('./config.js');
const Timeline = require('./timeline.js');

const port = 8000;
const app = new express();

app.use(express.json());
app.use(request_logger);

debugger;
const timeline = new Timeline(config.timeline_path);
timeline.loadSync();

app.get('/', (req, res) => res.end('Running'));

app.post('/event/create', async (req, res) => {
  timeline.event(req.body);
  await timeline.save();
  res.end();
});

app.listen(port, () => {
	console.log(`Server listening on ${port}`);
});
