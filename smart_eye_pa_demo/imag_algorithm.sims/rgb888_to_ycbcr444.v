`timescale 1ns / 1ps
/*
```verilog
*/
// *******************************************************************************
// Company: Fpga Publish
// Engineer: FP 
// 
// Create Date: 2023/07/29 15:16:38
// Design Name: 
// Module Name: rgb888_to_ycbcr444
// Project Name: 
// Target Devices: ZYNQ7010 | XCZU2CG | Kintex7
// Tool Versions: 2021.1
// Description: 
//         * 
// Dependencies: 
//         * 
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 
// *******************************************************************************

module rgb888_to_ycbcr444 #(
    //mode
    parameter MD_SIM_ABLE = 0,
    //number
    
    //width
    parameter WD_IMG_DATA = 8,
    parameter WD_ERR_INFO = 4
   )(
    //system signals
    input           i_sys_clk   ,  
    input           i_sys_resetn,  
    //imag interface rgb888
    input                       s_img_rgb888_c_fsync,
    input                       s_img_rgb888_c_vsync,
    input                       s_img_rgb888_c_hsync,
    input  [WD_IMG_DATA-1:0]    s_img_rgb888_r_mdat0,
    input  [WD_IMG_DATA-1:0]    s_img_rgb888_g_mdat1,
    input  [WD_IMG_DATA-1:0]    s_img_rgb888_b_mdat2,
    //imag interface ycbcr444
    output                      m_img_ycbcr444_c_fsync,
    output                      m_img_ycbcr444_c_vsync,
    output                      m_img_ycbcr444_c_hsync,
    output  [WD_IMG_DATA-1:0]   m_img_ycbcr444_y_mdat0,
    output  [WD_IMG_DATA-1:0]   m_img_ycbcr444_b_mdat1,
    output  [WD_IMG_DATA-1:0]   m_img_ycbcr444_r_mdat2,
    
    //error info feedback
    output   [WD_ERR_INFO-1:0]  m_err_rgb888_info1
);
//========================================================
//function to math and logic
 
//========================================================
//localparam to converation and calculate
localparam WD_DN_SYNC = 3;
//========================================================
//register and wire to time sequence and combine
/* end verilog
```
* just list Y stream, other like
```mermaid
stateDiagram
r-->r_m1: * 
g-->g_m1: * 
b-->b_m1: *
r_m1-->a1: +
c   -->a1: +
g_m1-->a2: +
b_m1-->a2: +
a1-->a3: +
a2-->a3: -/+
```
```verilog
*/
// ----------------------------------------------------------
// rgb mult calculate
reg [WD_IMG_DATA*2-1:0]    r_rgb888_r_mdat0_m1, r_rgb888_r_mdat0_m2, r_rgb888_r_mdat0_m3;
reg [WD_IMG_DATA*2-1:0]    r_rgb888_g_mdat1_m1, r_rgb888_g_mdat1_m2, r_rgb888_g_mdat1_m3;
reg [WD_IMG_DATA*2-1:0]    r_rgb888_b_mdat2_m1, r_rgb888_b_mdat2_m2, r_rgb888_b_mdat2_m3;
// ----------------------------------------------------------
// YCbCr add calculate
reg [WD_IMG_DATA*2-1:0] r_ycbcr444_y_mdat0_a1,r_ycbcr444_y_mdat0_a2;
reg [WD_IMG_DATA*2-1:0] r_ycbcr444_b_mdat1_a1,r_ycbcr444_b_mdat1_a2;
reg [WD_IMG_DATA*2-1:0] r_ycbcr444_r_mdat2_a1,r_ycbcr444_r_mdat2_a2;
reg [WD_IMG_DATA*2-1:0] r_ycbcr444_y_mdat0_a3;
reg [WD_IMG_DATA*2-1:0] r_ycbcr444_b_mdat1_a3;
reg [WD_IMG_DATA*2-1:0] r_ycbcr444_r_mdat2_a3;
// ----------------------------------------------------------
// sync control
reg [WD_DN_SYNC-1:0] r_ycbcr444_c_fsync_dn;
reg [WD_DN_SYNC-1:0] r_ycbcr444_c_vsync_dn;
reg [WD_DN_SYNC-1:0] r_ycbcr444_c_hsync_dn;

