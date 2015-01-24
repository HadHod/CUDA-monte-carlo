__global__
void estimatePI(int* rslt_data, const double* rnd_values1, const double* rnd_values2) {
    const unsigned int tid = blockIdx.x * blockDim.x + threadIdx.x;
    const double v1 = rnd_values1[tid];
    const double v2 = rnd_values2[tid];

    rslt_data[tid] = (v1 * v1 + v2 * v2 <= 1) ? 1 : 0;
}