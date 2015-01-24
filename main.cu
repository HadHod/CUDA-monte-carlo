#include <iostream>

#include "kernel/main.cu"
#include "numberGenerator/NumberGenerator.h"

using namespace std;

int main(int argc, char* argv[]) {
    const int size = 10;

    // TODO calculate max threads on graphic card

    NumberGenerator ng;
    // TODO random values <-1, 1>
    const double* randomValues1 = ng.getRandomNumbers(size);
    const double* randomValues2 = ng.getRandomNumbers(size);
    double* resultValues;

    double* dev_randomValues1;
    double* dev_randomValues2;
    double* dev_resultValues;

    const size_t MEMORY_SIZE = size * sizeof(double);
    cudaMalloc((void**) &dev_randomValues1, MEMORY_SIZE);
    cudaMalloc((void**) &dev_randomValues2, MEMORY_SIZE);
    cudaMalloc((void**) &dev_resultValues, MEMORY_SIZE);

    cudaMemcpy(dev_randomValues1, randomValues1, MEMORY_SIZE, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_randomValues2, randomValues2, MEMORY_SIZE, cudaMemcpyHostToDevice);

    cudaEvent_t start, stop;
    float elapsedTime;

    cudaEventCreate(&start);
    cudaEventRecord(start, 0);

    estimatePI<<<10, 10>>>();
    cudaDeviceSynchronize();

    cudaEventCreate(&stop);
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);

    cudaEventElapsedTime(&elapsedTime, start, stop);
    cout << "Elapsed time: " << elapsedTime << " ms\n";

    cudaMemcpy(resultValues, dev_resultValues, MEMORY_SIZE, cudaMemcpyDeviceToHost);

    // TODO change to functional
    int numOfPointsInCircle = 0;
    for (int i=0; i<size; i++) {
        numOfPointsInCircle += resultValues[i];
    }

    const double result = 4.0 * (double) numOfPointsInCircle / (double) size;
    cout << "estimated value of PI: " << result << endl;

    delete[] randomValues1;
    delete[] randomValues2;
    delete[] resultValues;

    cudaFree(dev_randomValues1);
    cudaFree(dev_randomValues2);
    cudaFree(dev_resultValues);

    return EXIT_SUCCESS;
}