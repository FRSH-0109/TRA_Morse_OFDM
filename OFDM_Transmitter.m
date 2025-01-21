function [ofdm_signal_re, ofdm_signal_im] = OFDM_Transmitter(input_code, n, A, fc)
%OFDM_TRANSMITTER Function reprezents the OFDM modulation transmitter

input_bins = qamCoder(input_code, n);

ifft_output = ifft(input_bins);

ifft_re = real(ifft_output);
ifft_im = imag(ifft_output);

ofdm_signal_re = reshape(ifft_re, [numel(ifft_re) 1]).';
ofdm_signal_im = reshape(ifft_im, [numel(ifft_im) 1]).';

end

