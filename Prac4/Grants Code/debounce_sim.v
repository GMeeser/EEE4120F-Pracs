`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 16:03:51
// Design Name: 
// Module Name: debounce_sim
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


module debounce_sim(

    );
    
    wire button, out;
    reg clock= 1'b0;
    reg btn = 1'b0;
    assign button = btn;
    
    debounce d_btn (.clk(clock), .button(button), .out(out));
    
    always begin
        #5000
        clock = 1'b0;
        #5000
        clock = 1'b1;
    end
    
    always begin
        #700
        btn = 1'b0;
        #700
        btn = 1'b1;
    end
    
    
    
endmodule
