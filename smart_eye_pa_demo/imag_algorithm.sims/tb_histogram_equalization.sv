// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/08/08 21:52:43
// Design Name: 
// Module Name: tb_histogram_equalization
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
`include "./histogram_equalization.v"
`include "./lib_ips/ips_bram.sv"
`include "./lib_vip/vip_read_imag.sv"
module tb_histogram_equalization #(
    //mode
    parameter MD_SIM_ABLE = 0,

    //img info
    parameter NB_BRAM_DLY = 2 , //1~4
    parameter NB_IMG_HORI = 480,
    parameter NB_IMG_VERT = 320,
    //bram width
    parameter WD_BRAM_ADR = 8,
    parameter WD_BRAM_DAT = 32,
    //width
    parameter WD_IMG_DATA = 8,
    parameter WD_ERR_INFO = 4
   )(
    
);


// =============================================================
// BUS and SIP to generate signals
reg i_sys_clk    = 0;
reg i_sys_resetn = 0;
always #5 i_sys_clk = ~i_sys_clk;
default clocking cb @(posedge i_sys_clk);
endclocking: cb
initial ##100 i_sys_resetn = 1;
// --------------------------------------------------------------------
// gray in
reg                      s_img_0_c_fsync = 0;
reg                      s_img_0_c_vsync = 0;
reg                      s_img_0_c_hsync = 0;
reg [WD_IMG_DATA-1:0]    s_img_0_y_mdat0 = 0;

integer w_cnt; //width count
integer h_cnt; //height count
integer dat;

vip_read_imag c_rgb   = new("./data/gray.dat",NB_IMG_HORI,NB_IMG_VERT  );
vip_read_imag c_ycbcr = new("./data/hist.dat",NB_IMG_HORI,NB_IMG_VERT);

initial 
begin
    w_cnt <= 1'b0;
    h_cnt <= 1'b0;
    ##100;
    ##1 s_img_0_c_fsync = 1;
    repeat(NB_IMG_VERT)
    begin
        ##1 s_img_0_c_vsync = 1;
        repeat(NB_IMG_HORI)
        begin
            ##1 s_img_0_c_hsync <= 1;
            dat = c_rgb.dat_fifo[w_cnt+h_cnt*NB_IMG_HORI];
            s_img_0_y_mdat0 <= dat[7:0];
            ##1
            s_img_0_c_hsync <= 0;
            w_cnt <= (w_cnt >= NB_IMG_HORI - 1) ? 0 : w_cnt + 1'b1;
        end
        ##1 s_img_0_c_vsync = 0;
        h_cnt <= h_cnt >= NB_IMG_VERT - 1 ? 0 : h_cnt + 1'b1;
    end
    ##1 s_img_0_c_fsync = 0;
    
    // --------------------------------------------------------------------
    // start second step
    
    
    
    ##100
    $stop();
end
// --------------------------------------------------------------------
// hist out
wire                      m_img_1_c_fsync;
wire                      m_img_1_c_vsync;
wire                      m_img_1_c_hsync;
wire [WD_IMG_DATA-1:0]    m_img_1_y_mdat0;

// --------------------------------------------------------------------
// BRAM connect
wire                     w_bram_0_clka  ;                     
wire                     w_bram_0_ena   ;                     
wire                     w_bram_0_wea   ;                     
wire [WD_BRAM_ADR-1:0]   w_bram_0_addra ; 
wire [WD_BRAM_DAT-1:0]   w_bram_0_dina  ; 
wire [WD_BRAM_DAT-1:0]   w_bram_0_douta ; 
wire                     w_bram_0_clkb  ;                     
wire                     w_bram_0_enb   ;                     
wire                     w_bram_0_web   ;                     
wire [WD_BRAM_ADR-1:0]   w_bram_0_addrb ; 
wire [WD_BRAM_DAT-1:0]   w_bram_0_dinb  ; 
wire [WD_BRAM_DAT-1:0]   w_bram_0_doutb ; 

assign w_bram_0_clka = i_sys_clk;
assign w_bram_0_clkb = i_sys_clk;
// =============================================================
// module to simulate
histogram_equalization #(
    //mode
    .MD_SIM_ABLE(MD_SIM_ABLE),

    //img info
    .NB_BRAM_DLY(NB_BRAM_DLY), //1~4
    .NB_IMG_HORI(NB_IMG_HORI),
    .NB_IMG_VERT(NB_IMG_VERT),
    //bram width
    .WD_BRAM_ADR(WD_BRAM_ADR),
    .WD_BRAM_DAT(WD_BRAM_DAT),
    //width
    .WD_IMG_DATA(WD_IMG_DATA),
    .WD_ERR_INFO(WD_ERR_INFO)
)u_histogram_equalization(   
    //system signals
    .i_sys_clk(i_sys_clk),  
    .i_sys_resetn(i_sys_resetn),  
    //imag interface gray
    .s_img_gray_c_fsync(s_img_0_c_fsync),
    .s_img_gray_c_vsync(s_img_0_c_vsync),
    .s_img_gray_c_hsync(s_img_0_c_hsync),
    .s_img_gray_y_mdat0(s_img_0_y_mdat0),

    //bram interface
    .m_bram_gray_ena  (w_bram_0_ena  ),
    .m_bram_gray_wea  (w_bram_0_wea  ),
    .m_bram_gray_addra(w_bram_0_addra),
    .m_bram_gray_dina (w_bram_0_dina ),
    
    .m_bram_gray_enb  (w_bram_0_enb  ),
    .m_bram_gray_addrb(w_bram_0_addrb),
    .m_bram_gray_doutb(w_bram_0_doutb),
    
    //error info feedback
    .m_err_histogram_info1(m_err_histogram_info1)
);

ips_bram #(
    //bram delay
    .NB_BRAM_DLY(NB_BRAM_DLY),
    //bram width
    .WD_BRAM_ADR(WD_BRAM_ADR),
    .WD_BRAM_DAT(WD_BRAM_DAT)
)u_ips_bram(   
    .i_sys_resetn(i_sys_resetn),
    //bram interface
    .s_bram_0_clka (w_bram_0_clka ),
    .s_bram_0_ena  (w_bram_0_ena  ),
    .s_bram_0_wea  (w_bram_0_wea  ),
    .s_bram_0_addra(w_bram_0_addra),
    .s_bram_0_dina (w_bram_0_dina ),
    .s_bram_0_douta(w_bram_0_douta),
    
    .s_bram_0_clkb (w_bram_0_clkb ),
    .s_bram_0_enb  (w_bram_0_enb  ),
    .s_bram_0_web  (w_bram_0_web  ),
    .s_bram_0_addrb(w_bram_0_addrb),
    .s_bram_0_dinb (w_bram_0_dinb ),
    .s_bram_0_doutb(w_bram_0_doutb)
    
);
// =============================================================
// assertion to monitor 





endmodule