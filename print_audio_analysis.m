function print_audio_analysis(audioData, sampleRate, filterClass)
%This function generates subplots relating to the audio wave we are working
%with

firstFreq  = [0 170 310 600 1000 3000 6000 12000 14000];
secondFreq = [170 310 600 1000 3000 6000 12000 14000 16000];
order = 0;
noOfSamples = length(audioData);
t = linspace(0, noOfSamples/sampleRate, noOfSamples);
f = linspace(-sampleRate/2, sampleRate/2,noOfSamples);

if filterClass == 0 % FIR
    order = 500;
elseif filterClass == 1 % IIR
    order = 4;
end

[b, a] = low_pass(170, sampleRate, filterClass, order);

% Filter analysis
TF = tf(b, a);

figure();
freqz(b, a, noOfSamples);
title('Magnitude & Phase of H1(Z) (0 - 170)');

figure();
subplot(3, 1, 1);
pzmap(TF);
title('Zeros & Poles of H1(Z) (0 - 170)');

subplot(3, 1, 2);
impulse(TF);
title('Impulse response h1(n)');

subplot(3, 1, 3);
step(TF);
title('Step response S1(n)')

%Output analysis
y = filter(b, a, audioData);
Y = fftshift(fft(y)/sampleRate);

figure();
subplot(3, 1, 1);
plot(t,y);
title('Time domain of y1(n)');

subplot(3, 1, 2);
plot(f, abs(Y));
title('Magnitude of Y1(w)');

subplot(3, 1, 3);
plot(f, angle(Y));
title('Phase of Y1(w)');

for i=2:9
    [b, a] = band_pass(firstFreq(i), secondFreq(i), sampleRate, filterClass, order);
    
    %Filter Analysis
    TF = tf(b, a);
    
    figure();
    freqz(b, a, noOfSamples);
    range = strcat(' (',int2str(firstFreq(i)),'Hz - ',int2str(secondFreq(i)),'Hz)');
    title(strcat('Magnitude & Phase of H',int2str(i),'(Z)',range));
    
    figure();
    subplot(3, 1, 1);
    pzmap(TF);
    title(strcat('Zeros & Poles of H',int2str(i),'(Z)',range));
    
    subplot(3, 1, 2);
    step(TF);
    title(strcat('Step response S',int2str(i),'(n)'));
    
    subplot(3, 1, 3);
    impulse(TF);
    title(strcat('Impulse response h',int2str(i),'(n)'));
    
    %Output Analysis
    y = filter(b, a, audioData);
    Y = fftshift(fft(y)/sampleRate);
    
    figure();
    subplot(3, 1, 1);
    plot(t,y);
    title(strcat('Time domain y', int2str(i), '(n)', range));
    
    subplot(3, 1, 2);
    plot(f, abs(Y));
    title(strcat('Magnitude of Y', int2str(i), '(w)'));
    
    subplot(3, 1, 3);
    plot(f, angle(Y));
    title(strcat('Phase of Y', int2str(i), '(w)'));
end

end

