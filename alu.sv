module alu(
    input [31:0] in1, in2,
    input [3:0] alu_control,
    output reg [31:0] alu_result, // Use "reg" for output signals
    output reg zero_flag // Use "reg" for output signals
);

    always @(*) begin
        case (alu_control)
            4'b0000: alu_result = in1 & in2;
            4'b0001: alu_result = in1 | in2;
            4'b0010: alu_result = in1 + in2;
            4'b0110: alu_result = in1 - in2;
            // Add more cases for other operations as needed
            default: alu_result = 32'b0; // Default value
        endcase

        if (alu_result == 0) 
            zero_flag = 1'b1;
        else 
            zero_flag = 1'b0;
    end
endmodule