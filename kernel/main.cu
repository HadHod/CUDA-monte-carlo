#include <curand_kernel.h>

// __global__ void setup_kernel ( curandState * state, unsigned long seed ) {
//     int id = threadIdx.x;
//     curand_init ( seed, id, 0, &state[id] );
// }

// __global__ void generate( curandState* globalState ) {
//     int ind = threadIdx.x;
//     curandState localState = globalState[ind];
//     float RANDOM = curand_uniform( &localState );
//     globalState[ind] = localState;
// }

__global__
void estimatePI(double* resultData) {
    const unsigned int tid = (blockIdx.x * blockDim.x) + threadIdx.x;

    curandState state;
    // curand_init(tid, tid, 0, &state);
    float RANDOM = curand_uniform( &state );

    printf("Seed: %f %i\n", RANDOM);

    resultData[tid] = true ? 1 : 0;
}