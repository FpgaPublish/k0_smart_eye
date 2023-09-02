`timescale 1ns / 1ps
/*
```verilog
*/
// *******************************************************************************
// Company: Fpga Publish
// Engineer: FP 
// 
// Create Date: 2023/08/26 19:27:31
// Design Name: 
// Module Name: histogram_image
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
module histogram_image #(
    //mode
    parameter MD_SIM_ABLE = 0,
    //number
    parameter NB_IMG_HORI = 960,
    parameter NB_IMG_VERT = 640,
    //width
    parameter WD_IMG_DATA = 8,
    parameter WD_BRAM_ADR = 8,
    parameter WD_BRAM_DAT = 32,
    parameter WD_ERR_INFO = 4
   )(
    //system signals
    input           i_sys_clk  ,  
    input           i_sys_resetn,  
    //imag interface gray
    input                       s_img_gray_c_fsync,
    input                       s_img_gray_c_vsync,
    input                       s_img_gray_c_hsync,
    input  [WD_IMG_DATA-1:0]    s_img_gray_y_mdat0,
    //imag interface gray
    output                      m_img_eqal_c_fsync,
    output                      m_img_eqal_c_vsync,
    output                      m_img_eqal_c_hsync,
    output [WD_IMG_DATA-1:0]    m_img_eqal_y_mdat0,
    
    //BRAM read control
output                      m_bram_equal_enb  ,
    output  [WD_BRAM_ADR-1:0]   m_bram_equal_addrb,
    input   [WD_BRAM_DAT-1:0]   m_bram_equal_doutb,
    
    //error info feedback
    output   [WD_ERR_INFO-1:0]  m_err_histogram_info1
);
//========================================================
//function to math and logic

//========================================================
//localparam to converation and calculate

//========================================================
//register and wire to time sequence and combine

//========================================================
//always and assign to drive logic and connect

//========================================================
//module and task to build part of system

//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor

endmodule