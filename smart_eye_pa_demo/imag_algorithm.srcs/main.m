##################################################################################
## Company: fpgaPublish
## Engineer: f
## 
## Create Date: 2023/07/09 15:29:36
## Design Name: main
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
clear all; close all; clc;
pwd()
# ================================================================================
# run imag prepare
l_img = prepare_imag();
# ================================================================================
# solve data
n = size(l_img,1)
img_ycbcr = rgb_to_ycbcr(l_img{1});
# ================================================================================
# show result
subplot(222);
imshow(img_ycbcr(:,:,1));
title("Y");
subplot(223);
imshow(img_ycbcr(:,:,2));
title("Cb");
subplot(224);
imshow(img_ycbcr(:,:,3));
title("Cr");
# ================================================================================
# save data
name = "rgb.dat"
imag_to_file(name,l_img{1});
name = "ycbcr.dat"
imag_to_file(name,img_ycbcr);
# ================================================================================
# copy file to sim
name = "rgb.dat"
copy_to_sim(name);
name = "ycbcr.dat"
copy_to_sim(name);