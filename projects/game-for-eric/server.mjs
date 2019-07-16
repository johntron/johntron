const express = require('express')
const app = new express()
app.use(express.static('.'))
app.listen(8080, () => console.log('Listening'))