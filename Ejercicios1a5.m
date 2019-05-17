close all;
%clear all;
clc;
ms=1000;
grey=[0.5 0.5 0.5];
k=1000;
[audio,f]=audioread('hh2.wav');
f;
longitud=length(audio);
T=1/f;
t=1:1:longitud;

%1)GRAFICO DE LA SEÑAL
figure (1)
plot(t*T,audio);
axis([0.5 3.93 -0.7 0.6]);
title('Gráfica de la señal');
xlabel('Tiempo [s]');
ylabel('Amplitud');
%letra a
text(0.86,-0.63,'a','Color','r');
line([0.86 0.86],[-0.6 0.6],'Color','r','LineStyle',':');
line([0.96 0.96],[-0.6 0.6],'Color','r','LineStyle',':');
%letra l
text(0.96,-0.63,'l','Color','r');
line([0.96 0.96],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.13 1.13],[-0.6 0.6],'Color','r','LineStyle',':');
%letra s
text(1.13,-0.63,'s','Color','r');
line([1.13 1.13],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.3 1.3],[-0.6 0.6],'Color','r','LineStyle',':');
%letra o
text(1.3,-0.63,'o','Color','r');
line([1.3 1.3],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.39 1.39],[-0.6 0.6],'Color','k','LineStyle',':');
%letra l
text(1.39,-0.63,'l','Color','r');
line([1.39 1.39],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.47 1.47],[-0.6 0.6],'Color','r','LineStyle',':');
%letra a
text(1.47,-0.63,'a','Color','r');
line([1.47 1.47],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.57 1.57],[-0.6 0.6],'Color','r','LineStyle',':');
%letra v
text(1.57,-0.63,'b','Color','r');
line([1.57 1.57],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.69 1.69],[-0.6 0.6],'Color','r','LineStyle',':');
%letra o
text(1.69,-0.63,'o','Color','r');
line([1.69 1.69],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.83 1.83],[-0.6 0.6],'Color','r','LineStyle',':');
%letra Z
text(1.83,-0.63,'s','Color','r');
line([1.83 1.83],[-0.6 0.6],'Color','r','LineStyle',':');
line([1.88 1.88],[-0.6 0.6],'Color','r','LineStyle',':');
%letra p
text(1.88,-0.63,'p','Color','r');
line([1.88 1.88],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.01 2.01],[-0.6 0.6],'Color','r','LineStyle',':');
%letra a
text(2.01,-0.63,'a','Color','r');
line([2.01 2.01],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.09 2.09],[-0.6 0.6],'Color','r','LineStyle',':');
%letra r
text(2.09,-0.63,'r','Color','r');
line([2.09 2.09],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.12 2.12],[-0.6 0.6],'Color','r','LineStyle',':');
%letra a
text(2.12,-0.63,'a','Color','r');
line([2.12 2.12],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.29 2.29],[-0.6 0.6],'Color','r','LineStyle',':');
%letra a
text(2.29,-0.63,'a','Color','r');
line([2.29 2.29],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.36 2.36],[-0.6 0.6],'Color','r','LineStyle',':');
%letra u
text(2.36,-0.63,'u','Color','r');
line([2.36 2.36],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.46 2.46],[-0.6 0.6],'Color','r','LineStyle',':');
%letra x
text(2.46,-0.63,'x','Color','r');
line([2.46 2.46],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.54 2.54],[-0.6 0.6],'Color','r','LineStyle',':');
%letra e
text(2.54,-0.63,'e','Color','r');
line([2.54 2.54],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.63 2.63],[-0.6 0.6],'Color','r','LineStyle',':');
%letra n
text(2.63,-0.63,'n','Color','r');
line([2.63 2.63],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.75 2.75],[-0.6 0.6],'Color','r','LineStyle',':');
%letra t
text(2.79,-0.63,'t','Color','r');
line([2.79 2.79],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.81 2.81],[-0.6 0.6],'Color','r','LineStyle',':');
%letra a
text(2.81,-0.63,'a','Color','r');
line([2.81 2.81],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.93 2.93],[-0.6 0.6],'Color','r','LineStyle',':');
%letra r
text(2.93,-0.63,'r','Color','r');
line([2.93 2.93],[-0.6 0.6],'Color','r','LineStyle',':');
line([2.97 2.97],[-0.6 0.6],'Color','r','LineStyle',':');
%letra a
text(2.97,-0.63,'a','Color','r');
line([2.97 2.97],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.05 3.05],[-0.6 0.6],'Color','r','LineStyle',':');
%letra l
text(3.05,-0.63,'l','Color','r');
line([3.05 3.05],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.13 3.13],[-0.6 0.6],'Color','r','LineStyle',':');
%letra o
text(3.13,-0.63,'o','Color','r');
line([3.13 3.13],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.16 3.16],[-0.6 0.6],'Color','r','LineStyle',':');
%letra s
text(3.16,-0.63,'s','Color','r');
line([3.16 3.16],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.23 3.23],[-0.6 0.6],'Color','r','LineStyle',':');
%letra p
text(3.23,-0.63,'p','Color','r');
line([3.23 3.23],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.35 3.35],[-0.6 0.6],'Color','r','LineStyle',':');
%letra e
text(3.35,-0.63,'e','Color','r');
line([3.35 3.35],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.45 3.45],[-0.6 0.6],'Color','r','LineStyle',':');
%letra R
text(3.45,-0.63,'R','Color','r');
line([3.45 3.45],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.61 3.61],[-0.6 0.6],'Color','r','LineStyle',':');
%letra o
text(3.61,-0.63,'o','Color','r');
line([3.61 3.61],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.73 3.73],[-0.6 0.6],'Color','r','LineStyle',':');
%letra s
text(3.73,-0.63,'s','Color','r');
line([3.73 3.73],[-0.6 0.6],'Color','r','LineStyle',':');
line([3.88 3.88],[-0.6 0.6],'Color','r','LineStyle',':');

