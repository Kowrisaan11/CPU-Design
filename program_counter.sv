module program_counter(
	input clk,
	input reset,
	input [31:0] PC_in,
	output reg [31:0] PC
);

	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
            PC <= 32'h00000000;
      end
		else begin
				PC = PC_in + 32'h00000004;
		end
   end

endmodule





//module program_counter(
//    input clk,
//    input reset,
//    input [31:0] PC_in,
//    input wire branch,
//    input wire jump,
//    input wire [31:0] branch_target,
//    input wire [31:0] jump_target,
//    output reg [31:0] PC
//);
//
//    reg [31:0] PC_adder;
//    reg [31:0] PC_mux1;
//
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            PC <= 32'h00000000;
//            PC_adder <= 32'h00000000;
//            PC_mux1 <= 32'h00000000;
//        end
//        else begin
//            PC_adder = PC_in + 32'h00000004;
//            PC_mux1 = (branch) ? (branch_target + PC_adder) : PC_adder;
//            PC = (jump) ? jump_target : PC_mux1;
//        end
//    end
//endmodule
