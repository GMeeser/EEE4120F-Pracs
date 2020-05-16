`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2020 10:29:18
// Design Name: 
// Module Name: full_sin_wave
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


module full_sin_wave(
    input clk,
    input [31:0] frequency,
    output reg [10:0] data
    );
    
    parameter Clock_Frequency = 100000000; //100MHz
    
    wire [10:0] data_q_wave;
    reg [5:0] address_q_wave;
    reg [7:0] count;
    reg [31:0] clock_counter;
    
    initial begin
        data = 11'd0;
        address_q_wave = 6'd0;
        count = 0;
        clock_counter <= (Clock_Frequency/(frequency*256));;
    end
     
    quarter_sine q_wave ( .clka(clk), .ena(1'b1), .wea(1'b0), .addra(address_q_wave), .douta(data_q_wave));
    
    always@(posedge clk) begin
        clock_counter = (Clock_Frequency/(frequency*256));
        if(clock_counter == 0) begin
            count <= count+1;
            clock_counter <= (Clock_Frequency/(frequency*256));
        end
        else begin
            clock_counter <= clock_counter -1;
        end
        
        if( count < 64 ) begin
            address_q_wave = count;
        end
        else if ( count < 128) begin
            address_q_wave = 63 - count;
        end
        else if( count < 192 ) begin
            address_q_wave = count;
        end
        else begin
            address_q_wave = 63 - count;
        end
       
        if( 0 < count && count < 64 ) begin
            data = data_q_wave + 11'd1024;
        end
        else if ( 60 < count && count < 129) begin
            data = (data_q_wave + 11'd1024);
        end
        else if( 128 < count && count < 192 ) begin
            data = 0 - data_q_wave + 11'd1024;
        end
        else begin
            data = 0 - ((data_q_wave + 11'd1024));
        end
        
    end
endmodule
