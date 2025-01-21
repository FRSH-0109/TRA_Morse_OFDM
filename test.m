clear;
clc;

text = 'Aasdsa Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.';
% text = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
% OFFTOP
% kod Morse'a to 1 dla kropki, 111 dla kreski, 0 pomiędzy nimi, 000
% pomiędzy literami i 00000000 pomiędzy słowami (spacja)

% Zakodowanie tekstu na sygnał binarny
y_binary_Morse = textToBinaryMorse(text);
disp(y_binary_Morse)

% Modulacja OFDM sygnału binarnego
[ofdm_signal_re, ofdm_signal_im] = OFDM_Transmitter(y_binary_Morse, 8, 1, 1e4);

% Dodanie zakłócenia

% wrzucenie do Receivera
received_binary = OFDM_Receiver(ofdm_signal_re, ofdm_signal_im, 8, 1, 1e4);
binary_cutted = received_binary(1:length(y_binary_Morse));

% Sztucznie dodane zmiany dla testu calculate_wrong_signs()
binary_cutted(4) = 0;
binary_cutted(12) = 0;

% dekodowanie an tekst
text_out = binaryMorseToText(binary_cutted);
disp(text_out);

bit_mistake_count = calculate_wrong_signs(binary_cutted, y_binary_Morse);
disp(bit_mistake_count);

letter_mistake_count = calculate_wrong_signs(upper(text_out), upper(text));
disp(letter_mistake_count);
