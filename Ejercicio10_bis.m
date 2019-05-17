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
load fo;
load tfo tfo;

fono_a1=audio(0.86/T:0.96/T);
fono_l=audio(0.96/T:1.13/T); 
%Busco los tiempos en los que la fo n es nula
tiempos=[0.86 1.125;1.30 1.575;1.69 1.83;2.005 2.098;2.11 2.47;2.54 2.72;2.81 3.216;3.35 3.48;3.605 3.72];
save tiempos;
sordos=[t(1) 0.86;1.125 1.301;1.5749 1.691;1.829 2.0051;2.0979 2.111; 2.469 2.541; 2.719 2.811;3.1259 3.351;3.479 3.606;3.719 4.088];
save sordos;
sordo1=audio(sordos(1,1)/T:sordos(1,2)/T);
sordo2=audio(sordos(2,1)/T:sordos(2,2)/T);
sordo3=audio(sordos(3,1)/T:sordos(3,2)/T);
sordo4=audio(sordos(4,1)/T:sordos(4,2)/T);
sordo5=audio(sordos(5,1)/T:sordos(5,2)/T);
sordo6=audio(sordos(6,1)/T:sordos(6,2)/T);
sordo7=audio(sordos(7,1)/T:sordos(7,2)/T);
sordo8=audio(sordos(8,1)/T:sordos(8,2)/T);
sordo9=audio(sordos(9,1)/T:sordos(9,2)/T);
sordo10=audio(sordos(10,1)/T:sordos(10,2)/T);
periodo=zeros(1,length(tiempos));
for i=1:length(tiempos)
    periodo(i)=1/max(fo(tfo>=tiempos(i,1) & tfo<=tiempos(i,2)));
    if(periodo(i)>0.01)
        periodo(i)=0.0099;
    end
end
alturas_segmentos=[0.1;0.2;0.1;0.25;0.15;0.06;0.05;0.15;0.03];
min_periodos=min(periodo);
periodo_min=min_periodos*ones(length(periodo));
periodo_min(2)=0.0015;
%Busco los picos
cant_picos_por_segmento=zeros(length(tiempos),1);
[picos,loc_picos] = findpeaks(audio(t>=tiempos(1,1) & t<=tiempos(1,2)),f,'MinPeakDistance',0.004,'MinPeakHeight',0.2);
loc_picos=loc_picos+tiempos(1,1);
cant_picos_por_segmento(1)=length(picos);
for i=2:length(tiempos)
    [pks,locs] = findpeaks(audio(t>=tiempos(i,1) & t<=tiempos(i,2)),f,'MinPeakDistance',periodo_min(i),'MinPeakHeight',alturas_segmentos(i));
    locs=locs+tiempos(i,1);
    cant_picos_por_segmento(i)=length(pks);
    picos=vertcat(picos,pks);
    loc_picos=vertcat(loc_picos,locs);
end
save cant_picos_por_segmento;
save loc_picos;

figure (1)
plot(t,audio,t(floor(loc_picos/T)),picos,'or');
for i=1:length(tiempos)-1
    line([tiempos(i,1) tiempos(i,1)],[0 0.6],'Color','k');
    line([tiempos(i,2) tiempos(i,2)],[0 0.6],'Color','k');
    line([tiempos(i,2) tiempos(i+1,1)],[0 0],'Color','k');
end

figure (2)
plot(tfo,fo);
for i=1:length(tiempos)-1
    line([tiempos(i) tiempos(i)],[0 400],'Color','k');
    line([tiempos(i+1) tiempos(i+1)],[0 400],'Color','k');
end

porcentaje_solap=0.2;
ancho_ventana=0.0057;
segmento1=psola(audio,T,0.0057,1,cant_picos_por_segmento,loc_picos,1,porcentaje_solap);
segmento2=psola(audio,T,0.00286,2,cant_picos_por_segmento,loc_picos,43,porcentaje_solap);
segmento3=psola(audio,T,periodo(3),3,cant_picos_por_segmento,loc_picos,121,porcentaje_solap);
segmento4=psola(audio,T,periodo(4),4,cant_picos_por_segmento,loc_picos,155,porcentaje_solap);
segmento5=psola(audio,T,periodo(5),5,cant_picos_por_segmento,loc_picos,179,porcentaje_solap);
segmento6=psola(audio,T,periodo(6),6,cant_picos_por_segmento,loc_picos,235,porcentaje_solap);
segmento7=psola(audio,T,periodo(7),7,cant_picos_por_segmento,loc_picos,262,porcentaje_solap);
segmento8=psola(audio,T,periodo(8),8,cant_picos_por_segmento,loc_picos,333,porcentaje_solap);
segmento9=psola(audio,T,periodo(9),9,cant_picos_por_segmento,loc_picos,354,porcentaje_solap);
segmento1(65:100)=segmento1(65:100)/100;
segmento2(30:50)=segmento2(30:50)/100;
segmento3(30:55)=segmento3(30:55)/100;
segmento4(40:60)=segmento4(40:60)/100;
segmento5(65:85)=segmento5(65:85)/100;
segmento7(60:90)=segmento7(60:90)/100;
segmento8(80:90)=segmento8(80:90)/100;
sordo2(3030:length(sordo2))=sordo2(3030:length(sordo2))/100;
%segmento1(segmento1<0)=1.25*segmento1(segmento1<0);
%segmento2(segmento2<0)=3*segmento2(segmento2<0);
audio_modificado=[sordo1;segmento1;sordo2;segmento2;sordo3;segmento3;sordo4;segmento4;sordo5;segmento5;sordo6;segmento6;sordo7;segmento7;sordo8;segmento8;sordo9;segmento9;sordo10];
%audio_modificado=vertcat(sordo1,segmento1,sordo2,segmento2,sordo3,segmento3,sordo4,segmento4,sordo5,segmento5,sordo6,segmento6,sordo7,segmento7,sordo8,segmento8,sordo9,segmento9,sordo10);
sound(audio_modificado,f);
audiowrite('aumento_frecuencia.wav',audio_modificado,f);
tm=1:length(audio_modificado);
tm=tm*T;
plot(tm,audio_modificado);
xlim([0.7 3.7]);
print('audio_modificado.png','-dpng');
title('Señal con la frecuencia fundamental modificada');
xlabel('Tiempo [s]');
ylabel('Amplitud');
figure (3)
%subplot(2,1,1)
plot(t,audio);
%subplot(2,1,2);
hold on;
plot(tm,audio_modificado);
print('10_dos_audios.png','-dpng');
