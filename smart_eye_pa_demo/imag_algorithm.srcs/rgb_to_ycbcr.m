# rgb to YCbCr
function [r1] = rgb_to_ycbcr(   %
                                    i1 % imag of rgb
                                    #i2  %
);

bar = waitbar(0,'calculate...');  %Creat process bar
h = size(i1,1)
w = size(i1,2)
i1 = double(i1);
r1 = zeros(h,w,3);
for i = 1 : h
    for j = 1 : w 
        r1(i,j,1) = bitshift((i1(i,j,1)) * 76 
                    + i1(i,j,2) * 150
                    + i1(i,j,3) * 29, 
                    -8);
        r1(i,j,2) = bitshift(-(i1(i,j,1)) * 43 
                    - i1(i,j,2) * 84
                    + i1(i,j,3) * 128
                    + 32768, 
                    -8);
        r1(i,j,3) = bitshift((i1(i,j,1)) * 128
                    - i1(i,j,2) * 107
                    - i1(i,j,3) * 20
                    + 32768,
                    -8);
        waitbar(i/h);
    end 
end

close(bar);   # Close waitbar