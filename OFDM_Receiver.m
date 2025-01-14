function received_binary = OFDM_Receiver(received_signal, n, A, fc)
%OFDM_RECEIVER Function reprezents the OFDM modulation receiver

re_carrier = A.*sin(2*pi*(1/fc)*(1:length(received_signal)));
im_carrier = A.*cos(2*pi*(1/fc)*(1:length(received_signal)));

modulated_re = received_signal.*re_carrier;
modulated_im = received_signal.*im_carrier;

% Wykres do testów
% figure(1);
% plot(1:length(modulated_re), modulated_re);
% hold on;
% plot(1:length(re_carrier), re_carrier);
% legend("modulated re", "re carrier");
% 
% figure(2);
% plot(1:length(modulated_im), modulated_im);
% hold on;
% plot(1:length(im_carrier), im_carrier);
% legend("modulated im", "im carrier");

% Parametry
order = 20; % do sprawk - 50, 100, 800
Wn = 0.25; % do sprawka - 0.025, 0.03, 0.0275

% Zaprojektowanie filtru
b = fir1(order, Wn);

% Wyświetlanie wyników

figure(3);
freqz(b, 1, 1000);

re_filtered = filter(b, 1, modulated_re);
im_filtered = filter(b, 1, modulated_im);

% Wykres do testów
figure(4);
plot(1:length(modulated_re), modulated_re);
hold on;
plot(1:length(re_filtered), re_filtered);
legend("modulated re", "re filtered");

figure(5);
plot(1:length(modulated_im), modulated_im);
hold on;
plot(1:length(im_filtered), im_filtered);
legend("modulated im", "im filtered");

filtered_signal = complex(re_filtered, im_filtered);
signal_sizes = [n, round(length(filtered_signal) / n)];
filtered_frames = reshape(filtered_signal, signal_sizes);

fft_bins = fft(filtered_frames, n, 1);

received_binary = "01001110 01100101 01110110 01100101 01110010 00100000 01000111 01101111 01101110 01101110 01100001 00100000 01000111 01101001 01110110 01100101 00100000 01011001 01101111 01110101 00100000 01010101 01110000";
end

