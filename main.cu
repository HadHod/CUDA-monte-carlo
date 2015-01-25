#include <iostream>

#include "kernel/main.cu"

using namespace std;

int main(int argc, char* argv[]) {
    const int size = 10;

    double* resultValues = new double[size];
    double* dev_resultValues;

    const size_t MEMORY_SIZE = size * sizeof(double);
    cudaMalloc((void**) &dev_resultValues, MEMORY_SIZE);

    estimatePI<<<1, 10>>>(dev_resultValues);
    cudaDeviceSynchronize();

    cudaMemcpy(resultValues, dev_resultValues, MEMORY_SIZE, cudaMemcpyDeviceToHost);

    // TODO change to functional
    int numOfPointsInCircle = 0;
    for (int i=0; i<size; i++) {
        numOfPointsInCircle += resultValues[i];
    }

    const double result = 4.0 * (double) numOfPointsInCircle / (double) size;
    cout << "estimated value of PI: " << result << endl;

    delete[] resultValues;

    cudaFree(dev_resultValues);

    return EXIT_SUCCESS;
}