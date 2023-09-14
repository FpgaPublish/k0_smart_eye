//  by CrazyBird
module axi4_ctrl
(
    input  wire                 axi_clk         ,
    input  wire                 axi_reset       ,
    
    output reg      [ 3:0]      axi_awid        ,
    output reg      [27:0]      axi_awaddr      ,
    output reg      [ 7:0]      axi_awlen       ,
    output reg      [ 2:0]      axi_awsize      ,
    output reg      [ 1:0]      axi_awburst     ,
    output reg                  axi_awlock      ,
    output reg      [ 3:0]      axi_awcache     ,
    output reg      [ 2:0]      axi_awprot      ,
    output reg      [ 3:0]      axi_awqos       ,
    output reg                  axi_awvalid     ,
    input  wire                 axi_awready     ,
    
    output reg      [63:0]      axi_wdata       ,
    output reg      [ 7:0]      axi_wstrb       ,
    output reg                  axi_wlast       ,
    output reg                  axi_wvalid      ,
    input  wire                 axi_wready      ,
    
    input  wire     [ 3:0]      axi_bid         ,
    input  wire     [ 1:0]      axi_bresp       ,
    input  wire                 axi_bvalid      ,
    output reg                  axi_bready      ,
    
    output reg      [ 3:0]      axi_arid        ,
    output reg      [27:0]      axi_araddr      ,
    output reg      [ 7:0]      axi_arlen       ,
    output reg      [ 2:0]      axi_arsize      ,
    output reg      [ 1:0]      axi_arburst     ,
    output reg                  axi_arlock      ,
    output reg      [ 3:0]      axi_arcache     ,
    output reg      [ 2:0]      axi_arprot      ,
    output reg      [ 3:0]      axi_arqos       ,
    output reg                  axi_arvalid     ,
    input  wire                 axi_arready     ,
    
    input  wire     [ 3:0]      axi_rid         ,
    input  wire     [63:0]      axi_rdata       ,
    input  wire     [ 1:0]      axi_rresp       ,
    input  wire                 axi_rlast       ,
    input  wire                 axi_rvalid      ,
    output reg                  axi_rready      ,
    
    input  wire                 wframe_pclk     ,
    input  wire                 wframe_vsync    ,
    input  wire                 wframe_data_en  ,
    input  wire     [ 7:0]      wframe_data     ,
    
    input  wire                 rframe_pclk     ,
    input  wire                 rframe_vsync    ,
    input  wire                 rframe_data_en  ,
    output wire     [ 7:0]      rframe_data     
);
//----------------------------------------------------------------------
localparam C_BURST_LEN   = 16;
localparam C_ADDR_INC    = C_BURST_LEN * 8;
parameter  C_RD_END_ADDR = 614400;

//----------------------------------------------------------------------
always @(posedge axi_clk)
begin
    axi_awid    <= 4'b0;
    axi_awlen   <= C_BURST_LEN - 1'b1;
    axi_awsize  <= 3'b011;
    axi_awburst <= 2'b01;
    axi_awlock  <= 1'b0;
    axi_awcache <= 4'd3;
    axi_awprot  <= 3'b0;
    axi_awqos   <= 4'b0;
    axi_wstrb   <= 8'hff;
    
    axi_arid    <= 4'b0;
    axi_arlen   <= C_BURST_LEN - 1'b1;
    axi_arsize  <= 3'b011;
    axi_arburst <= 2'b01;
    axi_arlock  <= 1'b0;
    axi_arcache <= 4'd3;
    axi_arprot  <= 3'b0;
    axi_arqos   <= 4'b0;
end

//----------------------------------------------------------------------
reg                             wframe_vsync_dly;

