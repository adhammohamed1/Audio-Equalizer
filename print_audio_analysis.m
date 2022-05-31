function figures = print_audio_analysis(audioData, sampleRate, gains, filterClass)
%This function generates subplots relating to the audio wave we are working
%with

firstFreq  = [0 170 310 600 1000 3000 6000 12000 14000];
secondFreq = [170 310 600 1000 3000 6000 12000 14000 16000];
order = 0;
samples = length(audioData);
t = linspace(0,samples/sampleRate,samples);
f = linspace(-sampleRate/2,sampleRate/2,samples);
figures = [];

if filterClass == 0 % FIR
    order = 100;
elseif filterClass == 1 % IIR
    order = 4;
end

[b, a] = low_pass(170, sampleRate, filterClass, order);
y = filter(b, a, audioData);
resultData = y * gains(1);

% Filter analysis
TF = tf(b, a);

fig = figure();
freqz(b, a, samples);
title('Magnitude & Phase of H1(Z) (0 - 170)');
figures = [figures fig];

fig = figure();
subplot(3, 1, 1);
pzmap(TF);
title('Zeros & Poles of H1(Z) (0 - 170)');
figures = [figures fig];

subplot(3, 1, 2);
impulse(TF);
title('Impulse response h1(n)');

subplot(3, 1, 3);
step(TF);
title('Step response s1(n)')

%Output analysis
y = filter(b, a, audioData);
Y = fftshift(fft(y/sampleRate));

fig = figure();
subplot(3, 1, 1);
plot(t,y);
title('Time domain of y1(n)');
figures = [figures fig];

subplot(3, 1, 2);
plot(f, abs(Y));
title('Magnitude of Y1(w)');

subplot(3, 1, 3);
plot(f, angle(Y));
title('Phase of Y1(w)');

for i=2:9
    [b, a] = band_pass(firstFreq(i), secondFreq(i), sampleRate, filterClass, order);
    y = filter(b, a, audioData);
    resultData = resultData + y * gains(i);
    
    %Filter Analysis
    TF = tf(b, a);
    
    fig = figure();
    freqz(b, a, samples);
    range = strcat(' (',int2str(firstFreq(i)),'Hz - ',int2str(secondFreq(i)),'Hz)');
    title(strcat('Magnitude & Phase of H',int2str(i),'(Z)',range));
    figures = [figures fig];
    
    fig = figure();
    subplot(3, 1, 1);
    pzmap(TF);
    title(strcat('Zeros & Poles of H',int2str(i),'(Z)',range));
    figures = [figures fig];
    
    subplot(3, 1, 2);
    step(TF);
    title(strcat('Step response S',int2str(i),'(n)'));
    
    subplot(3, 1, 3);
    impulse(TF);
    title(strcat('Impulse response h',int2str(i),'(n)'));
    
    %Output Analysis
    y = filter(b, a, audioData);
    Y = fftshift(fft(y/sampleRate));
    
    fig = figure();
    subplot(3, 1, 1);
    plot(t,y);
    title(strcat('Time domain y', int2str(i), '(n)', range));
    figures = [figures fig];
    
    subplot(3, 1, 2);
    plot(f, abs(Y));
    title(strcat('Magnitude of Y', int2str(i), '(w)'));
    
    subplot(3, 1, 3);
    plot(f, angle(Y));
    title(strcat('Phase of Y', int2str(i), '(w)'));
end

end

