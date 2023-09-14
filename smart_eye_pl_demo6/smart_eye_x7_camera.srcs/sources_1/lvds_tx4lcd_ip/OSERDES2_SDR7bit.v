module  OSERDES2_SDR7bit
(
    input   CLK,
    input   CLKDIV,
    input   RST,
    input   OCE,
    
    input   [6:0]   DATA,
    output          OQ_p,
    output          OQ_n
);
localparam   DATA_WIDTH = 7;
wire    D1 = ~DATA[6];
wire    D2 = ~DATA[5];
wire    D3 = ~DATA[4];
wire    D4 = ~DATA[3];
wire    D5 = ~DATA[2];
wire    D6 = ~DATA[1];
wire    D7 = ~DATA[0];
wire    D8 = ~1'b0;  //DATA[8];

// OSERDESE2: Output SERial/DESerializer with bitslip
OSERDESE2 #(
   .DATA_RATE_OQ ("SDR"),    // DDR, SDR
   .DATA_RATE_TQ ("SDR"),    // DDR, BUF, SDR
   .DATA_WIDTH   (DATA_WIDTH),        // Parallel data width (2-8,10,14)
   .SERDES_MODE  ("MASTER"), // MASTER, SLAVE
   .TRISTATE_WIDTH(1),       // 3-state converter width (1,4)
   .TBYTE_CTL    ("FALSE"),  // Enable tristate byte operation (FALSE, TRUE)
   .TBYTE_SRC    ("FALSE"),  // Tristate byte source (FALSE, TRUE)
   .INIT_OQ      (1'b0),     // Initial value of OQ output (1'b0,1'b1)
   .INIT_TQ      (1'b0),     // Initial value of TQ output (1'b0,1'b1)
   .SRVAL_OQ     (1'b0),     // OQ output value when SR is used (1'b0,1'b1)
   .SRVAL_TQ     (1'b0)     // TQ output value when SR is used (1'b0,1'b1)
)
OSERDESE2_inst (
   .CLK      (CLK),             // 1-bit input: High speed clock,  350MHz
   .CLKDIV   (CLKDIV),       // 1-bit input: Divided clock,     50MHz
   .RST      (RST),             // 1-bit input: Reset
   .OCE      (OCE),             // 1-bit input: Output data clock enable
   // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
   .D1       (D1),
   .D2       (D2),
   .D3       (D3),
   .D4       (D4),
   .D5       (D5),
   .D6       (D6),
   .D7       (D7),
   .D8       (D8),               // Not used
   .OQ       (OQ),               // 1-bit output: Data path output

   //-------------------------------------
   //FeedBack is not Used
   .OFB      (),     //(OFB),             // 1-bit output: Feedback path for data
   //Shift for expand is not used
   // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
   .SHIFTIN1 (1'b0), //(SHIFTIN1),
   .SHIFTIN2 (1'b0), //(SHIFTIN2),
   // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
   .SHIFTOUT1(),     //(SHIFTOUT1),
   .SHIFTOUT2(),     //(SHIFTOUT2),
   
   //3-State is not used
   .TFB      (),     //(TFB),             // 1-bit output: 3-state control
   .TQ       (),     //(TQ),               // 1-bit output: 3-state control
   .TBYTEIN  (1'b0), //(TBYTEIN),     // 1-bit input: Byte group tristate
   .TBYTEOUT (),     //(TBYTEOUT),   // 1-bit output: Byte group tristate
   // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
   .T1       (1'b0), //(T1),
   .T2       (1'b0), //(T2),
   .T3       (1'b0), //(T3),
   .T4       (1'b0), //(T4),
   .TCE      (1'b0)  //(TCE)              // 1-bit input: 3-state clock enable
);

// OBUFDS: Differential Output Buffer
OBUFDS OBUFDS_inst (
   .I       (OQ),    // 1-bit input: Buffer input
   .O       (OQ_p),  // 1-bit output: Diff_p output (connect directly to top-level port)
   .OB      (OQ_n)   // 1-bit output: Diff_n output (connect directly to top-level port)
);

endmodule