print('señal.png','-dpng');


%DFT de toda la señal
figure (2)
transf=fftshift(abs(fft(audio)));
N=(longitud-1);
fvec=-f/2+f/N:f/N:f/N+f/2;
plot(fvec,transf/length(transf));
title('DFT de toda la señal');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
axis([-8000 8000 0 0.008]);
print('dft_toda_señal.png','-dpng');
%2)LETRA A

figure (3)
a_period=audio(0.9113/T:0.9171/T); %Un período del fono "a"
ta_period=1:length(a_period);

plot(ta_period*T*ms,a_period);
xlabel('Tiempo [ms]');
ylabel('Amplitud');
axis([0 5.9 -0.4 0.4]);
title('Un período del fono "a"');
print('a_1periodo.png','-dpng');

figure (4)
transf=fftshift(abs(fft(a_period)));
f_vector=0:f/(length(a_period)-1):f;
plot(f_vector-8000,transf/length(transf));
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
title('DFT de un período del fono "a"');
print('dft_a.png','-dpng');

letra_a=audio(0.894/T:0.934/T); %Varios períodos del fono "a"
figure (5)
ta=1:length(letra_a);
ta=ta*T;
plot(ta*ms,letra_a);
xlabel('Tiempo [ms]');
ylabel('Amplitud');
axis([0 40 -0.5 0.4]);
title('Varios períodos del fono "a"');
print('fono_a.png','-dpng');

figure (6)
transf_a=fft(letra_a);
f_vector_muchos=0:f/(length(letra_a)-1):f;
plot(f_vector_muchos-8000,fftshift(abs(transf_a))/length(transf_a));
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
title('DFT de varios períodos del fono "a"');
print('dft_fono_a.png','-dpng');

%3)ANTI DFT
figure (7)
idft_a=ifft(transf_a);
plot(ta*ms,idft_a,'r');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
axis([0 40 -0.5 0.4]);
title('Reconstrucción del fono "a"');
print('reconstruccion_fono_a.png','-dpng');
sound(idft_a,f);%Se reproduce la letra a. No se notan diferencias


