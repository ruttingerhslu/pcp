#include <stdio.h>

void printNumbersGoto(int n) {
  int count = 0;
  loop:
  if (count <= n) {
    printf("%d ", count);
    count++;
    goto loop;
  }
}

void printNumbersFor(int n) {
  for (int i = 0; i <= n; i++) {
    printf("%d ", i);
  }
}

void printNumbersRecursiveFunction(int n) {
  if (n >= 0) {
    printNumbersRecursiveFunction(n-1);
    printf("%d ", n);
  }
}

void printReverseNumbersRecursiveFunction(int n) {
  if (n >= 0) {
    printf("%d ", n);
    printReverseNumbersRecursiveFunction(n-1);
  }
}

int main() {
  printNumbersGoto(7);
  printf("= printNumbersGoto(7)\n");
  printNumbersFor(7);
  printf("= printNumbersFor(7)\n");
  printNumbersRecursiveFunction(7);
  printf("= printNumbersRecursiveFunction(7)\n");
  printReverseNumbersRecursiveFunction(7);
  printf("= printReverseNumbersRecursiveFunction(7)\n");
}
