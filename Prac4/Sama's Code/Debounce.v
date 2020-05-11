module Debounce(
    input clk, 
    input button,
    output reg out
);

reg [1:0] previous_state = 1'b0;
reg [21:0] count = 0; //assume count is null on FPGA configuration

reg buttonPressed = 1'b0;

//--------------------------------------------
always @(posedge clk) begin
    if (button && button != previous_state && &count) begin		// reset block
    out <= 1'b1;					// reset the output to 1
	 count <= 0;
	 previous_state <= 1;
    end 
    else if (button && button != previous_state) begin
	 out <= 1'b0;
	 count <= count + 1'b1;
    end 
    else begin
	 out <= 1'b0;
	 previous_state <= button;
    end
end 


endmodule

