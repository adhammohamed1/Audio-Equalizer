function resultData = apply_filters(audioData, sampleRate, gains, filterClass)

firstFreq  = [0 170 310 600 1000 3000 6000 12000 14000];
secondFreq = [170 310 600 1000 3000 6000 12000 14000 16000];
order = 0;

if filterClass == 0 % FIR
    order = 500;
elseif filterClass == 1 % IIR
    order = 4;
end

[b, a] = low_pass(170, sampleRate, filterClass, order);
y = filter(b, a, audioData);
resultData = y * gains(1);

for i=2:9
    [b, a] = band_pass(firstFreq(i), secondFreq(i), sampleRate, filterClass, order);
    y = filter(b, a, audioData);
    resultData = resultData + y * gains(i);
end

end
