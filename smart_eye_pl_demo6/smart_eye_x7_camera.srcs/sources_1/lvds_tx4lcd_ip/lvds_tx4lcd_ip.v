module  lvds_tx4lcd_ip  //7bit
(
    input           clk_7x,
    input           clk,
    input           rst_n,
    input           lcd_vs,
    input           lcd_hs,
    input           lcd_de,
    input   [7:0]   lcd_red,
    input   [7:0]   lcd_green,
    input   [7:0]   lcd_blue,
    
    //lvds tx for lcd output    
    output          lvds_clk_p,
    output          lvds_clk_n,
    output          lvds_d0_p,
    output          lvds_d0_n,
    output          lvds_d1_p,
    output          lvds_d1_n,
    output          lvds_d2_p,
    output          lvds_d2_n,
    output          lvds_d3_p,
    output          lvds_d3_n
);
wire    [6:0]   DATA0 = {lcd_green[0],  lcd_red[5:0]};
wire    [6:0]   DATA1 = {lcd_blue[1:0], lcd_green[5:1]};
wire    [6:0]   DATA2 = {lcd_de, lcd_vs, lcd_hs,  lcd_blue[5:2]};   //vs hs is reserved
wire    [6:0]   DATA3 = {1'b0,          lcd_blue[7:6], lcd_green[7:6], lcd_red[7:6]};
////--------------------------------
////1 OBUFDS for clkInit
//OBUFDS OBUFDS_inst (
//   .I       (clk),         // 1-bit input: Buffer input
//   .O       (lvds_clk_p),  // 1-bit output: Diff_p output (connect directly to top-level port)
//   .OB      (lvds_clk_n)  // 1-bit output: Diff_n output (connect directly to top-level port)
//);


wire    CLK    = clk_7x;
wire    CLKDIV = clk;
wire    RST    = ~rst_n;
wire    OCE    = 1'b1;
OSERDES2_SDR7bit    u0_OSERDES2_SDR7bit
(
    .CLK    (CLK),
    .CLKDIV (CLKDIV),
    .RST    (RST),
    .OCE    (OCE),
    
    .DATA   (7'b1100011),
    .OQ_p   (lvds_clk_p),
    .OQ_n   (lvds_clk_n)
);


//--------------------------------
//4 OSERDES2 for data Init
wire    lvds_d0, lvds_d1, lvds_d2, lvds_d3;
OSERDES2_SDR7bit    u1_OSERDES2_SDR7bit
(
    .CLK    (CLK),
    .CLKDIV (CLKDIV),
    .RST    (RST),
    .OCE    (OCE),
    
    .DATA   (DATA0),
    .OQ_p   (lvds_d0_p),
    .OQ_n   (lvds_d0_n)
);
OSERDES2_SDR7bit    u2_OSERDES2_SDR7bit
(
    .CLK    (CLK),
    .CLKDIV (CLKDIV),
    .RST    (RST),
    .OCE    (OCE),
    
    .DATA   (DATA1),
    .OQ_p   (lvds_d1_p),
    .OQ_n   (lvds_d1_n)
);
OSERDES2_SDR7bit    u3_OSERDES2_SDR7bit
(
    .CLK    (CLK),
    .CLKDIV (CLKDIV),
    .RST    (RST),
    .OCE    (OCE),
    
    .DATA   (DATA2),
    .OQ_p   (lvds_d2_p),
    .OQ_n   (lvds_d2_n)
);
OSERDES2_SDR7bit    u4_OSERDES2_SDR7bit
(
    .CLK    (CLK),
    .CLKDIV (CLKDIV),
    .RST    (RST),
    .OCE    (OCE),
    
    .DATA   (DATA3),
    .OQ_p   (lvds_d3_p),
    .OQ_n   (lvds_d3_n)
);

endmodule



				