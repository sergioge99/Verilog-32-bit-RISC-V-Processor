# pa_core
PROCESSOR ARCHITECTURE

Final Project: Verilog design for a 32-bit RISC-V Processor

Sergio García Esteban
sergio.garcia@bsc.es

22/01/2023

In this project a processor has been designed and implemented from scratch. As initial decisions, Verilog as RTL language, ModelSim as RTL simulator, RISC-V as ISA and VisualStudioCode as programming environment are chosen.

The designed processor consists of 5 segmented stages (F, D, A, C, W), execution in order and 1 instruction launched per cycle. 
The instruction set supported by the processor are the following RISC-V instructions: ADD, ADDI, SUB, SUBI, SLL, SLLI, SLR, SLRI, MUL, LDW, STW, BEQ, BNE.
The MUL instruction takes 5 cycles to execute, so the pipeline is lengthened in this case to F, D, M1, M2, M3, M4, M5, C, W.
The calculation of the jump instructions BEQ, BNE and JUMP is advanced to the D stage to reduce the performance loss at each jump.
The processor includes the complete set of bypasses.
The processor includes Instruction Cache and Data Cache, both 4 lines of 128b each, Direct Mapped. Each time one of the caches has to go to main memory it will take 10 cycles to go and return.

Only the raw processor pipeline has been developed, it does not include virtual memory or exceptions. Mechanisms such as Store Buffer or Reorder Buffer have neither been implemented.
The processor is capable of running the 3 proposed benchmarks, BufferSum, MemCopy and MatrixMultiply.
