bps = 2;    % Bits per symbol
M = 2^bps;  % 16QAM
nFFT = 128; % Number of FFT bins

text = 'Aasdsa Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.';
y_binary_Morse = textToBinaryMorse(text);

for i=1:length(y_binary_Morse)/2
    binStr = string(y_binary_Morse(2*i)) + string(y_binary_Morse(2*i-1));
    txsymbols(i) = bin2dec(binStr);
end
txsymbols = txsymbols(1:nFFT);
% txsymbols = randi([0 M-1],nFFT,1);
txgrid = qammod(txsymbols,M,UnitAveragePower=true);
txout = ifft(txgrid,nFFT);
stem(1:nFFT,real(txout));
stem(1:nFFT,imag(txout));

rxin = awgn(txout,40);
rxgrid = fft(rxin,nFFT);
rxsymbols = qamdemod(rxgrid,M,UnitAveragePower=true);
if isequal(txsymbols,rxsymbols)
    disp("Recovered symbols match the transmitted symbols.")
else
    disp("Recovered symbols do not match transmitted symbols.")
end

rx_bin = zeros(1, length(rxsymbols)*bps);
for i=1:length(rxsymbols)
    symbol = rxsymbols(i);
    if symbol == 0
        rx_bin(1, 2*i-1) = 0;
        rx_bin(1, 2*i) = 0;
    elseif symbol == 1
        rx_bin(1, 2*i-1) = 1;
        rx_bin(1, 2*i) = 0;
    elseif symbol == 2
        rx_bin(1, 2*i-1) = 0;
        rx_bin(1, 2*i) = 1;
    elseif symbol == 3
        rx_bin(1, 2*i-1) = 1;
        rx_bin(1, 2*i) = 1;
    end
end

rx_text = binaryMorseToText(rx_bin);