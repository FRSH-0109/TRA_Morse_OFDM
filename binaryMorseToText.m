function [decodedText] = binaryMorseToText(binaryMorse)
    % Definicja alfabetu Morse'a, dodatkwo ze znakami specjalnymi
    morseCode = containers.Map( ...
        {'.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..', '.---', '-.-', '.-..', '--', ...
         '-.', '---', '.--.', '--.-', '.-.', '...', '-', '..-', '...-', '.--', '-..-', '-.--', '--..', ...
         '-----', '.----', '..---', '...--', '....-', '.....', '-....', '--...', '---..', '----.', ...
         '.-.-.-', '--..--', '..--..', '-.-.--', '---...', '-.-.-.', '-.--.', '-.--.-', '.-...', '-...-', '.-.-.', '-....-', '..--.-', '.-..-.', '...-..-', '.--.-.'}, ...
        {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', ...
         'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', ',', '?', ...
         '!', ':', ';', '(', ')', '&', '=', '+', '-', '_', '"', '$', '@'});
    
    decodedText = ''; % Tekst wyjsciowy
    currentSymbol = ''; % Zmienna dla tymczasowo dekodowanego znaku
    i = 1;
    
    while i <= length(binaryMorse)
        % Czy jest to spacja '0000000'
        if i <= length(binaryMorse) - 6 && isequal(binaryMorse(i:i+6), [0 0 0 0 0 0 0])
            if ~isempty(currentSymbol) % jesli byl wczesniej jest znak 
                decodedText = [decodedText, morseCodeToChar(currentSymbol, morseCode)];
                currentSymbol = '';
            end
            decodedText = [decodedText, ' '];
            i = i + 7; % Pomin indeksy dla spacji
        elseif i <= length(binaryMorse) - 2 && isequal(binaryMorse(i:i+2), [0 0 0])
            % Czy jest to przerwa pomiedzy literami '000'
            if ~isempty(currentSymbol) % jesli byl wczesniej jest znak
                decodedText = [decodedText, morseCodeToChar(currentSymbol, morseCode)];
                currentSymbol = '';
            end
            i = i + 3; % Pomin indeksy dla przerwy
        elseif binaryMorse(i) == 1
            % Wykryto kreske
            if i <= length(binaryMorse) - 2 && isequal(binaryMorse(i:i+2), [1 1 1])
                currentSymbol = [currentSymbol, '-'];
                i = i + 3; % Pomin indeksy dla kreski
            else  % Wykryto kropke
                currentSymbol = [currentSymbol, '.'];
                i = i + 1; % Pomin indeks dla kropki
            end
        elseif binaryMorse(i) == 0
            % Wykryto pojedyncze '0' pomiedzy znakami '.' i '-'
            i = i + 1; % Pomin indeks
        else
            i = i + 1; % Bład, ignorowanie indeksu
        end
    end

    % dodanie znaku do zmiennej wyjsciowej jesli takowa jest
    if ~isempty(currentSymbol)
        decodedText = strcat(decodedText, morseCodeToChar(currentSymbol, morseCode));
    end
end

function char = morseCodeToChar(morseSymbol, morseCode)
    % Konwersja kodu morsa na znak
    if isKey(morseCode, morseSymbol)
        char = morseCode(morseSymbol);
    else
        char = ''; % Zwrca pusty jesli takowego nie ma w mapie
        warning('Unrecognized Morse symbol: %s', morseSymbol);
    end
end