//========================================================
//always and assign to drive logic and connect
// ----------------------------------------------------------
// rgb mult calculate
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        //r
        r_rgb888_r_mdat0_m1 <= s_img_rgb888_r_mdat0 * 8'd76 ;
        r_rgb888_r_mdat0_m2 <= s_img_rgb888_r_mdat0 * 8'd43 ;
        r_rgb888_r_mdat0_m3 <= s_img_rgb888_r_mdat0 * 8'd128;
        //g
        r_rgb888_g_mdat1_m1 <= s_img_rgb888_g_mdat1 * 8'd150;
        r_rgb888_g_mdat1_m2 <= s_img_rgb888_g_mdat1 * 8'd84 ;
        r_rgb888_g_mdat1_m3 <= s_img_rgb888_g_mdat1 * 8'd107;
        //b
        r_rgb888_b_mdat2_m1 <= s_img_rgb888_b_mdat2 * 8'd29 ;
        r_rgb888_b_mdat2_m2 <= s_img_rgb888_b_mdat2 * 8'd128;
        r_rgb888_b_mdat2_m3 <= s_img_rgb888_b_mdat2 * 8'd20 ;
    end
end
// ----------------------------------------------------------
// YCbCr add calculate
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_ycbcr444_y_mdat0_a1 <= r_rgb888_r_mdat0_m1 + 0; 
        r_ycbcr444_b_mdat1_a1 <= r_rgb888_b_mdat2_m2 + 16'd32768; 
        r_ycbcr444_r_mdat2_a1 <= r_rgb888_r_mdat0_m3 + 16'd32768; 
        
        r_ycbcr444_y_mdat0_a2 <= r_rgb888_g_mdat1_m1 + r_rgb888_b_mdat2_m1; 
        r_ycbcr444_b_mdat1_a2 <= r_rgb888_g_mdat1_m2 + r_rgb888_r_mdat0_m2; 
        r_ycbcr444_r_mdat2_a2 <= r_rgb888_g_mdat1_m3 + r_rgb888_b_mdat2_m3; 
        
    end
end
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_ycbcr444_y_mdat0_a3 <= r_ycbcr444_y_mdat0_a1  + r_ycbcr444_y_mdat0_a2;
        r_ycbcr444_b_mdat1_a3 <= r_ycbcr444_b_mdat1_a1  - r_ycbcr444_b_mdat1_a2;
        r_ycbcr444_r_mdat2_a3 <= r_ycbcr444_r_mdat2_a1  - r_ycbcr444_r_mdat2_a2;
    end
end
assign m_img_ycbcr444_y_mdat0  = r_ycbcr444_y_mdat0_a3[WD_IMG_DATA*2-1:WD_IMG_DATA];
assign m_img_ycbcr444_b_mdat1  = r_ycbcr444_b_mdat1_a3[WD_IMG_DATA*2-1:WD_IMG_DATA];
assign m_img_ycbcr444_r_mdat2  = r_ycbcr444_r_mdat2_a3[WD_IMG_DATA*2-1:WD_IMG_DATA];
// ----------------------------------------------------------
// sync control
always@(posedge i_sys_clk)
begin
    if(!i_sys_resetn)
        begin
            r_ycbcr444_c_fsync_dn <= 1'b0;
            r_ycbcr444_c_vsync_dn <= 1'b0;
            r_ycbcr444_c_hsync_dn <= 1'b0;
        end
    else if(1) //update in one cycle
    begin
        r_ycbcr444_c_fsync_dn <= {r_ycbcr444_c_fsync_dn[WD_DN_SYNC-2:0],s_img_rgb888_c_fsync};
        r_ycbcr444_c_vsync_dn <= {r_ycbcr444_c_vsync_dn[WD_DN_SYNC-2:0],s_img_rgb888_c_vsync};
        r_ycbcr444_c_hsync_dn <= {r_ycbcr444_c_hsync_dn[WD_DN_SYNC-2:0],s_img_rgb888_c_hsync};
    end
end
assign m_img_ycbcr444_c_fsync = r_ycbcr444_c_fsync_dn[WD_DN_SYNC-1];
assign m_img_ycbcr444_c_vsync = r_ycbcr444_c_vsync_dn[WD_DN_SYNC-1];
assign m_img_ycbcr444_c_hsync = r_ycbcr444_c_hsync_dn[WD_DN_SYNC-1];
//========================================================
//module and task to build part of system

//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor

endmodule