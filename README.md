# c2wasm

I jumped through all the hoops for you, so you can convert c to wasm.

pieced together from various clues:

* prebuilt wasm producing clang [yurydelendik/clang-heroku-slug](https://github.com/yurydelendik/clang-heroku-slug/tree/master/precomp) (as used in [webassembly-explorer](https://mbebenita.github.io/WasmExplorer/))
* hints about compiler and linker args from [aransentin](https://aransentin.github.io/cwasm/)
* also from [wasmception](https://github.com/yurydelendik/wasmception)
* inspecting output with [wabt](https://github.com/WebAssembly/wabt)
* learning the raw web assembly format from [webassembly semantics](https://webassembly.org/docs/semantics/)

## performance optimizations

The first output I generated was surprisingly bloated, (seemed to be inlining too much or something?,
creating lots of i32 variables) also, wasn't faster than my carefully optimized javascript.
but turns out clang has lots of [optimization options](https://stackoverflow.com/questions/15548023/clang-optimization-levels) - I ended up using `-O3`

## imports and exports

### wasm method, accessable from javascript

``` c
//make this weird macro
#define export __attribute__ ((visibility ("default")))

//then at least this looks reasonable.
export
int add (int a, int b) {
  return a + b
}
```
compile to wasm

``` bash
cd examples/add
c2wasm add.c -o add.wasm
```

see `./example/add/add.js` for how to call this from javascript

### javascript method, accessable from wasm

``` c
#define export __attribute__ ((visibility ("default")))

//since this is undefined, it's treated as an import
void console_log (char* string, int length);

export
void hello () {
  char string[]="hello world";
  console_log(&string, sizeof(string));
}
```

compile the same as before, and again, see `./examples/hello/hello.js` for how to call
from javascript, and pass import in from javascript too.

## future work

it's kinda lame to be downloading (and compiling) all these nasty c compilers
to build a tiny bit of wasm. isn't the point of wasm to be an actually portable
binary target? why can't we compile clang _to wasm_ and then install clang.wasm
from npm?

[clang-in-browser](https://tbfleming.github.io/cib/) does that. somebody should
wrap that into a node module!

## License

MIT

