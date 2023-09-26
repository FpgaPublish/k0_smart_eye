// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/09/26 21:39:00
// Design Name: 
// Module Name: tb_sensor_to_video
// Project Name: 
// Target Devices: ZYNQ7010 & XAUG
// Tool Versions: 2021.1
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 
// ***********************************************************************************
`timescale 1ns / 1ps
`include "sensor_to_video.v"
module tb_sensor_to_video #(
    //mode
    parameter MD_SIM_ABLE = 0,
    //number
    parameter NB_CLK_FRE  = 24_000_000,
    //width
    parameter WD_CONFIG_INFO = 16,
    parameter WD_VIDEO_INFO = 16,
    parameter WD_VIDEO_DATA = 8,
    parameter WD_SENSOR_DATA = 8,
    parameter WD_ERR_INFO = 4
   )(
    
);
// =============================================================
// BUS and SIP to generate signals
// --------------------------------------------------------------------
// clock and rst
reg i_sensor_clk = 0;
reg i_sys_resetn = 0;
always #(1000/24/2) i_sensor_clk = ~i_sensor_clk;
initial #100 i_sys_resetn = 1;
wire s_sensor_src_pclk;
wire s_sensor_src_xclk;
wire i_sys_clk = s_sensor_src_xclk;
// --------------------------------------------------------------------
// sensor 
reg                      s_sensor_src_vsyn = 0;
reg                      s_sensor_src_href = 0;
reg [WD_SENSOR_DATA-1:0] s_sensor_src_data = 0;

assign s_sensor_src_pclk = s_sensor_src_xclk;
always@(posedge i_sys_clk)
begin
    repeat(100) @(posedge i_sys_clk);
    s_sensor_src_vsyn <= 1;
    s_sensor_src_data <= 0;
    repeat(1280)
    begin
        repeat(10) @(posedge i_sys_clk);
        s_sensor_src_href <= 1;
        repeat(723) @(posedge i_sys_clk);
        s_sensor_src_href <= 0;
        s_sensor_src_data <= s_sensor_src_data + 1'b1;
    end
    repeat(100) @(posedge i_sys_clk);
    s_sensor_src_vsyn <= 0;
end


// =============================================================
// module to simulate
sensor_to_video#(
    .MD_SIM_ABLE         ( 0 ),
    .NB_CLK_FRE          ( 24_000_000 ),
    .WD_CONFIG_INFO      ( 16 ),
    .WD_VIDEO_INFO       ( 16 ),
    .WD_VIDEO_DATA       ( 8 ),
    .WD_SENSOR_DATA      ( 8 ),
    .WD_ERR_INFO         ( 4 )
)u_sensor_to_video(
    .i_sensor_clk        ( i_sensor_clk        ),
    .i_sys_resetn        ( i_sys_resetn        ),
    .s_sensor_src_pclk   ( s_sensor_src_pclk   ),
    .s_sensor_src_xclk   ( s_sensor_src_xclk   ),
    .s_sensor_src_vsyn   ( s_sensor_src_vsyn   ),
    .s_sensor_src_href   ( s_sensor_src_href   ),
    .s_sensor_src_data   ( s_sensor_src_data   ),
    .s_cinfo_hsync_start ( 3 ),
    .s_cinfo_hsync_finsh ( 723 ),
    .m_video_dst_clock   (    ),
    .m_video_dst_fsync   (    ),
    .m_video_dst_vsync   (    ),
    .m_video_dst_hsync   (    ),
    .m_video_dst_psync   (    ),
    .m_video_dst_vdata   (    ),
    .m_vinfo_dst_fpers   (    ),
    .m_vinfo_dst_hcunt   (    ),
    .m_vinfo_dst_fcunt   (    ),
    .m_err_sensor_info1  (   )
);

// =============================================================
// assertion to monitor 

endmodule