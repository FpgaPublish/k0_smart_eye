function [r1] = imag_to_file(   %
                            i1, %file name
                            i2 %file data
);
# open file
mkdir('data');
path = ['.\data\',i1];
fid = fopen(path,'wt');

# get data 
h = size(i2,1)
w = size(i2,2)
bar = waitbar(0,'load...');  %Creat process bar
for row = 1 : h 

    D1 = lower(dec2hex(i2(row,:,1),2));
    D2 = lower(dec2hex(i2(row,:,2),2));
    D3 = lower(dec2hex(i2(row,:,3),2));
    for col = 1 : w
        fprintf(fid,'%s ',D1(col,:));
        fprintf(fid,'%s ',D2(col,:));
        fprintf(fid,'%s ',D3(col,:));
    end 
    fprintf(fid,'\n');
    waitbar(row/h);
end 
fclose(fid);
close(bar);