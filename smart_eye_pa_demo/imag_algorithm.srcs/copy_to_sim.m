##################################################################################
## Company: fpgaPublish
## Engineer: f
## 
## Create Date: 2023/07/29 16:04:07
## Design Name: copy_to_sim
## Module Name: 
## Project Name: 
## Target Devices: 
## Tool Versions: 
## Description: 
## 
## Dependencies: 
##  
## Revision: 
## Revision 0.01 - File Created 
## Additional Comments:
## 
##################################################################################
function [r1] = copy_to_sim(   %
                            i1 %
);
p_own = pwd
p_own_last = strsplit(p_own,'.');
p_dst_l = strcat(p_own_last(1,1),'.sims\data\');
mkdir(p_dst_l{1,1});
p_src='.\data\';
pns_src = strcat(p_src,i1)
copyfile(pns_src,p_dst_l{1,1},'f');