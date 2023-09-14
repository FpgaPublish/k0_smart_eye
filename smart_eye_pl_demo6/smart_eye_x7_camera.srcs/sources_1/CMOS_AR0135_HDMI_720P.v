/*-----------------------------------------------------------------------
                                 \\\|///
                               \\  - -  //
                                (  @ @  )  
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2012-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author              :       CrazyBingo
Technology blogs    :       www.crazyfpga.com
Email Address       :       crazyfpga@vip.qq.com
Filename            :       System_Ctrl_Design.v
Date                :       2013-10-22
Description         :       System clock control module.
Modification History    :
Date            By          Version         Change Description
=========================================================================
13/10/22        CrazyBingo  1.0             Original
13/10/24        CrazyBingo  1.1             Add breathe display RTL
-------------------------------------------------------------------------
|                                     Oooo                              |
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
//`define SIMU_EN
module CMOS_AR0135_HDMI_720P
(
    //  global clock
    input                       clk         ,                           //  24MHz
    input                       clk2        ,                           //  25MHz
    input                       rst_n       ,
    
    output                      cmos_sclk   ,                           //  cmos i2c clock
    inout                       cmos_sdat   ,                           //  cmos i2c data
    output                      cmos_xclk   ,                           //  cmos externl clock
    input                       cmos_pclk   ,                           //  cmos pxiel clock
    input                       cmos_vsync  ,                           //  cmos vsync
    input                       cmos_href   ,                           //  cmos hsync refrence
    input           [ 7:0]      cmos_data   ,                           //  cmos data
    
    output          [13:0]      ddr3_addr   ,
    output          [ 2:0]      ddr3_ba     ,
    output                      ddr3_cas_n  ,
    output                      ddr3_ck_n   ,
    output                      ddr3_ck_p   ,
    output                      ddr3_cke    ,
    output                      ddr3_ras_n  ,
    output                      ddr3_reset_n,
    output                      ddr3_we_n   ,
    inout           [15:0]      ddr3_dq     ,
    inout           [ 1:0]      ddr3_dqs_n  ,
    inout           [ 1:0]      ddr3_dqs_p  ,
    output                      ddr3_cs_n   ,
    output          [ 1:0]      ddr3_dm     ,
    output                      ddr3_odt    ,
    
    //  led interface
    output          [ 7:0]      led_data    ,
    
    //  HDMI TMDS Data
    output                      TMDS_Clk_p  , 
    output                      TMDS_Clk_n  , 
    output          [ 2:0]      TMDS_Data_p ,
    output          [ 2:0]      TMDS_Data_n
);
//----------------------------------------------------------------------
//  sync global clock and reset signal
wire                            clk_50m;
wire                            clk_350m;
wire                            clk_200m;
wire                            clk_100m;
wire                            sys_rst_n;

system_ctrl_pll
(
    //  global clock
    .clk1           (clk            ),
    .clk2           (clk2           ),
    .rst_n          (rst_n          ),

    //  synced signal
    .clk_50m        (clk_50m        ),
    .clk_350m       (clk_350m       ),
    .clk_27m        (cmos_xclk      ),
    .clk_200m       (clk_200m       ),
    .clk_100m       (clk_100m       ),
    .sys_rst_n      (sys_rst_n      )
);

localparam CLOCK_MAIN = 100_000000;
wire lcd_clk    = clk_50m;
wire lcd_clk_5x = clk_350m;

//----------------------------------------------------------------------
//  i2c timing controller module of 16Bit
wire            [ 7:0]          i2c_config_index;
wire            [31:0]          i2c_config_data;
wire            [ 7:0]          i2c_config_size;
wire                            i2c_config_done;
wire            [15:0]          i2c_rdata;                              //  i2c register data

i2c_timing_ctrl_reg16_dat16
#(
    .SIMU_EN            (0              ),
    .I2C_READ_EN        (1              ),                              //  Enable I2C Register read
    .CLK_FREQ           (CLOCK_MAIN     ),                              //  120 MHz
    .I2C_FREQ           (10_000         )                               //  10 KHz(<= 400KHz)
)
u_i2c_timing_ctrl_16reg_16bit
(
    //global clock
    .clk                (clk_100m                   ),                  //  120MHz
    .rst_n              (sys_rst_n                  ),                  //  system reset

    //i2c interface
    .i2c_sclk           (cmos_sclk                  ),                  //  i2c clock
    .i2c_sdat           (cmos_sdat                  ),                  //  i2c data for bidirection

    //i2c config data
    .i2c_config_index   (i2c_config_index           ),                  //  i2c config reg index, read 2 reg and write xx reg
    .i2c_config_data    ({8'h20, i2c_config_data}   ),                  //  i2c config data
    .i2c_config_size    (i2c_config_size            ),                  //  i2c config data counte
    .i2c_config_done    (i2c_config_done            ),                  //  i2c config timing complete
    .i2c_rdata          (i2c_rdata                  )                   //  i2c register data while read i2c slave
);

//----------------------------------------------------------------------
//  I2C Configure Data of AR0135
I2C_AR0135_1280720_Config u_I2C_AR0135_1280720_Config
(
    .LUT_INDEX  (i2c_config_index   ),
    .LUT_DATA   (i2c_config_data    ),
    .LUT_SIZE   (i2c_config_size    )
);

//----------------------------------------------------------------------
//  cmos video image capture
wire                            cmos_init_done;                         //  cmos camera init done
wire                            cmos_frame_vsync;                       //  cmos frame data vsync valid signal
wire                            cmos_frame_href;                        //  cmos frame data href vaild  signal
wire            [7:0]           cmos_frame_Gray;                        //  cmos frame data output: 8 Bit raw data    
wire                            cmos_vsync_end;
wire                            init_calib_complete;

assign cmos_init_done = i2c_config_done & init_calib_complete;

CMOS_Capture_RAW_Gray   
#(
    .CMOS_FRAME_WAITCNT     (4'd3       ),                              //  Wait n fps for steady(OmniVision need 10 Frame)
    .CMOS_PCLK_FREQ         (74_250000  )                               //  100 MHz
)
u_CMOS_Capture_RAW_Gray
(
    //global clock
    .clk_cmos               (clk_cmos                   ),              //  27MHz CMOS Driver clock input
    .rst_n                  (sys_rst_n & cmos_init_done ),              //  global reset

    //CMOS Sensor Interface
    .cmos_pclk              (cmos_pclk                  ),              //  74.25MHz CMOS Pixel clock input
    .cmos_xclk              (                           ),              //  74.25MHz drive clock
    .cmos_data              (cmos_data                  ),              //  8 bits cmos data input
    .cmos_vsync             (cmos_vsync                 ),              //  L: vaild, H: invalid
    .cmos_href              (cmos_href                  ),              //  H: vaild, L: invalid
    
    //CMOS SYNC Data output
    .cmos_frame_vsync       (cmos_frame_vsync           ),              //  cmos frame data vsync valid signal
    .cmos_frame_href        (cmos_frame_href            ),              //  cmos frame data href vaild  signal
    .cmos_frame_data        (cmos_frame_Gray            ),              //  cmos frame data output: 8 Bit raw data    
    
    //user interface
    .cmos_fps_rate          (                           ),              //cmos image output rate
    .cmos_vsync_end         (cmos_vsync_end             ),
    .pixel_cnt              (                           ), 
    .line_cnt               (                           )  
);

//----------------------------------------------------------------------
wire                            ddr_clk;
wire                            ddr_rst;

wire            [ 3:0]          s_axi_awid;
wire            [27:0]          s_axi_awaddr;
wire            [ 7:0]          s_axi_awlen;
wire            [ 2:0]          s_axi_awsize;
wire            [ 1:0]          s_axi_awburst;
wire                            s_axi_awlock;
wire            [ 3:0]          s_axi_awcache;
wire            [ 2:0]          s_axi_awprot;
wire            [ 3:0]          s_axi_awqos;
wire                            s_axi_awvalid;
wire                            s_axi_awready;

wire            [63:0]          s_axi_wdata;
wire            [ 7:0]          s_axi_wstrb;
wire                            s_axi_wlast;
wire                            s_axi_wvalid;
wire                            s_axi_wready;

wire            [ 3:0]          s_axi_bid;
wire            [ 1:0]          s_axi_bresp;
wire                            s_axi_bvalid;
wire                            s_axi_bready;

wire            [ 3:0]          s_axi_arid;
wire            [27:0]          s_axi_araddr;
wire            [ 7:0]          s_axi_arlen;
wire            [ 2:0]          s_axi_arsize;
wire            [ 1:0]          s_axi_arburst;
wire                            s_axi_arlock;
wire            [ 3:0]          s_axi_arcache;
wire            [ 2:0]          s_axi_arprot;
wire            [ 3:0]          s_axi_arqos;
wire                            s_axi_arvalid;
wire                            s_axi_arready;

wire            [ 3:0]          s_axi_rid;
wire            [63:0]          s_axi_rdata;
wire            [ 1:0]          s_axi_rresp;
wire                            s_axi_rlast;
wire                            s_axi_rvalid;
wire                            s_axi_rready;

axi4_ctrl 
#(
    .C_RD_END_ADDR  (1280*720           )
)
u_axi4_ctrl
(
    .axi_clk        (ddr_clk            ),
    .axi_reset      (ddr_rst            ),
    
    .axi_awid       (s_axi_awid         ),
    .axi_awaddr     (s_axi_awaddr       ),
    .axi_awlen      (s_axi_awlen        ),
    .axi_awsize     (s_axi_awsize       ),
    .axi_awburst    (s_axi_awburst      ),
    .axi_awlock     (s_axi_awlock       ),
    .axi_awcache    (s_axi_awcache      ),
    .axi_awprot     (s_axi_awprot       ),
    .axi_awqos      (s_axi_awqos        ),
    .axi_awvalid    (s_axi_awvalid      ),
    .axi_awready    (s_axi_awready      ),
    
    .axi_wdata      (s_axi_wdata        ),
    .axi_wstrb      (s_axi_wstrb        ),
    .axi_wlast      (s_axi_wlast        ),
    .axi_wvalid     (s_axi_wvalid       ),
    .axi_wready     (s_axi_wready       ),
    
    .axi_bid        (s_axi_bid          ),
    .axi_bresp      (s_axi_bresp        ),
    .axi_bvalid     (s_axi_bvalid       ),
    .axi_bready     (s_axi_bready       ),
    
    .axi_arid       (s_axi_arid         ),
    .axi_araddr     (s_axi_araddr       ),
    .axi_arlen      (s_axi_arlen        ),
    .axi_arsize     (s_axi_arsize       ),
    .axi_arburst    (s_axi_arburst      ),
    .axi_arlock     (s_axi_arlock       ),
    .axi_arcache    (s_axi_arcache      ),
    .axi_arprot     (s_axi_arprot       ),
    .axi_arqos      (s_axi_arqos        ),
    .axi_arvalid    (s_axi_arvalid      ),
    .axi_arready    (s_axi_arready      ),
    
    .axi_rid        (s_axi_rid          ),
    .axi_rdata      (s_axi_rdata        ),
    .axi_rresp      (s_axi_rresp        ),
    .axi_rlast      (s_axi_rlast        ),
    .axi_rvalid     (s_axi_rvalid       ),
    .axi_rready     (s_axi_rready       ),
    
    .wframe_pclk    (cmos_pclk          ),
    .wframe_vsync   (cmos_frame_vsync   ),
    .wframe_data_en (cmos_frame_href    ),
    .wframe_data    (cmos_frame_Gray    ),
    
    .rframe_pclk    (lcd_clk            ),
    .rframe_vsync   (lcd_vs             ),
    .rframe_data_en (lcd_de             ),
    .rframe_data    (lcd_data           )
);

//----------------------------------------------------------------------
mig_7series_0 u_mig_7series_0 
(
    //  Memory interface ports
    .ddr3_addr              (ddr3_addr          ),
    .ddr3_ba                (ddr3_ba            ),
    .ddr3_cas_n             (ddr3_cas_n         ),
    .ddr3_ck_n              (ddr3_ck_n          ),
    .ddr3_ck_p              (ddr3_ck_p          ),
    .ddr3_cke               (ddr3_cke           ),
    .ddr3_ras_n             (ddr3_ras_n         ),
    .ddr3_reset_n           (ddr3_reset_n       ),
    .ddr3_we_n              (ddr3_we_n          ),
    .ddr3_dq                (ddr3_dq            ),
    .ddr3_dqs_n             (ddr3_dqs_n         ),
    .ddr3_dqs_p             (ddr3_dqs_p         ),
    .init_calib_complete    (init_calib_complete),
    .ddr3_cs_n              (ddr3_cs_n          ),
    .ddr3_dm                (ddr3_dm            ),
    .ddr3_odt               (ddr3_odt           ),
    //  Application interface ports
    .ui_clk                 (ddr_clk            ),
    .ui_clk_sync_rst        (ddr_rst            ),
    .mmcm_locked            (                   ),
    .aresetn                (~ddr_rst           ),
    .app_sr_req             (1'b0               ),
    .app_ref_req            (1'b0               ),
    .app_zq_req             (1'b0               ),
    .app_sr_active          (                   ),
    .app_ref_ack            (                   ),
    .app_zq_ack             (                   ),
    //  Slave Interface Write Address Ports
    .s_axi_awid             (s_axi_awid         ),
    .s_axi_awaddr           (s_axi_awaddr       ),
    .s_axi_awlen            (s_axi_awlen        ),
    .s_axi_awsize           (s_axi_awsize       ),
    .s_axi_awburst          (s_axi_awburst      ),
    .s_axi_awlock           (s_axi_awlock       ),
    .s_axi_awcache          (s_axi_awcache      ),
    .s_axi_awprot           (s_axi_awprot       ),
    .s_axi_awqos            (s_axi_awqos        ),
    .s_axi_awvalid          (s_axi_awvalid      ),
    .s_axi_awready          (s_axi_awready      ),
    //  Slave Interface Write Data Ports
    .s_axi_wdata            (s_axi_wdata        ),
    .s_axi_wstrb            (s_axi_wstrb        ),
    .s_axi_wlast            (s_axi_wlast        ),
    .s_axi_wvalid           (s_axi_wvalid       ),
    .s_axi_wready           (s_axi_wready       ),
    // Slave Interface Write Response Ports
    .s_axi_bid              (s_axi_bid          ),
    .s_axi_bresp            (s_axi_bresp        ),
    .s_axi_bvalid           (s_axi_bvalid       ),
    .s_axi_bready           (s_axi_bready       ),
    // Slave Interface Read Address Ports
    .s_axi_arid             (s_axi_arid         ),
    .s_axi_araddr           (s_axi_araddr       ),
    .s_axi_arlen            (s_axi_arlen        ),
    .s_axi_arsize           (s_axi_arsize       ),
    .s_axi_arburst          (s_axi_arburst      ),
    .s_axi_arlock           (s_axi_arlock       ),
    .s_axi_arcache          (s_axi_arcache      ),
    .s_axi_arprot           (s_axi_arprot       ),
    .s_axi_arqos            (s_axi_arqos        ),
    .s_axi_arvalid          (s_axi_arvalid      ),
    .s_axi_arready          (s_axi_arready      ),
    // Slave Interface Read Data Ports
    .s_axi_rid              (s_axi_rid          ),
    .s_axi_rdata            (s_axi_rdata        ),
    .s_axi_rresp            (s_axi_rresp        ),
    .s_axi_rlast            (s_axi_rlast        ),
    .s_axi_rvalid           (s_axi_rvalid       ),
    .s_axi_rready           (s_axi_rready       ),
    // System Clock Ports
    .sys_clk_i              (clk_200m           ),
    // Reference Clock Ports
    .clk_ref_i              (clk_200m           ),
    .sys_rst                (sys_rst_n          )
);

//----------------------------------------------------------------------
//  LCD driver timing
// wire            [ 7:0]          lcd_data;                               //  lcd data
// wire                            lcd_vs;
// wire                            lcd_hs;
// wire                            lcd_de;
wire            [ 7:0]          lcd_red;
wire            [ 7:0]          lcd_green;
wire            [ 7:0]          lcd_blue;

lcd_driver u_lcd_driver
(
    //global clock
    .clk            (lcd_clk                        ),
    .rst_n          (sys_rst_n                      ), 
     
     //lcd interface
    .lcd_dclk       (                               ),
    .lcd_blank      (                               ),                  //  lcd_blank
    .lcd_sync       (                               ),             
    .lcd_hs         (lcd_hs                         ),       
    .lcd_vs         (lcd_vs                         ),
    .lcd_en         (lcd_de                         ),       
    .lcd_rgb        ({lcd_red, lcd_green ,lcd_blue} ),

    
    //user interface
    .lcd_request    (                               ),
    .lcd_data       ({3{lcd_data}}                  ), 
    .lcd_xpos       (                               ), 
    .lcd_ypos       (                               )
);

//----------------------------------------------------------------------
//  Digilent HDMI TX IP
rgb2dvi u_rgb2dvi
(      
    //  Golbal clock
    .PixelClk       (lcd_clk        ),
    .SerialClk      (lcd_clk_5x     ),
    .aRst_n         (sys_rst_n      ),
    .aRst           (~sys_rst_n     ),
    
    //  DVP Input
    .vid_pData      ({lcd_red, lcd_green ,lcd_blue} ),
    .vid_pVDE       (lcd_de         ),
    .vid_pHSync     (lcd_hs         ),
    .vid_pVSync     (lcd_vs         ),
    
    //  TMDS Output
    .TMDS_Clk_p     (TMDS_Clk_p     ),
    .TMDS_Clk_n     (TMDS_Clk_n     ),
    .TMDS_Data_p    (TMDS_Data_p    ),
    .TMDS_Data_n    (TMDS_Data_n    )
);

//----------------------------------------------------------------------
//  led display for water
wire            [7:0]           led_data_r;

led_water_display_V0
#(
    .LED_WIDTH  (8)
)
u0_led_water_display_V0
(
    //  global clock
    .clk        (lcd_clk    ),
    .rst_n      (sys_rst_n  ),

    //  user led output
    .led_data   (led_data_r )
);

assign led_data = ~led_data_r;

endmodule
