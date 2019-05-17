%9)ESTIMACIÓN DE LA FRECUENCIA FUNDAMENTAL
close all;
clear all;
ms=1000;
grey=[0.5 0.5 0.5];
k=1000;
[audio,f]=audioread('hh2.wav');
longitud=length(audio);
T=1/f;
t=1:1:longitud;
%Frecuencia fundamental letra a
figure (12)
letra_a=audio(0.894/T:0.934/T); %Varios períodos del fono "a"
ta=1:length(letra_a);
ta=ta*T;
cepstrum_a=rceps(letra_a);
plot(ta,cepstrum_a);
trng_a= ta(ta>=2e-3 & ta<=20e-3);
crng_a= cepstrum_a(ta>=2e-3 & ta<=20e-3);
[v,I] = max(crng_a);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_a(I))
hold on;
plot(trng_a(I),crng_a(I),'o');
title('Frecuencia fundamental vocal "a"');
axis([0 0.04 -6 8]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Quefrencia[s]');
ylabel('C([n]');
text(0.007,1,'f_{o}=175.82 Hz');
print('foa.png','-dpng');

%Frecuencia fundamental letra o
figure (17)
letra_o=audio(3.61/T:3.73/T);
to=1:1:length(letra_o);
to=to*T;
cepstrum_o=rceps(letra_o);
plot(to,cepstrum_o);
trng_o= to(to>=2e-3 & to<=20e-3);
crng_o= cepstrum_o(to>=2e-3 & to<=20e-3);
[v,I] = max(crng_o);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_a(I))
hold on;
plot(trng_o(I),crng_o(I),'o');
title('Frecuencia fundamental vocal "o"');
axis([0 0.04 -10 11]);
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
xlabel('Quefrencia [s]');
ylabel('C[n]');
text(0.007,1,'f_{o}=130.08 Hz');
print('foo.png','-dpng');
%Parte sin vocales
figure (13)
ruido=audio(0.1/T:0.5/T);
to=1:1:length(ruido);
to=to*T;
cepstrum_ruido=rceps(ruido);
plot(to,cepstrum_ruido);
trng_r= to(to>=2e-3 & to<=20e-3);
crng_r= cepstrum_ruido(to>=2e-3 & to<=20e-3);
[v,I] = max(crng_o);
fprintf('Complex cepstrum F0 estimate is %3.2f Hz.\n',1/trng_a(I))
hold on;
line([0.002 0.002],[-500 500],'Color','r','LineStyle',':');
line([0.02 0.02],[-500 500],'Color','r','LineStyle',':');
axis([0 0.05 -10 11]);
%cepstrogram(audio);
ancho_ventana=0.028;%antes 0.07
corrimiento=0.01;%antes 0.01
n_ventana=floor(ancho_ventana/T);
paso=floor(corrimiento/T);
t=t*T;
%letra_a=audio(i:0.934/T);
w=window(@hamming,n_ventana);
tcep=1:1:n_ventana;
tcep=tcep*T;
trng= tcep(tcep>=2e-3 & tcep<=20e-3);
fo=zeros(floor((length(audio)-length(w))/paso),1);
amp_max=zeros(length(fo),1);
audio_ventana=w.*audio(paso:paso+n_ventana-1);
cepstrum=rceps(audio_ventana);
cepstrograma=zeros(length(cepstrum(tcep>=2e-3 & tcep<=10e-3)),floor((length(audio)-length(w))/paso));
umbral=0.155; %Se define el umbral de amplitud que deben superar los maximos para ser considerados maximos validos en el calculo de fo

for i=paso:paso:length(audio)-length(w)
    
    audio_ventana=w.*audio(i:i+n_ventana-1);
    cepstrum=rceps(audio_ventana);
    crng=cepstrum(tcep>=2e-3 & tcep<=20e-3);
    crng_graph= cepstrum(tcep>=2e-3 & tcep<=10e-3);
    cepstrograma(:,i/paso)=crng_graph;
    [M,I] = max(crng);
    amp_max(i/paso)=M;
    fo(i/paso)=1/trng(I);
    if (M<umbral)   
    fo(i/paso)=0;
    end
end
figure (14)
tfo=corrimiento:corrimiento:corrimiento*length(fo);
subplot(2,1,1)
plot(t,audio);
xlim([0 4]);
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Gráfico de la señal');
subplot(2,1,2)
plot(tfo,fo,'Linewidth',1,'Color','r');
xlim([0 4]);
xlabel('Tiempo [s]');
ylabel('Frecuencia [Hz]');
title('Gráfico de la frecuencia fundamental en función del tiempo');
print('fo.png','-dpng');
save fo fo;
save tfo tfo;


figure (15)
x = [0 3.93];
y = [2 20];
image(x,y,cepstrograma,'CDataMapping','scaled');
xlabel('Tiempo [s]');
ylabel('Quefrencia [ms]');
title('Diagrama tiempo-quefrencia');
colorbar
print('tiempo_quefrencia.png','-dpng');

figure (16)
plot(tfo,amp_max);
xlabel('Tiempo [s]');
ylabel('Amplitud');
axis([0 4.1 0 0.7]);
line([0 4.1],[umbral umbral],'Color','k');
title('Amplitud del máximo en función del tiempo');
print('max_amp.png','-dpng');