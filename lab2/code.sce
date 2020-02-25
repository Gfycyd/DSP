b = chdir('/Users/katusha/Downloads/lab2_v'); // put there your place with file
exec('ADC.sce');

n = 3;
fs = 96100; // norm w to hear 
quant_level = linspace(-0.5, 0.5, 500);
recorded_data = ADC(n, quant_level, fs) + 0.1;

sin_freq = 180; // sin noise frequency
sin_ampl = 0.1; // amplitude of sin noise

fs_new = size(recorded_data)(1);

step_size = sin_freq*(2*%pi)/fs_new;

samples = [1:fs_new]*step_size;
sin_sig = sin_ampl*sin(samples);


f = figure(1); // set fig number
clear //clear figure

plot(recorded_data - sin_sig');// plot data with o samples
gca.data_bounds = [0, -1;fs,1]; //x_limit 0..100 y_limit -2..2
xlabel('Samples');
ylabel('Amplitude');

playsnd(recorded_data, fs);
