function [r1] = histogram_equalization(   %histogram equalization calculate
                                    i1 % image of 2D
);
# --------------------------------------------------------------------------------
# get hight and width
h = size(i1,1)
w = size(i1,2)
bar = waitbar(0,'load1...');  %Creat process bar
# --------------------------------------------------------------------------------
# get gray level to analysis
gray_level = zeros(1,256);
for i = 1:h 
    for j = 1:w 
        gray_level(i1(i,j)+1) = gray_level(i1(i,j)+1) + 1;
        waitbar(i/h);
    end 
end 

# --------------------------------------------------------------------------------
# get gray sum
gray_sum = zeros(1,256);
for i = 1 : 256
    if (i == 1)
        gray_sum(i) = gray_level(i);
    else 
        gray_sum(i) = gray_sum(i-1) + gray_level(i);
    end 
    waitbar(i/256);
end 

# --------------------------------------------------------------------------------
# get gray equal result
gray_equal = zeros(h,w);
gray_y = (w * h) / 255;
for i = 1 : h 
    for j = 1 : w 
        gray_equal(i,j) = gray_sum(i1(i,j)+1) / gray_y;
    end 
    waitbar(i/h);
end 
gray_equal = uint8(gray_equal);
r1 = gray_equal;

# --------------------------------------------------------------------------------
# close 
close(bar);