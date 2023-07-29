# read imag bmp and output it
function [r] = prepare_imag(        %
                                    %i1, %path 
                                    %i2  %name
);
# ================================================================================
# add path
p_file = pwd
l_file = glob("./imags/*")

# ================================================================================
# scan read bmp file
numb = rows(l_file);
j = 0;
for i = 1 : numb
    name = l_file(i,:);
    if (regexp(name{1},'.*\w+\.bmp.*') == 1)
        j = j + 1;
        l_name{j} = name{1};
    end
end
numb_file = j

# ================================================================================
# plot imag 
for i = 1 : numb_file
    im = imread(l_name{i});
    subplot(numb_file,1,i);
    imshow(im);
    r{i} = im;
    hold on;
end


endfunction
