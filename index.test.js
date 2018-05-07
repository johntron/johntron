const assert = require('assert');
const {it} = require('mocha');
const index = require('.');

it('Should return true when called', () => {
	assert.equal(index(), true);
});
