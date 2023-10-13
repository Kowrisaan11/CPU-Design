module program_counter_tb;
	 timeunit 1ns; 
	 timeprecision 1ps;
    reg clk;
    reg reset;
    reg branch;
    reg jump;
    reg [31:0] branch_target;
    reg [31:0] jump_target;
    wire [31:0] PC;

    // Instantiate the programm_counter module
    program_counter dut (
        .clk(clk),
        .reset(reset),
        .branch(branch),
        .jump(jump),
        .branch_target(branch_target),
        .jump_target(jump_target),
        .PC(PC)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle the clock every 5 time units
    end

    // Initial values and stimulus generation
    initial begin
        clk = 0;
        reset = 0;
        branch = 0;
        jump = 0;
        branch_target = 32'h00000010; // Example branch target
        jump_target = 32'h00000020;   // Example jump target

        // Reset the module
        reset = 1;
        #10 reset = 0;

        // Test case 1: No branch or jump
        #20;
        branch = 0;
        jump = 0;
        $display("PC = %h", PC); // PC should increment by 4
        assert(PC == 32'h00000004) else $fatal("Test case 1 failed");

        // Test case 2: Branch instruction
        #20;
        branch = 1;
        $display("PC = %h", PC); // PC should be branch_target + 4
        assert(PC == (branch_target + 32'h00000004)) else $fatal("Test case 2 failed");

        // Test case 3: Jump instruction
        #20;
        branch = 0;
        jump = 1;
        $display("PC = %h", PC); // PC should be jump_target
        assert(PC == jump_target) else $fatal("Test case 3 failed");

        // Test case 4: Combination of branch and jump
        #20;
        branch = 1;
        jump = 1;
        $display("PC = %h", PC); // PC should be jump_target + 4
        assert(PC == (jump_target + 32'h00000004)) else $fatal("Test case 4 failed");

        $finish;
    end
endmodule
