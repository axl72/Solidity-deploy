const express = require('express')
const { routerCore } = require('./core/route')
const path = require('path')

const app = express()

app.set('port', process.env.PORT || 3000)

app.use(express.static(path.join(__dirname, '/public')));
app.use(express.static('build/contracts'))
app.use(express.static('node_modules'))

app.use('/', routerCore)


app.listen(app.get('port'), () =>{
    console.log('Server on port 3000')
})
