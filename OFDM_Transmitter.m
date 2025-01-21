function [ofdm_signal_re, ofdm_signal_im] = OFDM_Transmitter(input_code, n)
%OFDM_TRANSMITTER Function reprezents the OFDM modulation transmitter

% Kodowanie sygnału w modulacji 4QAM
input_bins = qamCoder(input_code, n);

% IFFT zakodowanego sygnału
ifft_output = ifft(input_bins);

% Rozbicie na tor liczb rzeczywistych i urojonych
ifft_re = real(ifft_output);
ifft_im = imag(ifft_output);

% Ułożenie w pojedynczy wektor do wysłania
ofdm_signal_re = reshape(ifft_re, [numel(ifft_re) 1]).';
ofdm_signal_im = reshape(ifft_im, [numel(ifft_im) 1]).';
end

