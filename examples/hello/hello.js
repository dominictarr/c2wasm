var fs = require('fs')
var path = require('path')

var buffer
module.exports = WebAssembly.Instance(WebAssembly.Module(
  fs.readFileSync(path.join(__dirname, 'hello.wasm')), 
), {
    env: {
      console_log: function (ptr, length) {
        console.log(buffer.toString('utf8', ptr, ptr+length))
      }
    }
  }).exports

buffer = Buffer.from(module.exports.memory.buffer)

if(!module.parent)
  module.exports.hello()

