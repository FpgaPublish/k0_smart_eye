// *********************************************************************************
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/07/30 21:14:27
// Design Name: 
// Module Name: vip_read_imag
// Project Name: 
// Target Devices: ZYNQ7010 & XAUG
// Tool Versions: 2021.1
// Description: 
//          1. read 3 channel image data 
// Dependencies: 
//          
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 1. use
// vip_read_imag c_rgb   = new("./data/rgb.dat",W_IMG,H_IMG);
// ***********************************************************************************

class vip_read_imag;
    logic [24-1:0]  dat_fifo[1920*1280];
    logic [24-1:0]  dat;
    integer fid;
    integer err;
    integer i,j,k,m;
    integer w_set,h_set;
    function new(string name,integer w,integer h);
        begin
            i = 0;
            j = 0;
            k = 0;
            m = 0;
            w_set = w;
            h_set = h;
            fid = $fopen(name,"r");
            $fseek(fid,0,0);
            while(!$feof(fid))
            begin
                err = $fscanf(fid,"%x",dat);
                if(err == 0 || err == -1)
                begin
                    $display("whole get dat = %d",m);
                    $display("whole get row = %d",j);
                end
                else 
                begin
                    m = m + 1;
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
                        end
                        else 
                        begin
                            i = i + 1;
                        end
                    end
                end 
            end
            $fclose(fid);
        end
    endfunction //new()
endclass //vip_read_imag