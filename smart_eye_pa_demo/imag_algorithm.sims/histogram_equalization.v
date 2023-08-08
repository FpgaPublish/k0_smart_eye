`timescale 1ns / 1ps
/*
```verilog
*/
// *******************************************************************************
// Company: Fpga Publish
// Engineer: FP 
// 
// Create Date: 2023/08/05 02:09:41
// Design Name: 
// Module Name: histogram_equalization
// Project Name: 
// Target Devices: ZYNQ7010 | XCZU2CG | Kintex7
// Tool Versions: 2021.1
// Description: 
//         * get write and read not in the same time
// Dependencies: 
//         * 
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 
// *******************************************************************************
module histogram_equalization #(
    //mode
    parameter MD_SIM_ABLE = 0,

    //img info
    parameter NB_BRAM_DLY = 2 , //1~4
    parameter NB_IMG_HORI = 960,
    parameter NB_IMG_VERT = 640,
    //bram width
    parameter WD_BRAM_ADR = 8,
    parameter WD_BRAM_DAT = 32,
    //width
    parameter WD_IMG_DATA = 8,
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
    //imag interface equal
    output                      m_img_equal_c_fsync,
    output                      m_img_equal_c_vsync,
    output                      m_img_equal_c_hsync,
    output [WD_IMG_DATA-1:0]    m_img_equal_y_mdat0,
    //bram interface
    output                      m_bram_gray_ena  ,
    output                      m_bram_gray_wea  ,
    output  [WD_BRAM_ADR-1:0]   m_bram_gray_addra,
    output  [WD_BRAM_DAT-1:0]   m_bram_gray_dina ,
    
    output                      m_bram_gray_enb  ,
    output  [WD_BRAM_ADR-1:0]   m_bram_gray_addrb,
    input   [WD_BRAM_DAT-1:0]   m_bram_gray_doutb ,
    
    //error info feedback
    output   [WD_ERR_INFO-1:0]  m_err_histogram_info1
);
//========================================================
//function to math and logic
//function y = [log2(N)]
function automatic integer LOG2_N(input integer N);
    for(LOG2_N = 0; N > 1; LOG2_N = LOG2_N + 1)
    begin
        N = N >> 1;
    end
endfunction
//========================================================
//localparam to converation and calculate
localparam NB_IMG_DATA = 2 ** WD_IMG_DATA;
localparam WD_IMG_MAXS = LOG2_N(NB_IMG_HORI * NB_IMG_VERT) + 1;
localparam NB_SPLIT = NB_BRAM_DLY + 1;
localparam WD_SPLIT = LOG2_N(NB_SPLIT) + 1;
//========================================================
//register and wire to time sequence and combine
/* end verilog
```
```mermaid
stateDiagram
GRAY-->GRAY_LEVEL: hsync
GRAY-->GRAY_SUM:hsync
GRAY_LEVEL-->GRAY_SUM:next hsync
GRAY_SUM-->GRAY_EQUAL:next hsync
```
```verilog
*/
// ----------------------------------------------------------
// split sync 
reg [WD_SPLIT-1:0]    r_split_cnt;

// ----------------------------------------------------------
// split n
reg [WD_IMG_DATA-1:0]   r_split_n_addr [0:NB_SPLIT-1];
reg [WD_SPLIT-1:0]      r_split_n_numb [0:NB_SPLIT-1];
reg                     r_split_n_sync [0:NB_SPLIT-1];
// ----------------------------------------------------------
// first data init
reg [NB_IMG_DATA-1:0] r_addr_first_flag;
reg                   r_gray_c_fsync;
wire                  w_gray_c_fsync_pos;
// ----------------------------------------------------------
// add gray sum level
reg                    r_bram_gray_ena  ;
reg                    r_bram_gray_wea  ;
reg  [WD_IMG_DATA-1:0] r_bram_gray_addra;
reg  [WD_IMG_MAXS-1:0] r_bram_gray_dina ;  

reg                    r_bram_gray_enb  ;
reg  [WD_IMG_DATA-1:0] r_bram_gray_addrb;
wire [WD_IMG_MAXS-1:0] w_bram_gray_doutb;  

