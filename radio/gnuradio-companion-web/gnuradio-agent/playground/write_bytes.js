const { writeFileSync } = require('fs');

const data = new Uint32Array([0, 1, 100, 1, 0]);
writeFileSync('./data.bin', data);
