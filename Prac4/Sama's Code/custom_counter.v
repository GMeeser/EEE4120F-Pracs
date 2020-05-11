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
    input count_with_overflow,
    input count_without_overflow,
    input [3:0] count_to2, count_to1,
    output reg overflow,
    output reg [3:0] count2, count1
    );
    
    always @(posedge count_with_overflow, posedge count_without_overflow) begin
       if (count_without_overflow) begin
           if (count1 == count_to1 && count2 == count_to2) begin
	           count1 = 4'd0;
	           count2 = 4'd0;
	       end 
	       else if (count1 == 4'd9) begin
	           count1 = 4'd0;
	           count2 = count2 + 4'd1; 
	       end 
	       else begin
	           count1 = count1 + 4'd1;
	       end
       end
       else begin
           if (count1 == count_to1 && count2 == count_to2) begin
	           count1 = 4'd0;
	           count2 = 4'd0;
	           overflow = 1'b1;
	       end 
	       else if (count1 == 4'd9) begin
	           count1 = 4'd0;
	           count2 = count2 + 4'd1;
	           overflow = 1'b0;
	       end 
	       else begin
	           count1 = count1 + 4'd1;
	           overflow = 1'b0;
	       end
	   end
    end
        
       
endmodule
