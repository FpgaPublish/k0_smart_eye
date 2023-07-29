// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/07/29 15:42:48
// Design Name: 
// Module Name: tb_rgb888_to_ycbcr444
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
`include "rgb888_to_ycbcr444.v"
module tb_rgb888_to_ycbcr444 #(
    //mode
    parameter MD_SIM_ABLE = 0,
    //number
    
    //width
    parameter WD_IMG_DATA = 8,
    parameter WD_ERR_INFO = 4
   )(
    
);
localparam W_IMG = 960;
localparam H_IMG = 640;
// =============================================================
// BUS and SIP to generate signals
reg i_sys_clk    = 0;
reg i_sys_resetn = 0;
always #5 i_sys_clk = ~i_sys_clk;
default clocking cb @(posedge i_sys_clk);
endclocking: cb
initial ##100 i_sys_resetn = 1;
// --------------------------------------------------------------------
// img in

reg                     s_img_rgb888_c_fsync = 0;
reg                     s_img_rgb888_c_vsync = 0;
reg                     s_img_rgb888_c_hsync = 0;
reg [WD_IMG_DATA-1:0]   s_img_rgb888_r_mdat0 = 0;
reg [WD_IMG_DATA-1:0]   s_img_rgb888_g_mdat1 = 0;
reg [WD_IMG_DATA-1:0]   s_img_rgb888_b_mdat2 = 0;

integer w_cnt;
integer h_cnt;
reg [24-1:0]  dat_fifo_rgb  [W_IMG*H_IMG];
reg [24-1:0]  dat_fifo_ycbcr[W_IMG*H_IMG];
integer w = W_IMG;
integer h = H_IMG;

logic [24-1:0]  dat;
integer fid;
integer err;
integer i,j,k,m;
// --------------------------------------------------------------------
// read task
task img_read(output logic [24-1:0] dat_fifo [W_IMG*H_IMG],input string name);
    begin
    fid = $fopen(name,"r");
    $fseek(fid,0,0);
    i = 0;
    j = 0;
    k = 0;
    m = 0;
    while(!$feof(fid))
        begin
            err = $fscanf(fid,"%x",dat);
            m = m + 1;
            if(err == 0 || err == -1)
            begin
                $display("errors dat = %h",dat);
                //$stop();
            end
            else 
            begin
                if(k == 0)
                begin
                    k = k + 1;
                    dat_fifo[i+j*w][7:0] = dat;
                end
                else if(k == 1)
                begin
                    k = k + 1;
                    dat_fifo[i+j*w][15:8] = dat;
                end
                else if(k == 2)
                begin
                    dat_fifo[i+j*w][23:16] = dat;
                    k = 0;
                    if(i == w - 1)
                    begin
                        i = 0;
                        j = j + 1;
                        //$display("every col dat = %d",j);
                        #1;
                    end
                    else 
                    begin
                        i = i + 1;
                    end
                end
            end 
        end
    $fclose(fid);
    $display("last read dat = %d",j);
    end
endtask
initial 
    begin
        w_cnt <= 1'b0;
        h_cnt <= 1'b0;
        img_read(dat_fifo_rgb,"./data/rgb.dat");
        ##1;
        img_read(dat_fifo_ycbcr,"./data/ycbcr.dat");
        ##1 s_img_rgb888_c_fsync = 1;
        ##100;
        repeat(H_IMG)
        begin
            ##1 s_img_rgb888_c_vsync = 1;
            repeat(W_IMG)
            begin
                ##1 s_img_rgb888_c_hsync <= 1;
                s_img_rgb888_r_mdat0 <= dat_fifo_rgb[w_cnt+h_cnt*H_IMG][7:0];
                s_img_rgb888_g_mdat1 <= dat_fifo_rgb[w_cnt+h_cnt*H_IMG][15:8];
                s_img_rgb888_b_mdat2 <= dat_fifo_rgb[w_cnt+h_cnt*H_IMG][23:16];
                ##1
                s_img_rgb888_c_hsync <= 0;
                w_cnt <= (w_cnt >= W_IMG - 1) ? 0 : w_cnt + 1'b1;
            end
            ##1 s_img_rgb888_c_vsync = 0;
            h_cnt <= h_cnt >= H_IMG - 1 ? 0 : h_cnt + 1'b1;
        end
        ##1 s_img_rgb888_c_fsync = 0;
        ##100
        $stop();
    end
    
// --------------------------------------------------------------------
// img out

wire                    m_img_ycbcr444_c_fsync;
wire                    m_img_ycbcr444_c_vsync;
wire                    m_img_ycbcr444_c_hsync;
wire  [WD_IMG_DATA-1:0] m_img_ycbcr444_y_mdat0;
wire  [WD_IMG_DATA-1:0] m_img_ycbcr444_b_mdat1;
wire  [WD_IMG_DATA-1:0] m_img_ycbcr444_r_mdat2;


// =============================================================
// module to simulate
rgb888_to_ycbcr444 #(
    //mode
    .MD_SIM_ABLE(MD_SIM_ABLE),
    //number
    
    //width
    .WD_IMG_DATA(WD_IMG_DATA),
    .WD_ERR_INFO(WD_ERR_INFO)
)u_rgb888_to_ycbcr444(   
    //system signals
    .i_sys_clk   (i_sys_clk   ),  
    .i_sys_resetn(i_sys_resetn),  
    
    .s_img_rgb888_c_fsync(s_img_rgb888_c_fsync),
    .s_img_rgb888_c_vsync(s_img_rgb888_c_vsync),
    .s_img_rgb888_c_hsync(s_img_rgb888_c_hsync),
    .s_img_rgb888_r_mdat0(s_img_rgb888_r_mdat0),
    .s_img_rgb888_g_mdat1(s_img_rgb888_g_mdat1),
    .s_img_rgb888_b_mdat2(s_img_rgb888_b_mdat2),
    
    .m_img_ycbcr444_c_fsync(m_img_ycbcr444_c_fsync),
    .m_img_ycbcr444_c_vsync(m_img_ycbcr444_c_vsync),
    .m_img_ycbcr444_c_hsync(m_img_ycbcr444_c_hsync),
    .m_img_ycbcr444_y_mdat0(m_img_ycbcr444_y_mdat0),
    .m_img_ycbcr444_b_mdat1(m_img_ycbcr444_b_mdat1),
    .m_img_ycbcr444_r_mdat2(m_img_ycbcr444_r_mdat2),
    
    //error info feedback
    .m_err_rgb888_info1()
);
// =============================================================
// assertion to monitor 
integer w_cnt_ck = 0;
integer h_cnt_ck = 0;
reg     r_img_ycbcr444_c_vsync = 0;
always@(posedge i_sys_clk)
begin
    r_img_ycbcr444_c_vsync <= m_img_ycbcr444_c_vsync;
end
wire w_img_ycbcr444_c_vsync_neg = !m_img_ycbcr444_c_vsync && r_img_ycbcr444_c_vsync;
always@(posedge i_sys_clk)
begin
    if(m_img_ycbcr444_c_hsync)
    begin
        w_cnt_ck <= (w_cnt_ck >= W_IMG - 1) ? 1'b0 :
                     w_cnt_ck + 1'b1;
    end
end
always@(posedge i_sys_clk)
begin
    if(w_img_ycbcr444_c_vsync_neg)
    begin
        h_cnt_ck <= (h_cnt_ck >= H_IMG - 1) ? 1'b0 :
                     h_cnt_ck + 1'b1;
    end
end


property ck_rgb_to_y;
    @(posedge i_sys_clk) m_img_ycbcr444_c_hsync 
    |-> m_img_ycbcr444_y_mdat0 == dat_fifo_ycbcr[w_cnt_ck+h_cnt_ck*H_IMG][7:0];
endproperty
property ck_rgb_to_b;
    @(posedge i_sys_clk) m_img_ycbcr444_c_hsync 
    |-> m_img_ycbcr444_b_mdat1 == dat_fifo_ycbcr[w_cnt_ck+h_cnt_ck*H_IMG][15:8];
endproperty
property ck_rgb_to_r;
    @(posedge i_sys_clk) m_img_ycbcr444_c_hsync 
    |-> m_img_ycbcr444_r_mdat2 == dat_fifo_ycbcr[w_cnt_ck+h_cnt_ck*H_IMG][23:16];
endproperty
as_ck_rgb_to_y: assert property(ck_rgb_to_y) else 
begin
    $display("y error in %d",w_cnt);
end
as_ck_rgb_to_b: assert property(ck_rgb_to_b) else 
begin
    $display("b error in %d",w_cnt);
end
                
as_ck_rgb_to_r: assert property(ck_rgb_to_r) else 
begin
    $display("r error in %d",w_cnt);
end
               
endmodule