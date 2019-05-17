close all;
k=1000;
ms=1000;
%6)MODELO DE ROSENBERG
fs=16*k;
Ts=1/fs;
Po=1;
fo1=200;
fo2=300;
%To=1/fo;
%Tn=0.16*To;
%Tp=0.4*To;
n_ciclos=200; %200 ciclos equivalen a 1 segundo
[P1,t_ros1]=rosenberg(fo2,fs,Po,0.16/fo2,0.4/fo2);

figure (1)
plot(t_ros1*ms,P1);
title('Un pulso glótico');
ylabel('Amplitud');
xlabel('t [ms]');
%print('periodo_pglotico','-dpng'); 
[P,t_ros]=generador_pulsos_f0_lineal(fo1,fo2,n_ciclos,fs,Po);
figure (1)
plot(t_ros,P);
title('Pulsos glóticos generados');
xlabel('Tiempo [s]');
ylabel('Amplitud');
axis([0 0.045 0 1]);
%print('pulsos_gloticos.png','-dpng');

dft_P=fft(P,10000);
f_ros=0:fs/(length(dft_P)-1):fs;
figure (2)
plot(f_ros-8000,1/length(dft_P)*fftshift(abs(dft_P)));
title('DFT de los pulsos glóticos');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_abs_pulsos_gloticos_12','-dpng');
figure (3)
plot(f_ros-8000,fftshift(phase(dft_P))*180/pi);
title('Fase de la DFT de los pulsos glóticos');
xlabel('Frecuencia [Hz]');
ylabel('Fase [°]');
print('dft_phase_pulsos_gloticos_12','-dpng');
%axis([0 8000 0 270]);
%}
%7)MODELO DE TRACTO VOCAL

Fs=16*k; %Frecuencia de muestreo???
n_formantes=5;
F1=[830 500 330 546 382];
B1=[110 80 70 97 74];
F2=[1400 2000 2765 934 740];
B2=[160 156 130 130 150];
F3=[2890 3130 3740 2966 2760];
B3=[210 190 178 185 210];
F4=[3930 4150 4366 3930 3380];
B4=[230 220 200 240 180];

p1=zeros(n_formantes,1);
p2=zeros(n_formantes,1);
p3=zeros(n_formantes,1);
p4=zeros(n_formantes,1);

for i=1:n_formantes
    p1(i)=exp(2*pi/Fs*(-B1(i)+1i*F1(i)));
    p2(i)=exp(2*pi/Fs*(-B2(i)+1i*F2(i)));
    p3(i)=exp(2*pi/Fs*(-B3(i)+1i*F3(i)));
    p4(i)=exp(2*pi/Fs*(-B4(i)+1i*F4(i)));
end
%En los vecores F,B y p la componentes 1 es para la vocal a, la 2 para la
%e, la 3 para la i, etc.
color={'rx','gx','mx','yx','bx'};
polos=horzcat(p1,p2,p3,p4);
polos=horzcat(polos,conj(polos));

