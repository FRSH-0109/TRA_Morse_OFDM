clear;
clc;
% PARAMETRY TESTOWE
% Wiadomość do przekazania
% text1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.';
% text2 = 'We re no strangers to love. You know the rules and so do I.';

% text1 = 'We re no strangers to love. You know the rules and so do I.';
% text2 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.';
% 
% text1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.';
% text2 = 'aaaaaaaaaa$$$aaaaaaaaaaaaaaa!1810?aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
% 
% text1 = 'We re no strangers to love. You know the rules and so do I.';
% text2 = 'aaaaaaaaaa$$$aaaaaaaaaaaaaaa!1810?aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
% 
% text1 = 'aaaaaaaaaa$$$aaaaaaaaaaaaaaa!1810?aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
% text2 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam lacinia.';
% 
text1 = 'aaaaaaaaaa$$$aaaaaaaaaaaaaaa!1810?aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
text2 = 'We re no strangers to love. You know the rules and so do I.';

% Moc szumu wg SNR
snr = -10; % w dB

% OFFTOP
% kod Morse'a to 1 dla kropki, 111 dla kreski, 0 pomiędzy nimi, 000
% pomiędzy literami i 00000000 pomiędzy słowami (spacja)

% Zakodowanie tekstu na sygnał binarny
y_binary_Morse_1 = textToBinaryMorse(text1);
y_binary_Morse_2 = textToBinaryMorse(text2);

if length(y_binary_Morse_1) > length(y_binary_Morse_2)
    y_binary_Morse_2(length(y_binary_Morse_1)) = 0;
else
    y_binary_Morse_1(length(y_binary_Morse_2)) = 0;
end

% y_binary_Morse = zeros(2, max(length(y_binary_Morse_1), length(y_binary_Morse_2)));
y_binary_Morse = [y_binary_Morse_1; y_binary_Morse_2];
% disp(y_binary_Morse);

% Modulacja OFDM sygnału binarnego
[ofdm_signal_re, ofdm_signal_im] = OFDM_Transmitter(y_binary_Morse, 8);

% Dodanie zakłócenia
ofdm_signal = complex(ofdm_signal_re, ofdm_signal_im);
ofdm_signal_noise = ofdm_signal; % awgn(ofdm_signal, snr, "measured"); % awgn(ofdm_signal, snr, "measured");
signal_noise_re = real(ofdm_signal_noise);
signal_noise_im = imag(ofdm_signal_noise);

% Przekazanie sygnału do Receivera
[received_binary_1, received_binary_2] = OFDM_Receiver(signal_noise_re, signal_noise_im, 8);
binary_cutted_1 = received_binary_1(1:length(y_binary_Morse_1));
binary_cutted_2 = received_binary_2(1:length(y_binary_Morse_2));

% Sztucznie dodane zmiany dla testu calculate_wrong_signs()
% binary_cutted_1(4) = 0;
% binary_cutted_2(12) = 1;

% dekodowanie an tekst
text_out_1 = binaryMorseToText(binary_cutted_1);
text_out_2 = binaryMorseToText(binary_cutted_2);

% Wyniki eksperymentu
disp("Tekst nadany 1:")
disp(text1);

disp("Tekst 1 odczytany");
disp(text_out_1);

disp("Tekst nadany 2:")
disp(text2);

disp("Tekst 2 odczytany");
disp(text_out_2);

bit_mistake_count = calculate_wrong_signs(binary_cutted_1, y_binary_Morse_1) ...
    + calculate_wrong_signs(binary_cutted_2, y_binary_Morse_2);
disp("Źle odczytane bity:");
disp(bit_mistake_count);

bit_error_probability = round(bit_mistake_count / numel(y_binary_Morse), 3);
disp("Prawdopodobieństwo złego bitu:")
disp(bit_error_probability);

letter_mistake_count_1 = calculate_wrong_signs(upper(text_out_1), upper(text1));
disp("Żle zdekodowane symbole w tekście 1:");
disp(letter_mistake_count_1);

letter_mistake_count_2 = calculate_wrong_signs(upper(text_out_2), upper(text2));
disp("Żle zdekodowane symbole w tekście 2:");
disp(letter_mistake_count_2);
