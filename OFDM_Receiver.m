function received_binary = OFDM_Receiver(received_signal_re, received_signal_im, n)
%OFDM_RECEIVER Function reprezents the OFDM modulation receiver

% Złożenie sygnału z toru rzeczywistego i urojonego
complex_signal = complex(received_signal_re, received_signal_im);

% Podział sygnału na koszyki na potrzeby zrównoleglenia
signal_sizes = [n, round(length(complex_signal) / n)];
signal_framed = reshape(complex_signal, signal_sizes);

% FFT koszyków
fft_bins = fft(signal_framed, n, 1);

% Dekodowanie znaków QAM na kod binarny
received_binary = qamDecoder(fft_bins);
end

