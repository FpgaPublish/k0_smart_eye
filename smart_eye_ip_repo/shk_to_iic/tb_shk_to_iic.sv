`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 01:13:31 AM
// Design Name: 
// Module Name: tb_shk_to_iic
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

`include "shk_to_iic.v"
module tb_shk_to_iic#(
    //mode
    parameter MD_SIM_ABLE = 0,
    //number
    parameter NB_SYS_PER  = 10, //ns
    parameter NB_SCL_PER  = 10_000, //ns
    parameter NB_BYT_ONC  = 8, //
    parameter NB_ACK_BIT  = 1, //1bit ack
    //shake bus
    parameter WD_SHK_DATA = 8,
    parameter WD_SHK_ADDR = 16,
    //width
    parameter WD_ERR_INFO = 4
    )(

    );
// --------------------------------------------------------------------
// clock and rst
reg   i_sys_clk      = 0;
reg   i_sys_resetn   = 0;
always #5 i_sys_clk = ~i_sys_clk;
initial #100 i_sys_resetn = 1;

// --------------------------------------------------------------------
// shk
reg                     s_shk_0_valid = 0;
reg                     s_shk_0_msync = 0;
reg  [WD_SHK_DATA-1:0]  s_shk_0_mdata = 0;
reg  [WD_SHK_DATA-1:0]  s_shk_0_mdat1 = 0;
reg  [WD_SHK_ADDR-1:0]  s_shk_0_maddr = 0;
wire                    s_shk_0_ready;
wire                    s_shk_0_ssync;
wire [WD_SHK_DATA-1:0]  s_shk_0_sdata;
wire [WD_SHK_ADDR-1:0]  s_shk_0_saddr;
//
always@(posedge i_sys_clk)
begin
    repeat(100) @(posedge i_sys_clk);
    s_shk_0_valid = 1;
    s_shk_0_mdat1 = 2;
    @(posedge i_sys_clk)
    s_shk_0_valid = 0;
    s_shk_0_msync = 1;
    s_shk_0_mdata = s_shk_0_mdata + 1;
    @(posedge i_sys_clk)
    s_shk_0_msync = 1;
    s_shk_0_mdata = s_shk_0_mdata + 2;
    @(posedge i_sys_clk)
    s_shk_0_msync = 0;
    @(posedge s_shk_0_ready);
    repeat(100) @(posedge i_sys_clk);
    $stop();
end
// --------------------------------------------------------------------
// iic 
wire m_iic_0_sda   ;
wire m_iic_0_scl   ;

    
shk_to_iic#(
    .MD_SIM_ABLE       ( 0 ),
    .NB_SYS_PER        ( 10 ),
    .NB_SCL_PER        ( 10_000 ),
    .NB_BYT_ONC        ( 8 ),
    .NB_ACK_BIT        ( 1 ),
    .WD_SHK_DATA       ( 8 ),
    .WD_SHK_ADDR       ( 16 ),
    .WD_ERR_INFO       ( 4 )
)u_shk_to_iic(
    .i_sys_clk         ( i_sys_clk         ),
    .i_sys_resetn      ( i_sys_resetn      ),
    .s_shk_0_valid     ( s_shk_0_valid     ),
    .s_shk_0_msync     ( s_shk_0_msync     ),
    .s_shk_0_mdata     ( s_shk_0_mdata     ),
    .s_shk_0_mdat1     ( s_shk_0_mdat1     ),
    .s_shk_0_maddr     ( s_shk_0_maddr     ),
    .s_shk_0_ready     ( s_shk_0_ready     ),
    .s_shk_0_ssync     ( s_shk_0_ssync     ),
    .s_shk_0_sdata     ( s_shk_0_sdata     ),
    .s_shk_0_saddr     ( s_shk_0_saddr     ),
    .m_iic_0_sda       ( m_iic_0_sda       ),
    .m_iic_0_scl       ( m_iic_0_scl       ),
    .m_err_shk_info1   (    )
);

    
    

endmodule
