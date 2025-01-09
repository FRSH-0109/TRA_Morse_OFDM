function [output_array] = qamDecoder(baskets_matrix)
%baskets_matrix -  macierz składająca się z koszyków w wektorach pionowych
%output_array - wyjsciowy ciag binarny
idx = 1;
for h=1:height(baskets_matrix)
    for w=1:width(baskets_matrix)
        i = baskets_matrix(h, w);
        if i == (1 + 1i)
            binary_i = 1;
            binary_ii = 1;
        elseif i == (1 - 1i)
            binary_i = 1;
            binary_ii = 0;
        elseif i == (-1 - 1i)
            binary_i = 0;
            binary_ii = 0;
        else 
            binary_i = 0;
            binary_ii = 1;
        end
        
        output_array(idx) = binary_i;
        output_array(idx+1) = binary_ii;
        idx = idx + 2;
    end
end
   
end

