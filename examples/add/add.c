//add.c

//make this weird macro
#define export __attribute__ ((visibility ("default")))

//then at least this looks reasonable.
export
int add (int a, int b) {
  return a + b;
}

