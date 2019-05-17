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
t=t*T;
load tiempos;
load sordos;
load loc_picos;
load cant_picos_por_segmento;

audio_modificado1=modificacion_vel_habla(audio,T,tiempos,sordos,cant_picos_por_segmento,loc_picos,0.1,periodo);
audio_modificado2=modificacion_vel_habla(audio,T,tiempos,sordos,cant_picos_por_segmento,loc_picos,0.2,periodo);
audio_modificado3=modificacion_vel_habla(audio,T,tiempos,sordos,cant_picos_por_segmento,loc_picos,0.3,periodo);

sound(audio,f);
pause(3);
sound(audio_modificado1,f);
audiowrite('10%_mas_rapido.wav',audio_modificado1,f);
pause(3);
sound(audio_modificado2,f);
audiowrite('20%_mas_rapido.wav',audio_modificado2,f);
pause(3);
sound(audio_modificado3,f);
audiowrite('30%_mas_rapido.wav',audio_modificado3,f);

t=1:length(audio);
t=t*T;
t1=1:length(audio_modificado1);
t1=t1*T;
t2=1:length(audio_modificado2);
t2=t2*T;
t3=1:length(audio_modificado3);
t3=t3*T;
subplot(4,1,1);
plot(t,audio);
title('Audio original');
axis([0 4 -1 1]);
ylabel('Amplitud');
xlabel('Tiempo [s]');
subplot(4,1,2)
plot(t1,audio_modificado1);
title('Audio 10% más rápido');
axis([0 4 -1 1]);
ylabel('Amplitud');
xlabel('Tiempo [s]');
subplot(4,1,3)
plot(t2,audio_modificado2);
title('Audio 20% más rápido');
axis([0 4 -1 1]);
ylabel('Amplitud');
xlabel('Tiempo [s]');
subplot(4,1,4)
plot(t3,audio_modificado3);
axis([0 4 -1 1]);
ylabel('Amplitud');
xlabel('Tiempo [s]');
title('Audio 30% más rápido');

print('aumento_vel_habla.png','-dpng');
figure (2)
subplot(2,1,1)
plot(t1,audio_modificado1);
xlim([0.9 1]);
subplot(2,1,2)
plot(t,audio);
xlim([0.9 1]);