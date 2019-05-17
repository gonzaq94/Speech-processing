close all;
clear all;
%fdatool;
%[fono_a f]=audioread('a_generada_larga.wav');
f=16000;
T=1/f;
ms=1000;
load a_generada;
load e_generada;
load i_generada;
load o_generada;
load u_generada;
load Filtroa2;
load filtro_final;

%Fono a
ta=1:length(a_generada);
ta=ta*T;
N=(length(a_generada)-1);
fa=-f/2+f/N:f/N:f/N+f/2;

spec_a=fft(a_generada);
spec_a=spec_a/length(spec_a);
a_filtrada=filter(filtro_final,a_generada);

spec_a_filtrada=fft(a_filtrada);
spec_a_filtrada=spec_a_filtrada/length(spec_a_filtrada);
figure (1)
subplot(1,2,1);
plot(fa,abs(fftshift(spec_a)));
title('DFT fono "a"');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
subplot(1,2,2);
%axis([-8000 8000 0 6]);
plot(fa,abs(fftshift(spec_a_filtrada)));
title('DFT fono "a" filtrado');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
%axis([-8000 8000 0 6]);
print('dft_a_filtrada.png','-dpng');
%maximo=max(a_generada);
%a_generada=a_generada/maximo;
%maximo=max(a_filtrada);
%a_filtrada=a_filtrada/maximo;
figure (2)
subplot(1,2,1);
plot(ta*ms,a_generada);
title('Fono "a"');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
xlim([0 10]);
%axis([0 10 -15 20]);
subplot(1,2,2);
plot(ta*ms,a_filtrada);
title('Fono "a" filtrado');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
%axis([350 360 -15 20]);
xlim([350 360]);
print('a_filtrada.png','-dpng');
maximo=max(a_generada);
a_generada=a_generada/maximo;
sound(a_generada,f);
pause(2);
sound(a_filtrada,f);
audiowrite('a_filtrada.wav',a_filtrada,f);

%Fono e
te=1:length(e_generada);
te=te*T;
N=(length(e_generada)-1);
fe=-f/2+f/N:f/N:f/N+f/2;
spec_e=fft(e_generada);
spec_e=spec_e/length(spec_e);
e_filtrada=filter(filtro_final,e_generada);

spec_e_filtrada=fft(e_filtrada);
spec_e_filtrada=spec_e_filtrada/length(spec_e_filtrada);
figure (3)
subplot(1,2,1);
plot(fe,abs(fftshift(spec_e)));
title('DFT fono "e"');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
subplot(1,2,2);
%axis([-8000 8000 0 6]);
plot(fe,abs(fftshift(spec_e_filtrada)));
title('DFT fono "a" filtrado');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
%axis([-8000 8000 0 6]);
print('dft_e_filtrada.png','-dpng');

figure (4)
subplot(1,2,1);
plot(te*ms,e_generada);
title('Fono "e"');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
xlim([0 10]);
%axis([0 10 -15 20]);
subplot(1,2,2);
plot(te*ms,e_filtrada);
title('Fono "e" filtrado');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
%axis([350 360 -15 20]);
xlim([350 360]);
print('e_filtrada.png','-dpng');
maximo=max(e_generada);
e_generada=e_generada/maximo;
sound(e_generada,f);
pause(2);
sound(e_filtrada,f);
audiowrite('e_filtrada.wav',a_filtrada,f);

%Fono i
ti=1:length(i_generada);
ti=ti*T;
N=(length(i_generada)-1);
fi=-f/2+f/N:f/N:f/N+f/2;
spec_i=fft(i_generada);
spec_i=spec_i/length(spec_i);
i_filtrada=filter(filtro_final,i_generada);

spec_i_filtrada=fft(i_filtrada);
spec_i_filtrada=spec_i_filtrada/length(spec_i_filtrada);
figure (5)
subplot(1,2,1);
plot(fi,abs(fftshift(spec_i)));
title('DFT fono "i"');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
subplot(1,2,2);
%axis([-8000 8000 0 6]);
plot(fi,abs(fftshift(spec_i_filtrada)));
title('DFT fono "i" filtrado');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
%axis([-8000 8000 0 6]);
print('dft_i_filtrada.png','-dpng');

