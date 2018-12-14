const { Router } = require('express');
const { inspect } = require('util')

const router = new Router();

router.get('/', (req, res) => {
  res.send(`home ${inspect(req)}`);
})

module.exports = router;