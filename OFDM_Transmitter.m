function ofdm_signal = OFDM_Transmitter(input_code, A, fc)
%OFDM_TRANSMITTER Function reprezents the OFDM modulation transmitter

% ifft_output = 

ifft_re = randn(1, length(input_code)); % real(ifft_output);
ifft_im = randn(1, length(input_code)); % imag(ifft_output);

% re_carrier = A.*sin(2*pi*fc*(1:1000));
% im_carrier = A.*cos(2*pi*fc*(1:1000));

re_carrier = A.*sin(2*pi*(1/fc)*(1:length(ifft_re)));
im_carrier = A.*cos(2*pi*(1/fc)*(1:length(ifft_im)));

% Wykres do testów
% figure(1);
% plot(1:length(re_carrier), re_carrier);
% hold on;
% plot(1:length(im_carrier), im_carrier);
% legend("Re carrier", "Im carrier");

modulated_re = ifft_re.*re_carrier;
modulated_im = ifft_im.*im_carrier;

% Wykres do testów
% figure(1);
% plot(1:length(modulated_re), modulated_re);
% hold on;
% plot(1:length(ifft_re), ifft_re);
% legend("modulated re", "ifft re");
% 
% figure(2);
% plot(1:length(modulated_im), modulated_im);
% hold on;
% plot(1:length(ifft_im), ifft_im);
% legend("modulated re", "ifft re");

ofdm_signal = modulated_re + modulated_im;
end