figure (6)
subplot(1,2,1);
plot(ti*ms,i_generada);
title('Fono "i"');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
xlim([0 10]);
%axis([0 10 -15 20]);
subplot(1,2,2);
plot(ti*ms,i_filtrada);
title('Fono "i" filtrado');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
%axis([350 360 -15 20]);
xlim([350 360]);
print('i_filtrada.png','-dpng');
maximo=max(i_generada);
i_generada=i_generada/maximo;
sound(i_generada,f);
pause(2);
sound(i_filtrada,f);
audiowrite('i_filtrada.wav',i_filtrada,f);

%Fono o
to=1:length(o_generada);
to=to*T;
N=(length(o_generada)-1);
fo=-f/2+f/N:f/N:f/N+f/2;
spec_o=fft(o_generada);
spec_o=spec_o/length(spec_o);
o_filtrada=filter(filtro_final,o_generada);

spec_o_filtrada=fft(o_filtrada);
spec_o_filtrada=spec_o_filtrada/length(spec_o_filtrada);
figure (7)
subplot(1,2,1);
plot(fo,abs(fftshift(spec_o)));
title('DFT fono "o"');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
subplot(1,2,2);
%axis([-8000 8000 0 6]);
plot(fo,abs(fftshift(spec_o_filtrada)));
title('DFT fono "o" filtrado');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
%axis([-8000 8000 0 6]);
print('dft_o_filtrada.png','-dpng');

figure (8)
subplot(1,2,1);
plot(to*ms,o_generada);
title('Fono "o"');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
xlim([0 10]);
%axis([0 10 -15 20]);
subplot(1,2,2);
plot(to*ms,o_filtrada);
title('Fono "o" filtrado');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
%axis([350 360 -15 20]);
xlim([350 360]);
print('o_filtrada.png','-dpng');
maximo=max(o_generada);
o_generada=o_generada/maximo;
sound(o_generada,f);
pause(2);
sound(o_filtrada,f);
audiowrite('o_filtrada.wav',o_filtrada,f);

%Fono u
tu=1:length(u_generada);
tu=tu*T;
N=(length(u_generada)-1);
fu=-f/2+f/N:f/N:f/N+f/2;
spec_u=fft(u_generada);
spec_u=spec_u/length(spec_u);
u_filtrada=filter(filtro_final,u_generada);

spec_u_filtrada=fft(u_filtrada);
spec_u_filtrada=spec_u_filtrada/length(spec_u_filtrada);
figure (9)
subplot(1,2,1);
plot(fu,abs(fftshift(spec_u)));
title('DFT fono "u"');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
subplot(1,2,2);
%axis([-8000 8000 0 6]);
plot(fu,abs(fftshift(spec_u_filtrada)));
title('DFT fono "u" filtrado');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
%axis([-8000 8000 0 6]);
print('dft_u_filtrada.png','-dpng');

figure (10)
subplot(1,2,1);
plot(tu*ms,u_generada);
title('Fono "u"');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
xlim([0 10]);
%axis([0 10 -15 20]);
subplot(1,2,2);
plot(tu*ms,u_filtrada);
title('Fono "u" filtrado');
xlabel('Tiempo [ms]');
ylabel('Amplitud');
%axis([350 360 -15 20]);
xlim([350 360]);
print('u_filtrada.png','-dpng');
maximo=max(u_generada);
u_generada=u_generada/maximo;
sound(u_generada,f);
pause(2);
sound(u_filtrada,f);
audiowrite('u_filtrada.wav',u_filtrada,f);

%Filtro

delta=[1 zeros(1,1000000)];
rta_delta=filter(filtro_final,delta);

rta_f=fft(rta_delta);
rta_f=rta_f/length(rta_f);
fvec=f/length(rta_f):f/length(rta_f):f;
fvec=fvec-8000;

figure (11)

subplot(2,1,1)
semilogx(fvec,20*log(fftshift(abs(rta_f))));
xlim([0.01 5000]);
title('Módulo de la función transferencia del filtro');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud (dB)');
grid on;
subplot(2,1,2)
semilogx(fvec,fftshift(angle(rta_f)));
xlim([0.01 5000]);
title('Fase de la función transferencia del filtro');
xlabel('Frecuencia [Hz]');
ylabel('Fase (rad)');
grid on;
print('filtro_generado.png','-dpng');