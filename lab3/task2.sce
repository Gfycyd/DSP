path = '/Users/katusha/lab2/dd'
b = chdir(path)

[x, fs] = wavread("data_hw3/Violin_Viola_Cello_Bass.wav")
lowpass_savepath = "results/lowpass_Violin_Viola_Cello_Bass.wav"
highpass_savepath = "results/highpass_Violin_Viola_Cello_Bass.wav"


// Low Pass
// y[n] = b0 * w[n] + b1 * w[n-1]...
// w[n] = x[n] + a1 * w[n-1] + a2 * w[n-2]...
// lowPassData = struct("a0": 1.9733442497812987,...)

a1 = [1.9733442497812987, -0.9736948719763]
b1 = [0.00008765554875401547, 0.00017531109750803094, 0.00008765554875401547]


w1 = []
lx = length(x)
for i = 1:lx
    wn = x(i)
    for j = 1:length(a1) 
        if (i - j < 1)
            break
        end
        wn = wn + (a1(j) * w1(i-j))
    end
    w1(i) = wn
end
    
y1 = []
lw = length(w1)
for i = 1:lw
    yn = 0
    for j = 1:length(b1)
        if (i - j < 0) 
            break
        end
        yn = yn + (b1(j) * w1(i-j+1))
    end

    y1(i) = yn
end  
wavwrite(y1, fs, lowpass_savepath)




// High Pass
// y[n] = b0 * w[n] + b1 * w[n-1]...
// w[n] = x[n] + a1 * w[n-1] + a2 * w[n-2]...

a2 = [-0.3769782747249014, -0.19680764477614976]
b2 = [0.40495734254626874, -0.8099146850925375, 0.4049573425462687]

w2 = []
lx = length(x)
for i = 1:lx
    wn = x(i)
    for j = 1:length(a2) 
        if (i - j < 1)
            break
        end
        wn = wn + (a2(j) * w2(i-j))
    end
    w2(i) = wn
end
    

y2 = []
lw = length(w2)
for i = 1:lw
        yn = 0
    for j = 1:length(b2)
        if (i - j < 0) 
            break
        end
        yn = yn + (b2(j) * w2(i-j+1))
    end

    y2(i) = yn

end  
wavwrite(y2, fs, highpass_savepath)