z=tf('z',Ts);
Hn1a=1/((1-polos(1,1)/z)*(1-conj(polos(1,1))/z));
Hn2a=1/((1-polos(1,2)/z)*(1-conj(polos(1,2))/z));
Hn3a=1/((1-polos(1,3)/z)*(1-conj(polos(1,3))/z));
Hn4a=1/((1-polos(1,4)/z)*(1-conj(polos(1,4))/z));
a=Hn1a*Hn2a*Hn3a*Hn4a;
Hn1e=1/((1-polos(2,1)/z)*(1-conj(polos(2,1))/z));
Hn2e=1/((1-polos(2,2)/z)*(1-conj(polos(2,2))/z));
Hn3e=1/((1-polos(2,3)/z)*(1-conj(polos(2,3))/z));
Hn4e=1/((1-polos(2,4)/z)*(1-conj(polos(2,4))/z));
e=Hn1e*Hn2e*Hn3e*Hn4e;
Hn1i=1/((1-polos(3,1)/z)*(1-conj(polos(3,1))/z));
Hn2i=1/((1-polos(3,2)/z)*(1-conj(polos(3,2))/z));
Hn3i=1/((1-polos(3,3)/z)*(1-conj(polos(3,3))/z));
Hn4i=1/((1-polos(3,4)/z)*(1-conj(polos(3,4))/z));
i=Hn1i*Hn2i*Hn3i*Hn4i;
Hn1o=1/((1-polos(4,1)/z)*(1-conj(polos(4,1))/z));
Hn2o=1/((1-polos(4,2)/z)*(1-conj(polos(4,2))/z));
Hn3o=1/((1-polos(4,3)/z)*(1-conj(polos(4,3))/z));
Hn4o=1/((1-polos(4,4)/z)*(1-conj(polos(4,4))/z));
o=Hn1o*Hn2o*Hn3o*Hn4o;
Hn1u=1/((1-polos(5,1)/z)*(1-conj(polos(5,1))/z));
Hn2u=1/((1-polos(5,2)/z)*(1-conj(polos(5,2))/z));
Hn3u=1/((1-polos(5,3)/z)*(1-conj(polos(5,3))/z));
Hn4u=1/((1-polos(5,4)/z)*(1-conj(polos(5,4))/z));
u=Hn1u*Hn2u*Hn3u*Hn4u;

%8)SÍNTESIS DE VOCALES
ancho_ventana=500;
figure (6)
a_generada=lsim(a,P,t_ros);
a_generada=a_generada/max(a_generada);
ylabel('Amplitud');
title('Fono "a" generado');
sound(a_generada,fs);
audiowrite('a_generada_fo_lineal.wav',a_generada,fs);
pause(4);
%print('a_generada.png','-dpng');
figure (6)
e_generada=lsim(e,P,t_ros);
e_generada=e_generada/max(e_generada);
ylabel('Amplitud');
title('Fono "e" generado');
sound(e_generada,fs);
audiowrite('e_generada_fo_lineal.wav',e_generada,fs);
pause(4);
%print('e_generada.png','-dpng');
figure (6)
i_generada=lsim(i,P,t_ros);
i_generada=i_generada/max(i_generada);
ylabel('Amplitud');
title('Fono "i" generado');
audiowrite('i_generada_fo_lineal.wav',i_generada,fs);
sound(i_generada,fs);
pause(4);
%print('i_generada.png','-dpng');
figure (6)
o_generada=lsim(o,P,t_ros);
o_generada=o_generada/max(o_generada);
ylabel('Amplitud');
title('Fono "o" generado');
audiowrite('o_generada_fo_lineal.wav',o_generada,fs);
sound(o_generada,fs);
pause(4);
%print('o_generada.png','-dpng');
figure (6)
u_generada=lsim(u,P,t_ros);
u_generada=u_generada/max(u_generada);
ylabel('Amplitud');
title('Fono "u" generado');
audiowrite('u_generada_fo_lineal.wav',u_generada,fs);
sound(u_generada,fs);
pause(4);
%print('u_generada.png','-dpng');
vocales=[a_generada;e_generada;i_generada;o_generada;u_generada];
audiowrite('vocales_aumemto.wav',vocales,fs);

ancho_ventana_ceps=0.07;%antes 0.07
corrimiento=0.01;%antes 0.01

[ceps_a,foa,tfoa]=cepstrogram(a_generada,Ts,ancho_ventana_ceps,corrimiento);
x = [0 2.65];
y = [2 10];
image(x,y,ceps_a,'CDataMapping','scaled');
line([0 2.65],[5 5],'Color','k');
line([0 2.65],[3.333 3.333],'Color','k');
xlabel('Tiempo [s]');
ylabel('Quefrencia [ms]');
title('Diagrama tiempo-quefrencia "a" generada');
colorbar
print('tiempo_quefrencia_a_12.png','-dpng');

[ceps_e,foe,tfoe]=cepstrogram(e_generada,Ts,ancho_ventana_ceps,corrimiento);
x = [0 2.65];
y = [2 10];
image(x,y,ceps_e,'CDataMapping','scaled');
line([0 2.65],[5 5],'Color','k');
line([0 2.65],[3.333 3.333],'Color','k');
xlabel('Tiempo [s]');
ylabel('Quefrencia [ms]');
title('Diagrama tiempo-quefrencia "e" generada');
colorbar
print('tiempo_quefrencia_e_12.png','-dpng');

