function [output_array] = qamDecoder(baskets_matrix)
%baskets_matrix -  macierz składająca się z koszyków w wektorach pionowych
%output_array - wyjsciowy ciag binarny
idx = 1;

corners = [1+1i, -1+1i, -1-1i, 1-1i]; 
% narozniki kwadratu jednostkowego w przestrzeni zespolonej

for w=1:width(baskets_matrix)
    for h=1:height(baskets_matrix)
        z = baskets_matrix(h, w); % zapis liczby zespolonej
        distances = abs(z - corners);   % obliczenia ogleglosci do kazdego naroznika
        [~, closest_index] = min(distances); % Wyznaczenie indeksu dla najblizszego naroznika
        closest_corner = corners(closest_index); % Zapis najblizszego naroznika
        
        % Przypisanie wartosci binarnej dla dwoch kolejnych bitow
        if closest_corner == (1 + 1i)
            binary_i = 1;
            binary_ii = 1;
        elseif closest_corner == (1 - 1i)
            binary_i = 1;
            binary_ii = 0;
        elseif closest_corner == (-1 - 1i)
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

