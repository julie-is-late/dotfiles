#include <stdio.h>

int main() {
  int nDevices;
  cudaGetDeviceCount(&nDevices);

  for (int i = 0; i < nDevices; i++) {
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, i);
    printf("Cuda Dev: %d , Dev name: '%s' , Arch: sm_%d%d \n", i, prop.name, prop.major, prop.minor);
  }
}

