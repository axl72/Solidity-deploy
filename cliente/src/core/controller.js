const path = require('path')

const controller = (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'))
}

module.exports = { controller }