//========================================================
//always and assign to drive logic and connect
// ----------------------------------------------------------
// split sync 
always@(posedge i_sys_clk)
begin
    if(w_gray_c_fsync_pos) //update in one cycle
    begin
        r_split_cnt <= 1'b0;
    end
    else 
    begin
        r_split_cnt <=  r_split_cnt == NB_SPLIT - 1'b1 ? 1'b0 :
                        r_split_cnt + 1'b1;
    end
end
// ----------------------------------------------------------
// split 0
generate genvar i;
    for(i = 0; i < NB_SPLIT; i = i + 1)
    begin:FOR_NB_SPLIT
        always@(posedge i_sys_clk)
        begin
            if(1) //update in one cycle
            begin
                task_split_addr(i);
                task_split_sync(i);
                task_split_numb(i);
            end
        end
    end
endgenerate


// ----------------------------------------------------------
// add gray sum level

//read logic
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_bram_gray_enb <= s_img_gray_c_hsync; //start read current level
    end
end
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_bram_gray_addrb <= s_img_gray_y_mdat0;//addr is random
    end
end
//write
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_bram_gray_ena <= r_split_n_sync[r_split_cnt];
        r_bram_gray_wea <= r_split_n_sync[r_split_cnt];
    end
end
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_bram_gray_addra <= r_split_n_addr[r_split_cnt];
    end
end
always@(posedge i_sys_clk)
begin
    if(r_addr_first_flag[r_bram_gray_addra]) //update in one cycle
    begin
        r_bram_gray_dina <= r_split_n_numb[r_split_cnt] + 0; //init count
    end
    else 
    begin
        r_bram_gray_dina <= r_split_n_numb[r_split_cnt] + w_bram_gray_doutb;
    end
end
assign m_bram_gray_ena   = r_bram_gray_ena  ;
assign m_bram_gray_wea   = r_bram_gray_wea  ;
assign m_bram_gray_addra = r_bram_gray_addra;
assign m_bram_gray_dina  = r_bram_gray_dina ;
assign m_bram_gray_enb   = r_bram_gray_enb  ;
assign m_bram_gray_addrb = r_bram_gray_addrb;
assign w_bram_gray_doutb = m_bram_gray_doutb;
// ----------------------------------------------------------
// first data init
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_gray_c_fsync <= s_img_gray_c_fsync;
    end
end
assign w_gray_c_fsync_pos = s_img_gray_c_fsync && !r_gray_c_fsync;
always@(posedge i_sys_clk)
begin
    if(w_gray_c_fsync_pos) //update in one cycle
    begin
        r_addr_first_flag <= {NB_IMG_DATA{1'b1}};
    end
    else if(r_bram_gray_wea  && r_bram_gray_ena)
    begin
        r_addr_first_flag[r_bram_gray_addra] <= 1'b0;
    end
end

//========================================================
//module and task to build part of system
task task_split_addr(input integer i);
begin
    if(s_img_gray_c_hsync) //update in one cycle
    begin
        if(r_split_cnt == i)
        begin
            r_split_n_addr[i] <= s_img_gray_y_mdat0;
        end
    end
end
endtask
task task_split_sync(input integer i);
integer m;
begin
    if(r_split_cnt == i)
    begin
        if(1)
            begin
                r_split_n_sync[i] <= s_img_gray_c_hsync;
            end
        for(m = 0; m < i; m = m + 1)
        begin
            if(s_img_gray_y_mdat0 == r_split_n_addr[m])
            begin
                r_split_n_sync[i] <= 1'b0;
            end
        end
    end
end
endtask
task task_split_numb(input integer i);
begin
    if(s_img_gray_c_hsync) //update in one cycle
    begin
        if(r_split_cnt == i)
        begin
            r_split_n_numb[i] <= 1;
        end
        else if(r_split_n_addr[i] == s_img_gray_y_mdat0)
        begin
            r_split_n_numb[i] <= r_split_n_numb[i] + 1'b1;
        end
    end
end
endtask
//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor

endmodule