`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 01:28:45 AM
// Design Name: 
// Module Name: tb_led_74595_driver
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


module tb_led_74595_driver(

    );
    
reg   clk     = 0;
reg   rst_n   = 0;
reg  [7:0] led_data = 0;
always #5 clk = ~clk;
initial #100 rst_n = 1;
always #1000 led_data = $urandom_range(100, 200);
    
    
led_74595_driver u_led_74595_driver(
    .clk          ( clk          ),
    .rst_n        ( rst_n        ),
    .led595_dout  (  ),
    .led595_clk   (  ),
    .led595_latch (  ),
    .led_data     ( led_data     )
);

    
endmodule