always @(posedge wframe_pclk)
begin
    if(axi_reset == 1'b1)
        wframe_vsync_dly <= 1'b1;
    else
        wframe_vsync_dly <= wframe_vsync;
end

wire                            wframe_vsync_pos;
assign wframe_vsync_pos = ~wframe_vsync_dly & wframe_vsync;

reg             [4:0]           wfifo_cnt;

always @(posedge wframe_pclk)
begin
    if(axi_reset == 1'b1)
        wfifo_cnt <= 5'h1f;
    else
    begin
        if(wframe_vsync_pos == 1'b1)
            wfifo_cnt <= 5'h1f;
        else if(wfifo_cnt > 5'd0)
            wfifo_cnt <= wfifo_cnt - 1'b1;
        else
            wfifo_cnt <= 5'b0;
    end
end

reg                             wfifo_rst;

always @(posedge wframe_pclk)
begin
    if(axi_reset == 1'b1)
        wfifo_rst <= 1'b1;
    else
    begin
        if(wfifo_cnt == 5'b0)
            wfifo_rst <= 1'b0;
        else
            wfifo_rst <= 1'b1;
    end
end

reg                             rframe_vsync_dly;

always @(posedge rframe_pclk)
begin
    if(axi_reset == 1'b1)
        rframe_vsync_dly <= 1'b0;
    else
        rframe_vsync_dly <= rframe_vsync;
end

wire                            rframe_vsync_neg;
assign rframe_vsync_neg =  rframe_vsync_dly & ~rframe_vsync;

reg             [4:0]           rfifo_cnt;

always @(posedge rframe_pclk)
begin
    if(axi_reset == 1'b1)
        rfifo_cnt <= 5'h1f;
    else
    begin
        if(rframe_vsync_neg == 1'b1)
            rfifo_cnt <= 5'h1f;
        else if(rfifo_cnt > 5'd0)
            rfifo_cnt <= rfifo_cnt - 1'b1;
        else
            rfifo_cnt <= 5'b0;
    end
end

reg                             rfifo_rst;

always @(posedge rframe_pclk)
begin
    if(axi_reset == 1'b1)
        rfifo_rst <= 1'b1;
    else
    begin
        if(rfifo_cnt == 5'b0)
            rfifo_rst <= 1'b0;
        else
            rfifo_rst <= 1'b1;
    end
end

//----------------------------------------------------------------------
wire            [63:0]          wfifo_rdata;
wire                            wfifo_renb;
wire            [ 9:0]          wfifo_rcnt;
wire                            wfifo_rd_rst_busy;

W0_FIFO u_W0_FIFO 
(
    .rst            (wfifo_rst          ),                              // input wire rst
    .wr_rst_busy    (                   ),                              // output wire wr_rst_busy
    .rd_rst_busy    (wfifo_rd_rst_busy  ),                              // output wire rd_rst_busy
    
    .wr_clk         (wframe_pclk        ),                              // input wire wr_clk
    .din            (wframe_data        ),                              // input wire [7 : 0] din
    .wr_en          (wframe_data_en     ),                              // input wire wr_en
    .full           (                   ),                              // output wire full
    .wr_data_count  (                   ),                              // output wire [12 : 0] wr_data_count
    
    .rd_clk         (axi_clk            ),                              // input wire rd_clk
    .dout           (wfifo_rdata        ),                              // output wire [63 : 0] dout
    .rd_en          (wfifo_renb         ),                              // input wire rd_en
    .empty          (                   ),                              // output wire empty
    .rd_data_count  (wfifo_rcnt         )                               // output wire [9 : 0] rd_data_count
);

reg             [1:0]               wfifo_rd_rst_busy_dly = 2'b0;

always @(posedge axi_clk)
begin
    if(rfifo_rst == 1'b1)
        wfifo_rd_rst_busy_dly <= 2'b00;
    else
        wfifo_rd_rst_busy_dly <= {wfifo_rd_rst_busy_dly[0],wfifo_rd_rst_busy};
end

wire                                wfifo_rd_rst_busy_neg;
assign wfifo_rd_rst_busy_neg = (wfifo_rd_rst_busy_dly == 2'b10) ? 1'b1 : 1'b0;

reg             [4:0]               write_ddr_delay_cnt;

always @(posedge axi_clk)
begin
    if(rfifo_rst == 1'b1)
        write_ddr_delay_cnt <= 5'b0;
    else
    begin
        if(wfifo_rd_rst_busy_neg == 1'b1)
            write_ddr_delay_cnt <= 5'd31;
        else if(write_ddr_delay_cnt > 5'b0)
            write_ddr_delay_cnt <= write_ddr_delay_cnt - 1'b1;
        else
            write_ddr_delay_cnt <= 5'b0;
    end
end

wire                                write_ddr_init_flag;
assign write_ddr_init_flag = (write_ddr_delay_cnt == 5'd1) ? 1'b1 : 1'b0;

reg                             rfifo_wenb;
reg             [63:0]          rfifo_wdata;
wire            [ 9:0]          rfifo_wcnt;
wire                            rfifo_wr_rst_busy;

R0_FIFO u_R0_FIFO 
(
    .rst            (rfifo_rst          ),                              // input wire rst
    .wr_rst_busy    (rfifo_wr_rst_busy  ),                              // output wire wr_rst_busy
    .rd_rst_busy    (                   ),                              // output wire rd_rst_busy
    
    .wr_clk         (axi_clk            ),                              // input wire wr_clk
    .din            (rfifo_wdata        ),                              // input wire [63 : 0] din
    .wr_en          (rfifo_wenb         ),                              // input wire wr_en
    .full           (                   ),                              // output wire full
    .wr_data_count  (rfifo_wcnt         ),                              // output wire [9 : 0] wr_data_count
    
    .rd_clk         (rframe_pclk        ),                              // input wire rd_clk
    .dout           (rframe_data        ),                              // output wire [7 : 0] dout
    .rd_en          (rframe_data_en     ),                              // input wire rd_en
    .empty          (                   ),                              // output wire empty
    .rd_data_count  (                   )                               // output wire [12 : 0] rd_data_count
);

reg             [1:0]               rfifo_wr_rst_busy_dly = 2'b0;

always @(posedge axi_clk)
begin
    if(rfifo_rst == 1'b1)
        rfifo_wr_rst_busy_dly <= 2'b00;
    else
        rfifo_wr_rst_busy_dly <= {rfifo_wr_rst_busy_dly[0],rfifo_wr_rst_busy};
end

wire                                rfifo_wr_rst_busy_neg;
assign rfifo_wr_rst_busy_neg = (rfifo_wr_rst_busy_dly == 2'b10) ? 1'b1 : 1'b0;

reg             [4:0]               read_ddr_delay_cnt;

always @(posedge axi_clk)
begin
    if(rfifo_rst == 1'b1)
        read_ddr_delay_cnt <= 5'b0;
    else
    begin
        if(rfifo_wr_rst_busy_neg == 1'b1)
            read_ddr_delay_cnt <= 5'd31;
        else if(read_ddr_delay_cnt > 5'b0)
            read_ddr_delay_cnt <= read_ddr_delay_cnt - 1'b1;
        else
            read_ddr_delay_cnt <= 5'b0;
    end
end

wire                                read_ddr_init_flag;
assign read_ddr_init_flag = (read_ddr_delay_cnt == 5'd1) ? 1'b1 : 1'b0;

//----------------------------------------------------------------------
reg             [1:0]               wframe_index;

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        wframe_index <= 2'b0;
    else
    begin
        if(write_ddr_init_flag == 1'b1)
        begin
            if(wframe_index < 2'd2)
                wframe_index <= wframe_index + 1'b1;
            else
                wframe_index <= 2'b0;
        end
        else
            wframe_index <= wframe_index;
    end
end

reg             [1:0]               rframe_index;

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        rframe_index <= 2'd2;
    else
    begin
        if(read_ddr_init_flag == 1'b1)
        begin
            if(wframe_index == 2'd0)
                rframe_index <= 2'd2;
            else
                rframe_index <= wframe_index - 1'b1;
        end
        else
            rframe_index <= rframe_index;
    end
end

//----------------------------------------------------------------------
localparam S_WRITE_IDLE   = 2'd0;
localparam S_WRITE_ADDR   = 2'd1;
localparam S_WRITE_DATA   = 2'd2;
localparam S_WRITE_BVALID = 2'd3;

reg             [1:0]           wr_state;
reg             [8:0]           wdata_cnt;

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        wr_state <= S_WRITE_IDLE;
    else
    begin
        case(wr_state)
            S_WRITE_IDLE : 
            begin
                if(wfifo_rcnt >= C_BURST_LEN)
                    wr_state <= S_WRITE_ADDR;
                else
                    wr_state <= S_WRITE_IDLE;
            end
            S_WRITE_ADDR : 
            begin
                if((axi_awvalid == 1'b1)&&(axi_awready == 1'b1))
                    wr_state <= S_WRITE_DATA;
                else
                    wr_state <= S_WRITE_ADDR;
            end
            S_WRITE_DATA : 
            begin
                if((axi_wvalid == 1'b1)&&(axi_wready == 1'b1)&&(wdata_cnt == C_BURST_LEN))
                    wr_state <= S_WRITE_BVALID;
                else
                    wr_state <= S_WRITE_DATA;
            end
            S_WRITE_BVALID : 
            begin
                if((axi_bvalid == 1'b1)&&(axi_bready == 1'b1))
                    wr_state <= S_WRITE_IDLE;
                else
                    wr_state <= S_WRITE_BVALID;
            end
        endcase
    end
end

reg             [20:0]          awaddr;

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        awaddr <= 21'b0;
    else
    begin
        if(write_ddr_init_flag == 1'b1)
            awaddr <= 21'b0;
        else if((axi_bvalid == 1'b1)&&(axi_bready == 1'b1))
            awaddr <= awaddr + C_ADDR_INC;
        else
            awaddr <= awaddr;
    end
end

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        axi_awaddr <= 28'b0;
    else
    begin
        if(wr_state == S_WRITE_IDLE)
            axi_awaddr <= {wframe_index,awaddr};
        else 
            axi_awaddr <= axi_awaddr;
    end
end

always @(*)
begin
    if(wr_state == S_WRITE_ADDR)
        axi_awvalid = 1'b1;
    else
        axi_awvalid = 1'b0;
end

reg             [8:0]           wdata_cnt_dly;

always @(posedge axi_clk)
begin
    wdata_cnt_dly <= wdata_cnt;
end

always @(*)
begin
    if(wr_state == S_WRITE_DATA)
        begin
        if((axi_wvalid == 1'b1)&&(axi_wready == 1'b1))
            wdata_cnt = wdata_cnt_dly + 1'b1;
        else
            wdata_cnt = wdata_cnt_dly;
        end
    else
        wdata_cnt = 9'b0;
end

always @(*)
begin
    axi_wdata = wfifo_rdata;
end

always @(*)
begin
    if(wr_state == S_WRITE_DATA)
        axi_wvalid = 1'b1;
    else
        axi_wvalid = 1'b0;
end

always @(*)
begin
    if((wr_state == S_WRITE_DATA)&&(wdata_cnt == C_BURST_LEN))
        axi_wlast = 1'b1;
    else
        axi_wlast = 1'b0;
end

assign wfifo_renb = (axi_wvalid & axi_wready) ? 1'b1 : 1'b0;

always @(*)
begin
    if((wr_state == S_WRITE_BVALID)||(wr_state == S_WRITE_DATA))
        axi_bready = 1'b1;
    else
        axi_bready = 1'b0;
end

//----------------------------------------------------------------------
localparam S_READ_IDLE = 2'd0;
localparam S_READ_ADDR = 2'd1;
localparam S_READ_DATA = 2'd2;

reg             [ 1:0]          rd_state;
reg             [ 8:0]          rdata_cnt;
reg             [20:0]          araddr;

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        rd_state <= S_READ_IDLE;
    else
    begin
        case(rd_state)
            S_READ_IDLE : 
            begin
                if((araddr < C_RD_END_ADDR)&&(rfifo_wcnt < 10'd256))
                    rd_state <= S_READ_ADDR;
                else
                    rd_state <= S_READ_IDLE;
            end
            S_READ_ADDR : 
            begin
                if((axi_arvalid == 1'b1)&&(axi_arready == 1'b1))
                    rd_state <= S_READ_DATA;
                else
                    rd_state <= S_READ_ADDR;
            end
            S_READ_DATA : 
            begin
                if((axi_rvalid == 1'b1)&&(axi_rready == 1'b1)&&(rdata_cnt == C_BURST_LEN))
                    rd_state <= S_READ_IDLE;
                else
                    rd_state <= S_READ_DATA;
            end
            default : 
            begin
                rd_state <= S_READ_IDLE;
            end
        endcase
    end
end

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        araddr <= 21'b0;
    else
    begin
        if(read_ddr_init_flag == 1'b1)
            araddr <= 21'b0;
        else if((axi_rvalid == 1'b1)&&(axi_rready == 1'b1)&&(rdata_cnt == C_BURST_LEN))
            araddr <= araddr + C_ADDR_INC;
        else
            araddr <= araddr;
    end
end

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        axi_araddr <= 28'b0;
    else
    begin
        if(rd_state == S_READ_IDLE)
            axi_araddr <= {rframe_index,araddr};
        else 
            axi_araddr <= axi_araddr;
    end
end

always @(*)
begin
    if(rd_state == S_READ_ADDR)
        axi_arvalid = 1'b1;
    else
        axi_arvalid = 1'b0;
end

reg             [8:0]           rdata_cnt_dly;

always @(posedge axi_clk)
begin
    rdata_cnt_dly <= rdata_cnt;
end

always @(*)
begin
    if(rd_state == S_READ_DATA)
        begin
        if((axi_rvalid == 1'b1)&&(axi_rready == 1'b1))
            rdata_cnt = rdata_cnt_dly + 1'b1;
        else
            rdata_cnt = rdata_cnt_dly;
        end
    else
        rdata_cnt = 9'b0;
end

always @(*)
begin
    if(rd_state == S_READ_DATA)
        axi_rready = 1'b1;
    else
        axi_rready = 1'b0;
end

always @(posedge axi_clk)
begin
    if(axi_reset == 1'b1)
        rfifo_wenb <= 1'b0;
    else
    begin
        if((axi_rvalid == 1'b1)&&(axi_rready == 1'b1))
            rfifo_wenb <= 1'b1;
        else
            rfifo_wenb <= 1'b0;
    end
end

always @(posedge axi_clk)
begin
    rfifo_wdata <= axi_rdata;
end

endmodule
