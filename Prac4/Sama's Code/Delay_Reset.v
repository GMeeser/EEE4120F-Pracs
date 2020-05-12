module Delay_Reset(
    input Clk, // Input clock signal
    input BTNS, // Input reset signal (external button)
    output reg Reset // Output reset signal (delayed)
);

//------------------------------------------------------------------------------
reg LocalReset; 
reg [22:0] Count;

//------------------------------------------------------------------------------
always @(posedge Clk) 
begin
    LocalReset <= BTNS;
    if(LocalReset) 
        begin
        Count <= 0;
        Reset <= 1'b1;
    end 
    else if(&Count) 
    begin
        Reset <= 1'b0;
    end else 
    begin
        Reset <= 1'b1;
        Count <= Count + 1'b1;
    end
end
endmodule

