# CPU-Design

32 bit non-pipelined RISC-V processor using Micropramming with 3 bus structure.  This is RV32I implementation. 

I need to implement the following classes of instructions:

1.  All computational instructions covered by instruction types R and I. 
2. All memory access instructions (load and store) - I and S type instructions
3.  All Control Flow instructions :  SB type

Once I complete the basic implementation,  I need to add support to 2 new instructions. 
(a) MEMCOPY - Copies an array of size N from one location to another. N > 1 
Determine the max N that you can use for this instruction)

(b) MUL - Unsigned Multiplication (Note that RV32I does not include multiplication instructions)
Identify the limits for operands of this instruction 
