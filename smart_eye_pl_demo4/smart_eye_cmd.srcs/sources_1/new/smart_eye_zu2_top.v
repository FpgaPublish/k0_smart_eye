`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2023 08:43:19 PM
// Design Name: 
// Module Name: smart_eye_zu2_top
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


module smart_eye_zu2_top#(
    parameter NB_LED = 4
    )(
    //system clock
    input   i_port_sys_clk,
    
    //led
    output  [NB_LED-1:0] o_port_led_driv

    );
    
// ====================================================================
// parameter
localparam WD_SHK_DATA = 32;
localparam WD_SHK_ADDR = 32;

localparam WD_IMAG_SET = 128;
// ====================================================================
// variables
//clock and reset
wire w_sys_clk;
wire w_sys_resetn;
//shake with ddr
wire  [WD_SHK_ADDR-1:0]     w_shk_hp_0_maddr;
wire  [WD_SHK_DATA-1:0]     w_shk_hp_0_mdata;
wire                        w_shk_hp_0_msync;
wire                        w_shk_hp_0_ready;
wire  [WD_SHK_DATA-1:0]     w_shk_hp_0_sdata;
wire                        w_shk_hp_0_ssync;
wire                        w_shk_hp_0_valid;
//image set
wire [WD_IMAG_SET-1:0] w_info_imag_set;
// ====================================================================
// modules
clk_wiz_0 u_clk_wiz_mmcm
(
    // Clock out ports
    .clk_out1(w_sys_clk),     // output clk_out1
    // Status and control signals
    .reset(0), // input reset
    .locked(w_sys_resetn),       // output locked
    // Clock in ports
    .clk_in1(i_port_sys_clk)
);      // input clk_in1

smart_eye_pl_wrapper u_smart_eye_pl_wrapper(
    .o_info_imag_set   ( w_info_imag_set   ),
    .o_port_led_driv_0 ( o_port_led_driv   ),
    
    .s_shk_hp_0_maddr  ( w_shk_hp_0_maddr  ),
    .s_shk_hp_0_mdata  ( w_shk_hp_0_mdata  ),
    .s_shk_hp_0_msync  ( w_shk_hp_0_msync  ),
    .s_shk_hp_0_ready  ( w_shk_hp_0_ready  ),
    .s_shk_hp_0_sdata  ( w_shk_hp_0_sdata  ),
    .s_shk_hp_0_ssync  ( w_shk_hp_0_ssync  ),
    .s_shk_hp_0_valid  ( w_shk_hp_0_valid  )
);
// ====================================================================
// ila and vio
ila_imag_set t_ila_imag_set (
	.clk(w_sys_clk), // input wire clk

	.probe0(w_info_imag_set) // input wire [127:0] probe0
);



endmodule
