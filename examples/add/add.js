var fs = require('fs')
var path = require('path')
module.exports = WebAssembly.Instance(WebAssembly.Module(
  fs.readFileSync(path.join(__dirname, 'add.wasm'))
)).exports

if(!module.parent)
  console.log(module.exports.add(+process.argv[2], +process.argv[3]))