%4)GRABO LA MISMA FRASE DEL EJ 1
[audio_gonza,f_gonza]=audioread('hh2_gonzabis.wav');
T_gonza=1/f_gonza;
t_gonza=1:1:length(audio_gonza);
sound(audio_gonza,f_gonza);
ancho_ventana1=500;
ancho_ventana2=2500;
figure (8)
spectrogram(audio,ancho_ventana1,ancho_ventana1/2,max(256,2^nextpow2(ancho_ventana1)),f,'yaxis');
title('Espectrograma señal');
print('espectrograma_señal.png','-dpng');
figure (9)
spectrogram(audio_gonza(:,1),ancho_ventana2,ancho_ventana2/2,max(256,2^nextpow2(ancho_ventana2)),f_gonza,'yaxis');
ylim([0 8]);
title('Espectrograma señal grabada');
print('espectrograma_señal_grabada.png','-dpng');

%Grafico de las señales
figure (10)
plot(t*T,audio,'b'); %empieza en el segundo 0.85
hold on;
plot(t_gonza*T_gonza-0.10,audio_gonza,'r'); %empieza en el segundo 0.95
legend('Señal original','Señal grabada');
axis([0.5 4 -1.1 0.9]);
title('Gráfica de las señales');
xlabel('Tiempo [s]');
ylabel('Amplitud');
print('señal_grabada.png','-dpng');

%5)ESPECTROGRAMAS

figure (1)
ancho_ventana=400; %Se tomó el máximo ancho posible
spectrogram(letra_a,ancho_ventana,floor(length(letra_a)/2),max(256,2^nextpow2(ancho_ventana)),f,'yaxis'); %Letra a
%Los parámetros 3 y 4 de spectrogram son la cant de overlap y los puntos de
%dla dft. Esas fórmulas calculan los valores por default.
title('Vocal "a"');
print('spec_a.png','-dpng');
figure (2)
vocal_o=audio(1.698/T:1.777/T);
ancho_ventana=700;
spectrogram(vocal_o,ancho_ventana,floor(length(vocal_o)/2),max(256,2^nextpow2(ancho_ventana)),f,'yaxis'); %Letra o
title('Vocal "o"');
print('spec_o.png','-dpng');
figure (3)
ancho_ventana=600;
vocal_e=audio(3.352/T:3.46/T);%(3.352/T:3.46/T)
spectrogram(vocal_e,ancho_ventana,ancho_ventana/2,max(256,2^nextpow2(ancho_ventana)),f,'yaxis'); %Letra e
title('Vocal "e"');
print('spec_e.png','-dpng');

%9)ESTIMACIÓN DE LA FRECUENCIA FUNDAMENTAL

%Frecuencia fundamental letra a
figure (12)
cepstrum_a=cceps(letra_a);
plot(ta,cepstrum_a);
trng_a= ta(ta>=2e-3 & ta<=20e-3);
crng_a= cepstrum_a(ta>=2e-3 & ta<=20e-3);
[v,I] = max(crng_a);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_a(I))
hold on;
plot(trng_a(I),crng_a(I),'o');
title('Cepstrum fono "a"');
axis([0 0.04 -6 8]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Tiempo [s]');
ylabel('C[n]');
text(0.007,1,'f_{o}=175.82 Hz');
print('foa.png','-dpng');

%Frecuencia fundamental letra o
figure (13)
letra_o=audio(3.61/T:3.73/T);
to=1:1:length(letra_o);
to=to*T;
cepstrum_o=cceps(letra_o);
plot(to,cepstrum_o);
trng_o= to(to>=2e-3 & to<=20e-3);
crng_o= cepstrum_o(to>=2e-3 & to<=20e-3);
[v,I] = max(crng_o);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_a(I))
hold on;
plot(trng_o(I),crng_o(I),'o');
title('Cepstrum fono "o"');
axis([0 0.04 -10 11]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Tiempo [s]');
ylabel('C[n]');
text(0.007,1,'f_{o}=130.08 Hz');
print('foo.png','-dpng');
