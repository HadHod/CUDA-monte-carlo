all:
	nvcc -std=c++11 main.cu --compiler-options -Wall -Xcompiler -lgomp -lrt -o main

run:
	./main

debug:
	gdb --args ./main

clear:
	rm main