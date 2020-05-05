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
    input [5:0] count_to,
    output overflow,
    output [5:0] current_count
    );
    
    reg [5:0] count = 6'b000000;
    reg overflow_reg = 1'b0;
    
    assign current_count = count;
    assign overflow = overflow_reg;
    
    
    always@(posedge count_with_overflow)
        begin
        count <= count + 6'b1;
        if (count_to == count) begin
            overflow_reg <= 1; 
            count <= 6'b0;
        end
        else begin
            overflow_reg <= 0; 
        end
    end
    
    always@(posedge count_without_overflow)
        begin
        count <= count + 6'b1;
        if (count_to == count) begin
            count <= 6'b0;
        end
    end
        
       
endmodule
