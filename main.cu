#include <iostream>

#include "kernel/main.cu"

using namespace std;

int main(int argc, char* argv[]) {

    NumberGenerator ng;
    const double* randomValues1 = ng.getRandomNumbers(ARRAY_SIZE);
    const double* randomValues2 = ng.getRandomNumbers(ARRAY_SIZE);
    double* resultValues;

    double* dev_randomValues1;
    double* dev_randomValues2;
    double* dev_resultValues;

    const int size = 10;
    const size_t MEMORY_SIZE = size * sizeof(double);
    cudaMalloc((void**) &dev_randomValues1, MEMORY_SIZE);
    cudaMalloc((void**) &dev_randomValues2, MEMORY_SIZE);
    cudaMalloc((void**) &dev_resultValues, MEMORY_SIZE);

    cudaMemcpy(dev_a, a, MEMORY_SIZE, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, MEMORY_SIZE, cudaMemcpyHostToDevice);

    estimatePI<<<10, 10>>>();

    cout << "PI: " << "" << endl;

    return EXIT_SUCCESS;
}