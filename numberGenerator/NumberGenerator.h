#ifndef NUMBER_GENERATOR_H
#define NUMBER_GENERATOR_H

#include <iostream>

class NumberGenerator {

    public:
        NumberGenerator();
        NumberGenerator(int r);
        ~NumberGenerator();
        int* getRandomNumbers(int);

    private:
        const int range;

};

#endif // NUMBER_GENERATOR_H