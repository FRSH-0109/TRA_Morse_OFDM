function [basket] = qamCoder(input_array, n)
%input array -  ciąg bitów do kodowania
%n -  ilosc koszykow wyjscowych
%basket - macierz dla ktorej w pionie sa kolejne koszyki, w poziomie ich
%zespolony wektor
nTmp = 1;
basket = [];
basketIdx = 1;
for i=1:2:length(input_array)
    
    if(nTmp > n)
        nTmp = 1;
        basketIdx = basketIdx + 1;
    end
    
    q = input_array(i);
    qq = 0;
    if(i+1 <= length(input_array))
        qq =input_array(i+1);
    end

    if(q == 1 && qq == 1)
        basket(nTmp, basketIdx) = 1 + 1i;
    elseif (q == 1 && qq == 0)
        basket(nTmp, basketIdx) = 1 - 1i;
    elseif (q == 0 && qq == 0)
        basket(nTmp, basketIdx) = -1 - 1i;
    else 
        basket(nTmp, basketIdx) = -1 + 1i;
    end
        
    nTmp = nTmp+1;
end

end

