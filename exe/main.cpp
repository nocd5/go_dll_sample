#include "libgofib.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  if (argc != 2) {
    return 1;
  }
  printf("%d\n", fib(atoi(argv[1])));
}
