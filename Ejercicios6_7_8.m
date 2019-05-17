close all;
clear all;
k=1000;
ms=1000;
%6)MODELO DE ROSENBERG
fs=16*k;
Ts=1/fs;
Po=1;
fo=200;
To=1/fo;
Tn=0.16*To;
Tp=0.4*To;
n_ciclos=10; %Para poder escuchar las vocales generadas luego, se debe cambiar esto a 200 ciclos (1 segundo)1

t_ros1=Ts:Ts:To;
P1=zeros(length(t_ros1),1);
for i=1:length(t_ros1)
    ti=i*Ts;
    if ti<=Tp
        P1(i)=Po/2*(1-cos(ti/Tp*pi));
    end
    if ti<=Tp+Tn && Tp<ti
       P1(i)=Po*(cos((ti-Tp)/Tn*pi/2));
    end
end
P=P1;
figure (1)
plot(t_ros1*ms,P1);
title('Un pulso glótico');
ylabel('Amplitud');
xlabel('Tiempo [ms]');
print('periodo_pglotico','-dpng');
t_ros=Ts:Ts:n_ciclos*To;
for i=1:n_ciclos-1
    P=vertcat(P,P1);
end
figure (1)
plot(t_ros*ms,P);
title('Pulsos glóticos generados');
ylabel('Amplitud');
xlabel('Tiempo [ms]');
print('pulsos_gloticos.png','-dpng');

dft_P=fft(P,10000);
f_ros=0:fs/(length(dft_P)-1):fs;
figure (2)
plot(f_ros-8000,1/length(dft_P)*fftshift(abs(dft_P))); %Divido por length para normalizr los coeficientes de fourier
title('DFT de los pulsos glóticos');
ylabel('Amplitud DFT');
xlabel('Frecuencia [Hz]');
print('dft_abs_pulsos_gloticos','-dpng');
figure (3)
plot(f_ros-8000,fftshift(phase(dft_P))*180/pi);
title('Fase de la DFT de los pulsos glóticos');
ylabel('Fase DFT [°]');
xlabel('Frecuencia [Hz]');
print('dft_phase_pulsos_gloticos','-dpng');
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
ceros=zeros(8,1);
%a=zpk(ceros,polos(1,:),1,Ts);
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
%e=zpk(ceros,polos(2,:),1,Ts);
%i=zpk(ceros,polos(3,:),1,Ts);
%o=zpk(ceros,polos(4,:),1,Ts);
%u=zpk(ceros,polos(5,:),1,Ts);
figure (4)
pzplot(a,e,i,o,u);
legend('vocal a','vocal e','vocal i','vocal o','vocal u');
print('polosyceros.png','-dpng');
figure (5)
%[mag fase w]=bode(a,e,i,o,u);
%plot(mag);
delta=[1 zeros(1,1000)];
%rta_escalon_a=impulse(a);
%rta_escalon=filter(a,delta);
rta_escalon_a=lsim(a,delta);
atrans=fft(rta_escalon_a)/length(rta_escalon_a);

%atrans=atrans/length(atrans);
fa=fs/length(atrans):fs/length(atrans):fs;
fa=fa-8000;

rta_escalon_e=lsim(e,delta);
%rta_escalon_e=impulse(e);
etrans=fft(rta_escalon_e);
etrans=etrans/length(rta_escalon_e);
fe=fs/length(etrans):fs/length(etrans):fs;
fe=fe-8000;

%rta_escalon_i=impulse(i);
rta_escalon_i=lsim(i,delta);
itrans=fft(rta_escalon_i);
itrans=itrans/length(rta_escalon_i);
fi=fs/length(itrans):fs/length(itrans):fs;
fi=fi-8000;

%rta_escalon_o=impulse(o);
rta_escalon_o=lsim(o,delta);
otrans=fft(rta_escalon_o);
otrans=otrans/length(rta_escalon_o);
fo=fs/length(otrans):fs/length(otrans):fs;
fo=fo-8000;

%rta_escalon_u=impulse(u);
rta_escalon_u=lsim(u,delta);
utrans=fft(rta_escalon_u);
utrans=utrans/length(rta_escalon_u);
fu=fs/length(utrans):fs/length(utrans):fs;
fu=fu-8000;

plot(fa,fftshift(abs(atrans)));
hold on;
plot(fe,fftshift(abs(etrans)));
hold on;
plot(fi,fftshift(abs(itrans)));
hold on;
plot(fo,fftshift(abs(otrans)));
hold on;
plot(fu,fftshift(abs(utrans)));

