// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/08/08 21:17:40
// Design Name: 
// Module Name: vips_bram
// Project Name: 
// Target Devices: ZYNQ7010 & XAUG
// Tool Versions: 2021.1
// Description: 
//          1. sim with BRAM, support true dual port
// Dependencies: 
// 
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 
// ***********************************************************************************
`timescale 1ns / 1ps
module ips_bram #(
    //bram delay
    parameter NB_BRAM_DLY = 2,
    //bram width
    parameter WD_BRAM_ADR = 8 ,
    parameter WD_BRAM_DAT = 32
   )(
    input                      i_sys_resetn ,
    //bram interface
    input                      s_bram_0_clka ,
    input                      s_bram_0_ena  ,
    input                      s_bram_0_wea  ,
    input  [WD_BRAM_ADR-1:0]   s_bram_0_addra,
    input  [WD_BRAM_DAT-1:0]   s_bram_0_dina ,
    output [WD_BRAM_DAT-1:0]   s_bram_0_douta,
    
    input                      s_bram_0_clkb ,
    input                      s_bram_0_enb  ,
    input                      s_bram_0_web  ,
    input  [WD_BRAM_ADR-1:0]   s_bram_0_addrb,
    input  [WD_BRAM_DAT-1:0]   s_bram_0_dinb ,
    output [WD_BRAM_DAT-1:0]   s_bram_0_doutb 
    
);
// --------------------------------------------------------------------
// addr
localparam NB_BRAM_ADR = 2 ** WD_BRAM_ADR;

// --------------------------------------------------------------------
// BRAM
reg  [WD_BRAM_DAT-1:0] r_bram_fifo     [0:NB_BRAM_ADR-1];
reg  [WD_BRAM_DAT-1:0] r_bram_douta_dn [0:NB_BRAM_DLY-1];
reg  [WD_BRAM_DAT-1:0] r_bram_doutb_dn [0:NB_BRAM_DLY-1];


// --------------------------------------------------------------------
// write BRAM 
integer k;
always@(posedge s_bram_0_clka) //double clock to sim
begin
    if(!i_sys_resetn)
    begin
        for(k = 0; k < NB_BRAM_ADR; k = k + 1)
        begin:FOR_NB_BRAM_ADR
            r_bram_fifo[k] <= 1'b0;
        end
    end
    else if(s_bram_0_ena && s_bram_0_wea )
    begin
        if(s_bram_0_addra == s_bram_0_addrb)
        begin
            r_bram_fifo[s_bram_0_addra] <= s_bram_0_dina; //a first write
        end
        else 
        begin
            r_bram_fifo[s_bram_0_addra] <= s_bram_0_dina;
            
        end
    end
end
always@(posedge s_bram_0_clkb) //double clock to sim
begin
    if(s_bram_0_enb && s_bram_0_web )
    begin
        if(s_bram_0_addra == s_bram_0_addrb)
        begin
            r_bram_fifo[s_bram_0_addra] <= s_bram_0_dina; //a first write
        end
        else 
        begin
            r_bram_fifo[s_bram_0_addrb] <= s_bram_0_dinb;
        end
    end
end



generate genvar i;
    for(i = 0; i < NB_BRAM_DLY; i = i + 1)
    begin:FOR_NB_BRAM_DLY
        always@(posedge s_bram_0_clka)
        begin
            if(i == 0)
            begin
                if(s_bram_0_ena )
                begin
                    begin
                        r_bram_douta_dn[i] <= r_bram_fifo[s_bram_0_addra];
                    end
                end
            end
            else //still update data
            begin
                r_bram_douta_dn[i] <= r_bram_douta_dn[i-1];
            end
        end
        always@(posedge s_bram_0_clkb)
        begin
            if(i == 0)
            begin
                if(s_bram_0_enb )
                begin
                    begin
                        r_bram_doutb_dn[i] <= r_bram_fifo[s_bram_0_addrb];
                    end
                end
            end
            else //still update data
            begin
                r_bram_doutb_dn[i] <= r_bram_doutb_dn[i-1];
            end
        end
        
        
    end
    
endgenerate
//read current addr data
assign s_bram_0_douta = r_bram_douta_dn[NB_BRAM_DLY-1];
assign s_bram_0_doutb = r_bram_doutb_dn[NB_BRAM_DLY-1];

endmodule