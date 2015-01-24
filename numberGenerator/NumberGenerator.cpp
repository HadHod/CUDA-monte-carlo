#include <iostream>
#include <climits>
#include <ctime>
#include <chrono>

#include "NumberGenerator.h"

using namespace std;
using namespace std::chrono;

NumberGenerator::NumberGenerator(): range(INT_MAX) { }

NumberGenerator::NumberGenerator(int r): range(abs(r)) { }

NumberGenerator::~NumberGenerator() {

}

int* NumberGenerator::getRandomNumbers(const int count) {
    srand(high_resolution_clock::now().time_since_epoch().count());
    int* result = new int[count];

    for (int i=0; i<count; i++) {
        const bool isNegative = rand() % 2 == 0;
        result[i] = (rand() % range) * (isNegative ? -1 : 1);
    }

    return result;
}

double* NumberGenerator::getrandomDoubles(const int count) {
    // TODO
}