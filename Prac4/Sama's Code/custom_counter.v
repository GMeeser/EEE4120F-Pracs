`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 11:07:15
// Design Name: 
// Module Name: custom_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module custom_counter(
    input Clk,
    input count_with_overflow,
    input count_without_overflow,
    input [3:0] count_to2, count_to1,
    output reg overflow,
    output reg [3:0] count2, count1
    );
    
    reg  previous_state1 = 1'b0;
    reg  previous_state2 = 1'b0;
    always @(posedge Clk) begin
     if (((count_with_overflow && count_with_overflow != previous_state1) || (count_without_overflow && count_without_overflow != previous_state2))) begin		// reset block
        if (count1 == count_to1 && count2 == count_to2) begin
	           count1 = 4'd0;
	           count2 = 4'd0;
	           if (count_with_overflow) overflow = 1'b1;
	       end 
	       else if (count1 == 4'd9) begin
	           count1 = 4'd0;
	           count2 = count2 + 4'd1; 
	           overflow = 1'b0;
	       end 
	       else begin
	           count1 = count1 + 4'd1;
	           overflow = 1'b0;
	       end					// reset the output to 1
	    if (count_with_overflow) previous_state1 = 1;
	    if (count_without_overflow) previous_state2 = 1;
    end 
    else begin
	    previous_state1 = count_with_overflow;
	    previous_state2 = count_without_overflow;
    end
    end
       
endmodule
