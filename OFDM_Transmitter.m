function ofdm_signal = OFDM_Transmitter(input_code, n, A, fc)
%OFDM_TRANSMITTER Function reprezents the OFDM modulation transmitter

input_bins = qamCoder(input_code, n);

ifft_output = ifft(input_bins);

ifft_re = real(ifft_output); % randn(1, length(input_code));
ifft_im = imag(ifft_output); % randn(1, length(input_code));

% re_carrier = A.*sin(2*pi*fc*(1:1000));
% im_carrier = A.*cos(2*pi*fc*(1:1000));

re_carrier = A.*sin(2*pi*(1/fc)*(1:size(ifft_re, 1)));
im_carrier = A.*cos(2*pi*(1/fc)*(1:size(ifft_im, 1)));

% Wykres do testów
% figure(1);
% plot(1:length(re_carrier), re_carrier);
% hold on;
% plot(1:length(im_carrier), im_carrier);
% legend("Re carrier", "Im carrier");

modulated_re = ifft_re.*re_carrier.';
modulated_im = ifft_im.*im_carrier.';

% for i=1:size(ifft_re, 2)
%     modulated_re = (ifft_re(:, i).').*re_carrier;
%     modulated_im = (ifft_im(:, i).').*im_carrier;
% 
%     %Wykres do testów
%     figure(2*i-1);
%     plot(1:length(modulated_re), modulated_re);
%     hold on;
%     plot(1:length(ifft_re), ifft_re(:, i));
%     hold on;
%     plot(1:length(re_carrier), re_carrier);
%     legend("modulated re", "ifft re");
% 
%     figure(2*i);
%     plot(1:length(modulated_im), modulated_im);
%     hold on;
%     plot(1:length(ifft_im), ifft_im(:, i));
%     legend("modulated im", "ifft im");
% end

modulated_combined = modulated_re + modulated_im;
ofdm_signal = reshape(modulated_combined, [numel(modulated_combined) 1]).';
end

