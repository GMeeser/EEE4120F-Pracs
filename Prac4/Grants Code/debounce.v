`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 15:40:50
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk, 
    input button,
    output reg out
);

//The clk speed of the board
parameter clk_frequency = 100000;

reg [1:0] previous_state = 1'b0;
reg [21:0] count = 0; //assume count is null on FPGA configuration
reg out = 1'b0;

wire button;

//--------------------------------------------
always @(posedge clk) begin 
    if(count == 0) begin
        if (previous_state != button) begin
            previous_state <= button;
            out <= button;
            //Set the counter to count down from the equavilant of 30ms
            count <= (clk_frequency/100)*30;
        end 
    end
    else count <= count - 1;
end 


endmodule
