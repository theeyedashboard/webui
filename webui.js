var express = require('express');
var proxy = require('express-http-proxy');
var app = express();

// app.get('/', function (req, res) {
//     res.redirect('/src/public/index.html');
// });

app.use(express.static('src/public'));

var server = app.listen(80, function () {
    console.log('WEBUI running on port 80');
});

app.use('/sampler', proxy('http://sampler', {
  forwardPath: function(req, res) {
    return require('url').parse(req.url).path;
  }
}));
