/*
```verilog
*/
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2023 01:39:10 PM
// Design Name: 
// Module Name: led_driv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module led_driv #(
    //mode
    parameter MD_SIM_ABLE = 0,
    parameter MD_SIG_TRIG = 32'h00000,
    parameter MD_LED_TASK = 32'h00000,
    //number
    parameter NB_LED_STILL = 8'h10, //2^28 cycle base time
    //width
    parameter WD_LED_NUMB    = 5,
    parameter WD_ERR_INFO    = 4
   )(
    //system signals
    input           i_sys_clk  ,  
    input           i_sys_resetn,  
    
    //signal_to_monitor
    input    [WD_LED_NUMB-1:0] i_bus_monitor_signal,
    //driver led
    output   [WD_LED_NUMB-1:0] o_port_led_driv,
    
    
    //error info feedback
    output   [WD_ERR_INFO-1:0]  m_err_led_info1
);
//========================================================
//function to math and logic

//========================================================
//localparam to converation and calculate
localparam WD_LONG_CNT = 32;
localparam WD_FLASH_BAST_TIME = 28; //flash base time high bit

//========================================================
//register and wire to time sequence and combine
//signal trig
reg  [WD_LED_NUMB-1:0] r_bus_monitor_signal;
wire [WD_LED_NUMB-1:0] w_bus_monitor_signal_pos;

reg  [WD_LED_NUMB-1:0] r_bus_monitor_signal_flg;
//led driver
reg [WD_LED_NUMB-1:0]   r_port_led_driv;
reg [3:0]               r_breath_time_max = 0;
reg [3:0]               r_breath_time_cnt = 0;
reg [WD_LONG_CNT-1:0]   r_real_time_cnt = 0;
//still time
reg [7:0]               r_still_time_cnt [0:WD_LED_NUMB-1];

//========================================================
//always and assign to drive logic and connect

// ----------------------------------------------------------
// signal monitor
always@(posedge i_sys_clk)
begin
    if(1) //update in one cycle
    begin
        r_bus_monitor_signal <= i_bus_monitor_signal;
    end
end
assign w_bus_monitor_signal_pos = i_bus_monitor_signal & ~r_bus_monitor_signal;


// ----------------------------------------------------------
// led driv
always@(posedge i_sys_clk)
begin
    if(r_real_time_cnt[WD_FLASH_BAST_TIME-1])
    begin
        r_real_time_cnt   <= 1'b0;
        r_breath_time_cnt <= r_breath_time_cnt == r_breath_time_max ? 1'b0 : r_breath_time_cnt + 1'b1;
        r_breath_time_max <= r_breath_time_cnt == r_breath_time_max ? r_breath_time_max + 1'b1 : r_breath_time_max;
    end
    else if(1) //update in one cycle
    begin
        r_real_time_cnt <= r_real_time_cnt + 1'b1;
    end
end
generate genvar i;
    for(i = 0; i < WD_LED_NUMB; i = i + 1)
    begin:FOR_WD_LED_NUMB
        always@(posedge i_sys_clk)
        begin
            if(r_real_time_cnt[WD_FLASH_BAST_TIME-1]) //update in one cycle
            begin
                if(r_bus_monitor_signal_flg[i])
                begin
                    r_still_time_cnt[i] <= r_still_time_cnt[i] + 1'b1;
                end
                else 
                begin
                    r_still_time_cnt[i] <= 1'b0;
                end
            end
        end
        always@(posedge i_sys_clk)
        begin
            if(r_still_time_cnt[i] == NB_LED_STILL)
            begin
                r_bus_monitor_signal_flg[i] <= 1'b0;
            end
            else if(1) //update in one cycle
            begin
                case(MD_SIG_TRIG[4*i+1-1:4*i])
                    0: r_bus_monitor_signal_flg[i] <= i_bus_monitor_signal[i];
                    1: r_bus_monitor_signal_flg[i] <= w_bus_monitor_signal_pos[i];
                endcase
                
            end
        end
    
    
        always@(posedge i_sys_clk)
        begin
            if(!i_sys_resetn) //system reset
            begin
                r_port_led_driv[i] <= 1'b0; //
            end
            else if(r_bus_monitor_signal_flg[i]) //need led work
            begin
                case(MD_LED_TASK[4*i+1-1:4*i])//
                    0: LED_STABLE(i);
                    1: LED_FLASH(i);
                    2: LED_BREATHE(i);    
                endcase
            end
            else 
            begin
                r_port_led_driv[i] <= 1'b0; //
            end
        end
    end
endgenerate
//port to board
assign o_port_led_driv = r_port_led_driv;
//========================================================
//module and task to build part of system
task LED_STABLE(input integer i);
    if(1)
        begin
            r_port_led_driv[i] <= 1'b1;
        end
endtask
task LED_FLASH(input integer i);
    if(r_real_time_cnt[WD_FLASH_BAST_TIME-1])
        begin
            r_port_led_driv[i] <= ~r_port_led_driv[i];
        end
endtask
task LED_BREATHE(input integer i);
    if(r_real_time_cnt[WD_FLASH_BAST_TIME-1] && r_breath_time_cnt == r_breath_time_max)
        begin
            r_port_led_driv[i] <= ~r_port_led_driv[i];
        end
endtask
//========================================================
//expand and plug-in part with version 

//========================================================
//ila and vio to debug and monitor



endmodule