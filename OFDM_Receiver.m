function [received_binary_1, received_binary_2] = OFDM_Receiver(received_signal_re, received_signal_im, n)
%OFDM_RECEIVER Function reprezents the OFDM modulation receiver

% Złożenie sygnału z toru rzeczywistego i urojonego
complex_signal = complex(received_signal_re, received_signal_im);

% Podział sygnału na koszyki na potrzeby zrównoleglenia
signal_sizes = [n, round(length(complex_signal) / n)];
signal_framed = reshape(complex_signal, signal_sizes);

% FFT koszyków
fft_bins = fft(signal_framed, n, 1);

scatter(real(fft_bins), imag(fft_bins), 50, [0 0.4470 0.7410], '.');
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
xlabel("Re");
ylabel("Im");
title("Symbole QAM odczytane przez odbiornik.");

% Dekodowanie znaków QAM na kod binarny
received_binary = qamDecoder(fft_bins);

received_binary_1 = received_binary(1:2:length(received_binary)-1);
received_binary_2 = received_binary(2:2:length(received_binary));
end

