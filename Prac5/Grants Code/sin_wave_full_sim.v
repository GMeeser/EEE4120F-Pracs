`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2020 11:02:17
// Design Name: 
// Module Name: sin_wave_full_sim
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


module sin_wave_full_sim(
    
    );
    
    reg clock_1;
    wire [10:0] out_1;
    
    full_sin_wave sin(.clk(clock_1), .data(out_1), .frequency(10000));
    
    initial begin
        clock_1 = 1'b0;
    end
    
    always begin
        #5
        clock_1 = 1'b0;
        #5
        clock_1 = 1'b1;
    end
   
    

    
endmodule
