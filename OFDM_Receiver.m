function received_binary = OFDM_Receiver(received_signal_re, received_signal_im, n, A, fc)
%OFDM_RECEIVER Function reprezents the OFDM modulation receiver

complex_signal = complex(received_signal_re, received_signal_im);
signal_sizes = [n, round(length(complex_signal) / n)];
signal_framed = reshape(complex_signal, signal_sizes);

fft_bins = fft(signal_framed, n, 1);
received_binary = qamDecoder(fft_bins);
end

