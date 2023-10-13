module datapath(
	input clk,
	input reset
);

reg [31:0] instruction_code;
reg [31:0] write_data;
reg [31:0] read_data;
reg [31:0] read_data1;
reg [31:0] read_data2;
reg RegWrite;
reg MemRead;
reg MemWrite;
reg [31:0] alu_result;
reg [31:0] in2;
reg [3:0] ALUControl;
reg zero_flag;
		
reg Branch;
reg MemtoReg;
reg ALUSrc;
reg [1:0] ALUOp;
		
reg [31:0] PC;
reg jump;
reg branch;
reg [31:0] PC_in;
reg [31:0] PC_mux1;

//initial begin 
//		instruction_code = 32'b0;
//		write_data = 0;
//		read_data = 0;
//		read_data1 = 0;
//		read_data2 = 0;
//		RegWrite = 0;
//		MemRead = 0;
//		MemWrite = 0;
//		alu_result = 0;
//		in2 = 0;
//		ALUControl = 0;
//		zero_flag = 0;
//		
//		Branch = 0;
//		MemtoReg = 0;
//		ALUSrc = 0;
//		ALUOp = 0;
//		
//		PC = 0;
//		jump = 0;
//		branch = 0;
//	end

assign in2 = (ALUSrc) ? instruction_code:read_data2;
assign write_data = (MemtoReg) ? read_data:alu_result;
assign branch = Branch && zero_flag;

assign PC_mux1 = (branch) ? (instruction_code+PC):PC;  //branch mux
assign PC_in = (jump) ? instruction_code:PC_mux1;  //jump mux

register Register(
	.rs1(instruction_code [19:15]),
	.rs2(instruction_code [24:20]),
	.write_reg(instruction_code [11:7]),		//ins
	.write_data(write_data),
	.read_data1(read_data1),		
	.read_data2(read_data2),		//
	.RegWrite(RegWrite),
	.clk(clk),
	.reset(reset)
);

memory Memory(
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.ram_addr(alu_result),
	.write_data(read_data2),
	.read_data(read_data),
	.clk(clk)
	
);

alu ALU(
    .in1(read_data1),
	 .in2(in2),
    .alu_control(ALUControl),
    .alu_result(alu_result), 
    .zero_flag(zero_flag) 
);

programm_counter programm_counter(
	.clk(clk),
	.reset(reset),
	.PC_in(PC_in),
//	.branch(branch), 
//	.jump(jump), 
//	.branch_target(instruction_code), //ins branch
//	.jump_target(instruction_code),	//ins jump
	.PC(PC)
);

instruction_memory instruction_memory(
	.PC(PC),
	//input reset,
	.instruction_code(instruction_code)
);

control control(
	.instruction_code(instruction_code),
	.Branch(Branch),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.Jump(jump),
	.ALUOp(ALUOp)	
);

alu_control alu_control(
    .instruction_code(instruction_code),
    .ALUOp(ALUOp),
    .ALUControl(ALUControl)
);

endmodule 