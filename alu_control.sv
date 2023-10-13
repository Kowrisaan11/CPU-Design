module alu_control(
    input reg [31:0] instruction_code,
    input wire [1:0] ALUOp,
    output reg [3:0] ALUControl
);

always @(*) begin
    if (ALUOp == 2'b00 || ALUOp == 2'b01) begin
        ALUControl = 4'b0010; // Common case for ALUOp 00 and 01 (ADD or SUB)
    end else if (ALUOp == 2'b10) begin
        if (instruction_code[14:12] == 3'b000) begin
            if (instruction_code[31:25] == 7'b0000000) begin
                ALUControl = 4'b0010; // ADD
            end else if (instruction_code[31:25] == 7'b0100000) begin
                ALUControl = 4'b0110; // SUB
            end
        end else if (instruction_code[14:12] == 3'b111) begin
            if (instruction_code[31:25] == 7'b0000000) begin
                ALUControl = 4'b0000; // AND
            end
        end else if (instruction_code[14:12] == 3'b110) begin
            if (instruction_code[31:25] == 7'b0000000) begin
                ALUControl = 4'b0001; // OR
            end
        end else begin
            ALUControl = 4'b0000; // Default value for other combinations
        end
    end else begin
        ALUControl = 4'b0000; // Default value for other ALUOp values.
    end
end

endmodule