legend('vocal a','vocal e','vocal i','vocal o','vocal u');
title('Respuesta en frecuencia de los sistemas del tracto vocal');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
print('transferencia.png','-dpng');

figure (5)
plot(fa,fftshift(abs(atrans)));
hold on;
plot(fe,fftshift(abs(etrans)));
hold on;
plot(fi,fftshift(abs(itrans)));
hold on;
plot(fo,fftshift(abs(otrans)));
hold on;
plot(fu,fftshift(abs(utrans)));

legend('vocal a','vocal e','vocal i','vocal o','vocal u');
title('Respuesta en frecuencia de los sistemas del tracto vocal');
xlabel('Frecuencia [Hz]');
ylabel('Amplitud');
xlim([0 8000]);
print('transferencia_bis.png','-dpng');

%8)SÍNTESIS DE VOCALES
ancho_ventana=500;
figure (6)
a_generada=lsim(a,P,t_ros);
ylabel('Amplitud');
xlabel('Tiempo [ms]');
title('Fono "a" generado');
a_generada=a_generada/max(a_generada);
plot(t_ros*ms,a_generada);
sound(a_generada,fs);
audiowrite('a_generada.wav',a_generada,fs);
pause(2);
print('a_generada.png','-dpng');
figure (6)
e_generada=lsim(e,P,t_ros);
e_generada=e_generada/max(e_generada);
plot(t_ros*ms,e_generada);
xlabel('Tiempo [ms]');
ylabel('Amplitud');
title('Fono "e" generado');
sound(e_generada,fs);
audiowrite('e_generada.wav',e_generada,fs);
pause(2);
print('e_generada.png','-dpng');
figure (6)
i_generada=lsim(i,P,t_ros);
i_generada=i_generada/max(i_generada);
plot(t_ros*ms,i_generada);
xlabel('Tiempo [ms]');
ylabel('Amplitud');
title('Fono "i" generado');
audiowrite('i_generada.wav',i_generada,fs);
sound(i_generada,fs);
pause(2);
print('i_generada.png','-dpng');
figure (6)
o_generada=lsim(o,P,t_ros);
o_generada=o_generada/max(o_generada);
plot(t_ros*ms,o_generada);
xlabel('Tiempo [ms]');
ylabel('Amplitud');
title('Fono "o" generado');
audiowrite('o_generada.wav',o_generada,fs);
sound(o_generada,fs);
pause(2);
print('o_generada.png','-dpng');
figure (6)
u_generada=lsim(u,P,t_ros);
u_generada=u_generada/max(u_generada);
plot(t_ros*ms,u_generada);
xlabel('Tiempo [ms]');
ylabel('Amplitud');
title('Fono "u" generado');
audiowrite('u_generada.wav',u_generada,fs);
sound(u_generada,fs);
pause(2);
print('u_generada.png','-dpng');
%{
save a_generada a_generada;
save e_generada e_generada;
save i_generada i_generada;
save o_generada o_generada;
save u_generada u_generada;
%}
vocales=[a_generada;e_generada;i_generada;o_generada;u_generada];
audiowrite('vocales.wav',vocales,fs);

