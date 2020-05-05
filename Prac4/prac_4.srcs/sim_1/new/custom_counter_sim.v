`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 11:55:16
// Design Name: 
// Module Name: custom_counter_sim
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


module custom_counter_sim(
    );
    reg [5:0] count_to = 6'd12;
    
    wire overflow,count;
    wire [5:0] counter;
    
    custom_counter cc (.counter_with_overflow(count), .overflow(overflow), .count_to(count_to), .current_count(counter));
    
    
endmodule
