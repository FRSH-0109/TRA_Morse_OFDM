function ofdm_signal = OFDM_Transmitter(input_code, n, A, fc)
%OFDM_TRANSMITTER Function reprezents the OFDM modulation transmitter

input_bins = qamCoder(input_code, n);
%disp(input_bins)

ifft_output = ifft(input_bins);

ifft_re = real(ifft_output); % randn(1, length(input_code));
ifft_im = imag(ifft_output); % randn(1, length(input_code));

serial_re = reshape(ifft_re, [numel(ifft_re) 1]).';
serial_im = reshape(ifft_im, [numel(ifft_im) 1]).';

% re_carrier = A.*sin(2*pi*(1/fc)*(1:length(serial_re)));
% im_carrier = A.*cos(2*pi*(1/fc)*(1:length(serial_im)));
% 
% modulated_re = serial_re.*re_carrier;
% modulated_im = serial_im.*im_carrier;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = 1e6;
modulated_re = ammod(serial_re,fc,fs);
modulated_im = ammod(serial_im,fc,fs, pi/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wykres do testów
% figure();
% plot(1:length(re_carrier), re_carrier);
% legend('re carier tx ');
figure();
plot(1:length(serial_re), serial_re(1, :));
legend('re serial tx');
% hold on;
% plot(1:length(modulated_re), modulated_re);
% legend('re modulated tx');

% plot(1:length(re_carrier), re_carrier);
% legend("modulated re", "ifft re");

% figure(2);
% % plot(1:length(modulated_im), modulated_im);
% % hold on;
% plot(1:length(serial_im), serial_im(1, :));
% legend("modulated im", "ifft im");

ofdm_signal = modulated_re + modulated_im;

% if width(modulated_combined) > 1
%     ofdm_signal = reshape(modulated_combined, [numel(modulated_combined) 1]).';
% else
%     ofdm_signal = modulated_combined;
% end
end