figure (12)
cepstrum_a=cceps(a_generada);
plot(t_ros,cepstrum_a);
trng_a= t_ros(t_ros>=2e-3 & t_ros<=20e-3);
crng_a= cepstrum_a(t_ros>=2e-3 & t_ros<=20e-3);
[v,I] = max(crng_a);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_a(I))
hold on;
plot(trng_a(I),crng_a(I),'o');
title('Frecuencia fundamental fono "a" generado');
xlim([0.0025 0.02]);
ylim([-0.2 0.2]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Quefrencia[s]');
ylabel('real(C[n])');
text(trng_a(I),0.1,'f_{o}=197.53 Hz');
print('foa_gen.png','-dpng');

figure (13)
cepstrum_e=cceps(e_generada);
plot(t_ros,cepstrum_e);
trng_e= t_ros(t_ros>=2e-3 & t_ros<=20e-3);
crng_e= cepstrum_e(t_ros>=2e-3 & t_ros<=20e-3);
[v,I] = max(crng_e);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_e(I))
hold on;
plot(trng_e(I),crng_e(I),'o');
title('Frecuencia fundamental fono "e" generado');
xlim([0.0025 0.02]);
ylim([-0.2 0.2]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Quefrencia [s]');
ylabel('real(C[n])');
text(trng_e(I),0.1,'f_{o}=99.38 Hz');
print('foe_gen.png','-dpng');

figure (14)
cepstrum_i=cceps(i_generada);
plot(t_ros,cepstrum_i);
trng_i= t_ros(t_ros>=2e-3 & t_ros<=20e-3);
crng_i= cepstrum_i(t_ros>=2e-3 & t_ros<=20e-3);
[v,I] = max(crng_i);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_i(I))
hold on;
plot(trng_i(I),crng_i(I),'o');
title('Frecuencia fundamental fono "i" generado');
xlim([0.0025 0.02]);
ylim([-0.2 0.2]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Quefrencia [s]');
ylabel('real(C[n])');
text(trng_i(I),0.1,'f_{o}=197.53 Hz');
print('foi_gen.png','-dpng');

figure (15)
cepstrum_o=cceps(o_generada);
plot(t_ros,cepstrum_o);
trng_o= t_ros(t_ros>=2e-3 & t_ros<=20e-3);
crng_o= cepstrum_o(t_ros>=2e-3 & t_ros<=20e-3);
[v,I] = max(crng_o);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_o(I))
hold on;
plot(trng_o(I),crng_o(I),'o');
title('Frecuencia fundamental fono "o" generado');
xlim([0.0025 0.02]);
ylim([-0.2 0.2]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Quefrencia [s]');
ylabel('real(C[n])');
text(trng_o(I),0.1,'f_{o}=66.39 Hz');
print('foo_gen.png','-dpng');

figure (16)
cepstrum_u=cceps(u_generada);
plot(t_ros,cepstrum_u);
trng_u= t_ros(t_ros>=2e-3 & t_ros<=20e-3);
crng_u= cepstrum_u(t_ros>=2e-3 & t_ros<=20e-3);
[v,I] = max(crng_u);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_u(I))
hold on;
plot(trng_u(I),crng_u(I),'o');
title('Frecuencia fundamental fono "u" generado');
xlim([0.0025 0.02]);
ylim([-0.5 0.5]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Quefrencia [s]');
ylabel('real(C[n])');
text(trng_u(I),0.2,'f_{o}=200 Hz');
print('fou_gen.png','-dpng');

figure (17)
%Espectrogramas
spectrogram(a_generada,ancho_ventana,floor(length(a_generada)/2),max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal a
title('Espectrograma fono "a" generado');
print('spec_a_generada.png','-dpng');
spectrogram(e_generada,ancho_ventana,floor(length(e_generada)/2),max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal e
title('Espectrograma fono "e" generado');
print('spec_e_generada.png','-dpng');
spectrogram(i_generada,ancho_ventana,floor(length(i_generada)/2),max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal i
title('Espectrograma fono "i" generado');
print('spec_i_generada.png','-dpng');
spectrogram(o_generada,ancho_ventana,floor(length(o_generada)/2),max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal o
title('Espectrograma fono "o" generado');
print('spec_o_generada.png','-dpng');
spectrogram(u_generada,ancho_ventana,floor(length(u_generada)/2),max(256,2^nextpow2(ancho_ventana)),fs,'yaxis'); %vocal u
title('Espectrograma fono "u" generado');
print('spec_u_generada.png','-dpng');
%DFT
figure (6)
fvec=0:fs/(length(a_generada)-1):fs;
dft_agen=fft(a_generada);
dft_agen=dft_agen/length(dft_agen);
plot(fvec-8000,fftshift(abs(dft_agen)));
title('DFT fono "a" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_a_generada.png','-dpng');
dft_egen=fft(e_generada);
dft_egen=dft_egen/length(dft_egen);
plot(fvec-8000,fftshift(abs(dft_egen)));
title('DFT fono "e" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_e_generada.png','-dpng');
dft_igen=fft(i_generada);
dft_igen=dft_igen/length(dft_igen);
plot(fvec-8000,fftshift(abs(dft_igen)));
title('DFT fono "i" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_i_generada.png','-dpng');
dft_ogen=fft(o_generada);
dft_ogen=dft_ogen/length(dft_ogen);
plot(fvec-8000,fftshift(abs(dft_ogen)));
title('DFT fono "o" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_o_generada.png','-dpng');
dft_ugen=fft(u_generada);
dft_ugen=dft_ugen/length(dft_ugen);
plot(fvec-8000,fftshift(abs(dft_ugen)));
title('DFT fono "u" generado');
ylabel('Amplitud');
xlabel('Frecuencia [Hz]');
print('dft_u_generada.png','-dpng');

vocales=[a_generada,e_generada,i_generada,o_generada,u_generada];

