const express = require('express')
const { controller } = require('./controller')

const routerCore = express.Router()

routerCore.get('/', controller)

module.exports = { routerCore }