function ofdm_signal = OFDM_Transmitter(input_code, n, A, fc)
%OFDM_TRANSMITTER Function reprezents the OFDM modulation transmitter

input_bins = qamCoder(input_code, n);
%disp(input_bins)

ifft_output = ifft(input_bins);

ifft_re = real(ifft_output); % randn(1, length(input_code));
ifft_im = imag(ifft_output); % randn(1, length(input_code));

% re_carrier = A.*sin(2*pi*fc*(1:1000));
% im_carrier = A.*cos(2*pi*fc*(1:1000));
serial_re = reshape(ifft_re, [numel(ifft_re) 1]).';
serial_im = reshape(ifft_im, [numel(ifft_im) 1]).';

re_carrier = A.*sin(2*pi*(1/fc)*(1:length(serial_re)));
im_carrier = A.*cos(2*pi*(1/fc)*(1:length(serial_im)));

% Wykres do testów
% figure(1);
% plot(1:length(re_carrier), re_carrier);
% hold on;
% plot(1:length(im_carrier), im_carrier);
% legend("Re carrier", "Im carrier");

modulated_re = serial_re.*re_carrier;
modulated_im = serial_im.*im_carrier;

% Wykres do testów
figure(1);
plot(1:length(modulated_re), modulated_re);
hold on;
plot(1:length(serial_re), serial_re(1, :));
% plot(1:length(re_carrier), re_carrier);
legend("modulated re", "ifft re");

figure(2);
plot(1:length(modulated_im), modulated_im);
hold on;
plot(1:length(serial_im), serial_im(1, :));
legend("modulated im", "ifft im");

ofdm_signal = modulated_re + modulated_im;

% if width(modulated_combined) > 1
%     ofdm_signal = reshape(modulated_combined, [numel(modulated_combined) 1]).';
% else
%     ofdm_signal = modulated_combined;
% end
end

