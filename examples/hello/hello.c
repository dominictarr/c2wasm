#define export __attribute__ ((visibility ("default")))

//since this is undefined, it's treated as an import
void console_log (char* string, int length);

export
void hello () {
  char string[]="hello world";
  console_log(&string, sizeof(string));
}