[ceps_i,foi,tfoi]=cepstrogram(i_generada,Ts,ancho_ventana_ceps,corrimiento);
x = [0 2.65];
y = [2 10];
image(x,y,ceps_i,'CDataMapping','scaled');
line([0 2.65],[5 5],'Color','k');
line([0 2.65],[3.333 3.333],'Color','k');
xlabel('Tiempo [s]');
ylabel('Quefrencia [ms]');
title('Diagrama tiempo-quefrencia "i" generada');
colorbar
print('tiempo_quefrencia_i_12.png','-dpng');

[ceps_o,foo,tfoo]=cepstrogram(o_generada,Ts,ancho_ventana_ceps,corrimiento);
x = [0 2.65];
y = [2 10];
image(x,y,ceps_o,'CDataMapping','scaled');
line([0 2.65],[5 5],'Color','k');
line([0 2.65],[3.333 3.333],'Color','k');
xlabel('Tiempo [s]');
ylabel('Quefrencia [ms]');
title('Diagrama tiempo-quefrencia "o" generada');
colorbar
print('tiempo_quefrencia_o_12.png','-dpng');

[ceps_u,fou,tfou]=cepstrogram(u_generada,Ts,ancho_ventana_ceps,corrimiento);
x = [0 2.65];
y = [2 10];
image(x,y,ceps_u,'CDataMapping','scaled');
line([0 2.65],[5 5],'Color','k');
line([0 2.65],[3.333 3.333],'Color','k');
xlabel('Tiempo [s]');
ylabel('Quefrencia [ms]');
title('Diagrama tiempo-quefrencia "u" generada');
colorbar
print('tiempo_quefrencia_u_12.png','-dpng');

figure (13)
%Espectrogramas
spectrogram(a_generada,ancho_ventana,300,max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal a
title('Espectrograma fono "a" generado');
print('spec_a_generada_12.png','-dpng');
spectrogram(e_generada,ancho_ventana,300,max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal e
title('Espectrograma fono "e" generado');
print('spec_e_generada_12.png','-dpng');
spectrogram(i_generada,ancho_ventana,300,max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal i
title('Espectrograma fono "i" generado');
print('spec_i_generada_12.png','-dpng');
spectrogram(o_generada,ancho_ventana,300,max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal o
title('Espectrograma fono "o" generado');
print('spec_o_generada_12.png','-dpng');
spectrogram(u_generada,ancho_ventana,300,max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal u
title('Espectrograma fono "u" generado');
print('spec_u_generada_12.png','-dpng');
%DFT
figure (6)
fvec=0:fs/(length(a_generada)-1):fs;
dft_agen=fft(a_generada);
dft_agen=dft_agen/length(dft_agen);
plot(fvec-8000,fftshift(abs(dft_agen)));
title('DFT fono "a" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_a_generada_12.png','-dpng');
dft_egen=fft(e_generada);
dft_egen=dft_egen/length(dft_egen);
plot(fvec-8000,fftshift(abs(dft_egen)));
title('DFT fono "e" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_e_generada_12.png','-dpng');
dft_igen=fft(i_generada);
dft_igen=dft_igen/length(dft_igen);
plot(fvec-8000,fftshift(abs(dft_igen)));
title('DFT fono "i" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_i_generada_12.png','-dpng');
dft_ogen=fft(o_generada);
dft_ogen=dft_ogen/length(dft_ogen);
plot(fvec-8000,fftshift(abs(dft_ogen)));
title('DFT fono "o" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_o_generada_12.png','-dpng');
dft_ugen=fft(u_generada);
dft_ugen=dft_ugen/length(dft_ugen);
plot(fvec-8000,fftshift(abs(dft_ugen)));
title('DFT fono "u" generado');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
print('dft_u_generada_12.png','-dpng');
%}