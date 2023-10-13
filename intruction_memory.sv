module instruction_memory(
	input [31:0] PC,
	//input reset,
	output reg [31:0] instruction_code
);
	reg [7:0] Memory [31:0];

	assign instruction_code = {Memory[PC+3],Memory[PC+2],Memory[PC+1],Memory[PC]};
	
	initial begin 
			
			// Setting 32-bit instruction: add t1, s0,s1 => 0x004A0566 
            Memory[3] = 8'h00;
            Memory[2] = 8'h4A;
            Memory[1] = 8'h05;
            Memory[0] = 8'h66;
			
				
				//sub t2, s3, s4 (encoded as 0x00A42323):
				Memory[7] = 8'h00;
				Memory[6] = 8'hA4;
				Memory[5] = 8'h23;
				Memory[4] = 8'h23;

				//and t3, s5, s6 (encoded as 0x00B64333):
				Memory[11] = 8'h00;
				Memory[10] = 8'hB6;
				Memory[9] = 8'h43;
				Memory[8] = 8'h33;

				//or t4, s7, s8 (encoded as 0x00C86333):
				Memory[15] = 8'h00;
				Memory[14] = 8'hC8;
				Memory[13] = 8'h63;
				Memory[12] = 8'h33;

	end
endmodule

