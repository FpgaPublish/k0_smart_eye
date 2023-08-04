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
# add RGB to Ycbcr
if (0) 
    # --------------------------------------------------------------------------------
    # solve data
    n = size(l_img,1)
    img_ycbcr = rgb_to_ycbcr(l_img{1});
    # --------------------------------------------------------------------------------
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
    # --------------------------------------------------------------------------------
    # save data
    name = "rgb.dat"
    imag_to_file(name,l_img{1});
    name = "ycbcr.dat"
    imag_to_file(name,img_ycbcr);
    # --------------------------------------------------------------------------------
    # copy file to sim
    name = "rgb.dat"
    copy_to_sim(name);
    name = "ycbcr.dat"
    copy_to_sim(name);
end 
# ================================================================================
# histogram
if(1)
    # --------------------------------------------------------------------------------
    # add image
    img_gray = rgb2gray(l_img{2});
    img_hist = histogram_equalization(img_gray);
    # --------------------------------------------------------------------------------
    # 2D to 3D
    img_gray = cat(3,img_gray,img_gray,img_gray);
    img_hist = cat(3,img_hist,img_hist,img_hist);
    # --------------------------------------------------------------------------------
    # show data
    figure(2);
    subplot(2,1,1); imshow(img_gray);title("gray");
    subplot(2,1,2); imshow(img_hist);title("hist");
    # --------------------------------------------------------------------------------
    # save data
    name = "gray.dat";
    imag_to_file(name,img_gray);
    name = "hist.dat";
    imag_to_file(name,img_hist);
    # --------------------------------------------------------------------------------
    # copy data to PL sim
    name = "gray.dat";
    copy_to_sim(name);
    name = "hist.dat";
    copy_to_sim(name);
end 