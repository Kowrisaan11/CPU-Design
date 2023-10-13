module control(
	input [31:0] instruction_code,
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump,
	output reg [1:0] ALUOp
	
);
//R type
//OPCODE   |   rd   | funct3 |   rs1   |   rs2   | funct7
//0110011  |  5 bits|  000   |  5 bits |  5 bits|  0000000

//S Type
//OPCODE   | imm[11:5] | funct3 |   rs1   |   rs2   | imm[4:0]
//0100011  |   7 bits  |  010   |  5 bits |  5 bits|  5 bits

//BEQ
//OPCODE   |   imm[12] | imm[10:5] | imm[4:1] | imm[11] | funct3 |   rs1   |   rs2   | imm[8:7] | imm[6] | imm[5:2] | imm[1:0]
//1100011  |  1 bit    |  6 bits   |  4 bits  |  1 bit  |  000   |  5 bits |  5 bits |  2 bits  |  1 bit |  4 bits  |  2 bits

//Load
//OPCODE   |   rd   | funct3 |   rs1   |   imm[11:0]
//0000011  |  5 bits|  000   |  5 bits |  12 bits

//ADDI
//OPCODE   |   rd   | funct3 |   rs1   |   imm[11:0]
//0010011  |  5 bits|  000   |  5 bits |  12 bits

//  always @(*) begin
//	 Jump = 1'b0;
//    if (instruction_code[6:0] == 7'b1100011) begin
//      Branch = 1'b1;
//    end else begin
//      Branch = 1'b0;
//    end
//
//    if (instruction_code[6:0] == 7'b0000011) begin
//      MemRead = 1'b1;
//      MemtoReg = 1'b1;
//      RegWrite = 1'b1;
//    end else begin
//      MemRead = 1'b0;
//      MemtoReg = 1'b0;
//      RegWrite = 1'b0;
//    end
//
//    if (instruction_code[6:0] == 7'b0100011) begin
//      MemWrite = 1'b1;
//    end else begin
//      MemWrite = 1'b0;
//    end
//
//    if (instruction_code[6:0] == 7'b0110011) begin
//      ALUOp[0] = 1'b1;
//      ALUOp[1] = 1'b1;
//      RegWrite = 1'b1;
//    end else if (instruction_code[6:0] == 7'b0000011) begin
//      ALUSrc = 1'b1;
//    end else begin
//      ALUOp[0] = 1'b0;
//      ALUOp[1] = 1'b0;
//      ALUSrc = 1'b0;
//    end 
//  end

assign Jump = (instruction_code[6:0]==1101111) ? 1'b1 : 1'b0; //B Type
assign Branch = (instruction_code[6:0]==1100011) ? 1'b1 : 1'b0; //B Type
assign MemRead = (instruction_code[6:0]==0000011) ? 1'b1 : 1'b0; //Load
assign MemtoReg = (instruction_code[6:0]==0000011) ? 1'b1 : 1'b0; //Load
assign MemWrite = (instruction_code[6:0]==0100011) ? 1'b1 : 1'b0; //Store
assign RegWrite = ((instruction_code[6:0]==0000011) | (instruction_code[6:0]==0110011)) ? 1'b1 : 1'b0; //Load + alu results
assign ALUSrc = (instruction_code[6:0]==0010011) ? 1'b1 : 1'b0; //I type
assign ALUOp[0] = (instruction_code[6:0]==1100011) ? 1'b1 : 1'b0; //BEQ Type
assign ALUOp[1] = (instruction_code[6:0]==0110011) ? 1'b1 : 1'b0; //R Type

endmodule 