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
Filename            :       system_ctrl_pll.v
Date                :       2011-6-25
Description         :       sync global clock and reset signal
Modification History    :
Date            By          Version         Change Description
=========================================================================
11/06/25        CrazyBingo  1.0             Original
12/03/12        CrazyBingo  1.1             Modification
12/06/01        CrazyBingo  1.4             Modification
12/11/18        CrazyBingo  2.0             Modification
13/10/24        CrazyBingo  2.1             Modification
-------------------------------------------------------------------------
|                                     Oooo                              |
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/
`timescale 1 ns / 1 ns
module system_ctrl_pll
(
    //  global clock
    input  wire                 clk1        ,
    input  wire                 clk2        ,
    input  wire                 rst_n       ,

    //  synced signal
    output wire                 clk_50m     ,
    output wire                 clk_350m    ,
    output wire                 clk_27m     ,
    output wire                 clk_200m    ,
    output wire                 clk_100m    ,
    output wire                 sys_rst_n
);
//----------------------------------------------------------------------
//  system pll module
wire                            locked1;

clk_wiz_0 u_clk_wiz_0 
(
    //  Clock in ports
    .clk_in1    (clk1       ),
    
    //  Status and control signals
    .reset      (~rst_n     ),
    .locked     (locked1    ),
    
    //  Clock out ports
    .clk_out1   (clk_50m    ),
    .clk_out2   (clk_350m   )
);

wire                            locked2;
 
clk_wiz_1 u_clk_wiz_1
(
    //  Clock in ports
    .clk_in1    (clk2       ),                                          //  input clk_in1
    
    //  Status and control signals
    .reset      (~rst_n     ),                                          //  input reset
    .locked     (locked2    ),                                          //  output locked
    
    //  Clock out ports
    .clk_out1   (clk_200m   ),                                          //  output clk_out1
    .clk_out2   (clk_100m   ),                                          //  output clk_out2
    .clk_out3   (clk_27m    )
);

assign sys_rst_n = locked1 & locked2;

endmodule

