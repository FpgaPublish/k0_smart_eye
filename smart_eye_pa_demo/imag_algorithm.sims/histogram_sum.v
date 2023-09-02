`timescale 1ns / 1ps
/*
```verilog
*/
// *******************************************************************************
// Company: Fpga Publish
// Engineer: FP 
// 
// Create Date: 2023/08/26 19:55:45
// Design Name: 
// Module Name: histogram_sum
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
module histogram_sum #(
    //mode
    parameter MD_SIM_ABLE = 0,
    //number
    parameter NB_BRAM_LATCH = 2,
    //width
    parameter WD_IMG_DATA = 8,
    parameter WD_BRAM_ADR = 8,
    parameter WD_BRAM_DAT = 32,
    parameter WD_ERR_INFO = 4
   )(
    //system signals
    input           i_sys_clk  ,  
    input           i_sys_resetn, 
    
    //BRAM read control
    input                       m_bram_equal_idle ,
    output                      m_bram_equal_enb  ,
    output  [WD_BRAM_ADR-1:0]   m_bram_equal_addrb,
    input   [WD_BRAM_DAT-1:0]   m_bram_equal_doutb,
    //bram interface wr
    output                      m_bram_equal_ena  ,
    output                      m_bram_equal_wea  ,
    output  [WD_BRAM_ADR-1:0]   m_bram_equal_addra,
    output  [WD_BRAM_DAT-1:0]   m_bram_equal_dina ,
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