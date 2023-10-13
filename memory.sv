module memory(
	input MemRead,
	input MemWrite,
	input [31:0] ram_addr,
	input [31:0] write_data,
	output [31:0] read_data,
	input clk
	
);
wire [31:0] memory_addr = ram_addr[31:0];

reg [31:0] memory [31:0];
    // Initial values for memory
    initial begin
        for (int i = 0; i < 32; i = i + 1) begin
            memory[i] = 0;
        end
    end

always @(posedge clk) begin
	if (MemWrite) memory[memory_addr] = write_data;
end

assign read_data = (MemRead == 1'b1) ? memory[memory_addr]: 16'd0;
endmodule 