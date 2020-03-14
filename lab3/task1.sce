path = '/Users/katusha/lab2/dd'
b = chdir(path)

drums = loadwave('data_hw3/drums.wav');

speech = loadwave('data_hw3/speech.wav')(1);
violin = loadwave('data_hw3/violin.wav');
voice = loadwave('data_hw3/voice.wav');

[user_track, fs1] = wavread('data_hw3/user_track.wav');
save_path = "./results/"

function y=convolution_signals(f, g)
    f_with_zeros = cat(2, f, zeros(1, length(g))) // y=cat(dims,A1,A2,A3)
    g_with_zeros = cat(2, g, zeros(1, length(f)))
    fft_f = fft(f_with_zeros)
    fft_g = fft(g_with_zeros)
    
    y = ifft(fft_f .* fft_g)   
endfunction

fir = loadwave('irc_room.wav')(1,:);
printf('\n')

// Block for Loading and Convolution with our own algorithm: 
tic();
result_voise = convolution_signals(voice, fir)

t1 = toc();
savewave(save_path + 'voice.wav', result_voise, 44100)
printf("Time for voice convolution (tic-toc): %f \n",t1);

tic();
result_speech = convolution_signals(speech, fir)
t2 = toc();
savewave(save_path + 'speech.wav', result_voise, 44100)
printf("Time for speech convolution (tic-toc): %f \n",t2);

tic();
result_violin = convolution_signals(violin, fir)
t3 = toc();
savewave(save_path + 'violing.wav', result_violin, 44100)
printf("Time for violin convolution (tic-toc): %f \n",t3);

tic()
result_drums = convolution_signals(drums, fir)
t4 = toc();
savewave(save_path + 'drums.wav', result_drums, 44100)
printf("Time for drums convolution (tic-toc): %f \n",t4);
figure(1)
plot(result_drums)
tic()
y = convolution_signals(user_track(1,:), fir)
t5 = toc()
wavwrite(y, fs1, save_path + 'BUILTIN_user.wav')
printf("Time for userTrack builtIn convolution (tic-toc): %f \n",t5);

printf('\n')




// Block for Loading and Convolution with builtIn convol():
tic()
y = convol(voice, fir)

t1_builtIn = toc()
savewave(save_path + 'BUILTIN_voice.wav', y, 44100)
printf("Time for voice builtIn convolution (tic-toc): %f \n",t1_builtIn);

tic()
y = convol(speech, fir)
t3_builtIn = toc()
savewave(save_path + 'BUILTIN_speech.wav', y, 44100)
printf("Time for speech builtIn convolution (tic-toc): %f \n",t3_builtIn);

tic()
y = convol(violin, fir)
t4_builtIn = toc()
savewave(save_path + 'BUILTIN_violin.wav', y, 44100)
printf("Time for violin builtIn convolution (tic-toc): %f \n",t3_builtIn);


tic()
y = convol(drums, fir)
t2_builtIn = toc()
savewave(save_path + 'BUILTIN_drums.wav', y, 44100)
printf("Time for drums builtIn convolution (tic-toc): %f \n",t2_builtIn);
figure(2)
plot(y)

tic()
y = convol(user_track(1,:), fir)
t5_builtIn = toc()
wavwrite(y, fs1, save_path + 'BUILTIN_user.wav')
printf("Time for userTrack builtIn convolution (tic-toc): %f \n",t5_builtIn);

