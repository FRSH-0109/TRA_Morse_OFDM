clear;
clc;

% Wiadomość do przekazania
% text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.';
text = 'We re no strangers to love. You know the rules and so do I. A full commitment s what I m thinkin of. You wouldn t get this from any other guy.';
% text = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
% OFFTOP
% kod Morse'a to 1 dla kropki, 111 dla kreski, 0 pomiędzy nimi, 000
% pomiędzy literami i 00000000 pomiędzy słowami (spacja)

% Zakodowanie tekstu na sygnał binarny
y_binary_Morse = textToBinaryMorse(text);
disp(y_binary_Morse)

% Modulacja OFDM sygnału binarnego
[ofdm_signal_re, ofdm_signal_im] = OFDM_Transmitter(y_binary_Morse, 8);

% Dodanie zakłócenia
ofdm_signal = complex(ofdm_signal_re, ofdm_signal_im);
ofdm_signal_noise = awgn(ofdm_signal, 40, "measured");
signal_noise_re = real(ofdm_signal_noise);
signal_noise_im = imag(ofdm_signal_noise);

% Przekazanie sygnału do Receivera
received_binary = OFDM_Receiver(signal_noise_re, signal_noise_im, 8);
binary_cutted = received_binary(1:length(y_binary_Morse));

% Sztucznie dodane zmiany dla testu calculate_wrong_signs()
% binary_cutted(4) = 0;
% binary_cutted(12) = 0;

% dekodowanie an tekst
text_out = binaryMorseToText(binary_cutted);
disp(text_out);

% Wyniki eksperymentu
bit_mistake_count = calculate_wrong_signs(binary_cutted, y_binary_Morse);
disp("Wrong bits found:");
disp(bit_mistake_count);

bit_error_probability = round(bit_mistake_count / length(y_binary_Morse), 3);
disp("Bit error probability is:")
disp(bit_error_probability);

letter_mistake_count = calculate_wrong_signs(upper(text_out), upper(text));
disp("Wrong symbols decoded:");
disp(letter_mistake_count);
