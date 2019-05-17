%EJERCICIO 10
%
close all;
[audio,f]=audioread('hh2.wav');
f;
longitud=length(audio);
T=1/f;
t=1:1:longitud;
t=t*T;
load fo;
load tfo tfo;
F0t= [175 188 335 330 175 151 272 264 160 182 160 176 130];
pts=zeros(length(F0t),1);
for k=1:length(F0t)
    pts(k)=ceil(f/F0t(k));
end
load cant_picos_por_segmento;
load loc_picos;
porcentaj_solap=0.1;
 
tiempos=[        0.86 0.976;
                    0.976 1.125;
                    
                    1.296 1.398;
                    1.398 1.466;
                    1.466 1.576;
                    1.576 1.689;                    
                    1.689 1.832;
                    
                    2.006 2.097;
                    
                    2.119 2.726;
                    
                    2.805 3.161;
                    3.161 3.217;
                    
                    3.347 3.472;
                    
                    3.607 3.735;]
                
sordo1=audio(1.125/T:1.296/T);
sordo2=audio(1.832/T:2.06/T);

%Busco los picos
alturas_segmentos=[0.16;0.111;0.1;0.2;0.12;0.02;0.095;0.12;0.08;0.06;0.05;0.15;0.03];
periodo_min(3)=0.002;
cant_picos_por_segmento=zeros(length(tiempos),1);
[picos,loc_picos] = findpeaks(audio(t>=tiempos(1,1) & t<=tiempos(1,2)),f,'MinPeakDistance',0.002,'MinPeakHeight',0.2);
loc_picos=loc_picos+tiempos(1,1);
cant_picos_por_segmento(1)=length(picos);
for i=2:length(tiempos)
    [pks,locs] = findpeaks(audio(t>=tiempos(i,1) & t<=tiempos(i,2)),f,'MinPeakDistance',periodo_min(i),'MinPeakHeight',alturas_segmentos(i));
    locs=locs+tiempos(i,1);
    cant_picos_por_segmento(i)=length(pks);
    picos=vertcat(picos,pks);
    loc_picos=vertcat(loc_picos,locs);
end

loc_picos=[;0.8772;loc_picos];
picos=[0.1602;picos];
cant_picos_por_segmento(1)=cant_picos_por_segmento(1)+1;

loc_picos=[loc_picos(1:142);1.691;loc_picos(143:end)];
picos=[picos(1:142);0.09207;picos(143:end)];
cant_picos_por_segmento(7)=cant_picos_por_segmento(7)+1;

loc_picos=[loc_picos(1:177);1.823;1.827;1.83;loc_picos(178:end)];
picos=[picos(1:177);0.0847;0.07147;0.06418;picos(178:end)];
cant_picos_por_segmento(7)=cant_picos_por_segmento(7)+3;


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

pico_inicial=zeros(1,length(cant_picos_por_segmento));
acumulado=1;
for i=1:length(cant_picos_por_segmento)
    pico_inicial(i)=acumulado;
    acumulado=acumulado+cant_picos_por_segmento(i);
end
    

  segmento1=psola(audio,T,pts(1)*T,1,cant_picos_por_segmento,loc_picos,pico_inicial(1),porcentaje_solap);
  segmento2=psola(audio,T,pts(2)*T,2,cant_picos_por_segmento,loc_picos,pico_inicial(2),porcentaje_solap);
  segmento3=psola(audio,T,pts(3)*T,3,cant_picos_por_segmento,loc_picos,pico_inicial(3),porcentaje_solap);
  segmento4=psola(audio,T,pts(4)*T,4,cant_picos_por_segmento,loc_picos,pico_inicial(4),porcentaje_solap);
  segmento5=psola(audio,T,pts(5)*T,5,cant_picos_por_segmento,loc_picos,pico_inicial(5),porcentaje_solap);
  segmento6=psola(audio,T,pts(6)*T,6,cant_picos_por_segmento,loc_picos,pico_inicial(6),porcentaje_solap);
  segmento7=psola(audio,T,pts(7)*T,7,cant_picos_por_segmento,loc_picos,pico_inicial(7),porcentaje_solap);
   audio_modificado=vertcat(segmento1,segmento2,sordo1,segmento3,segmento4,segmento5,segmento6,segmento7,sordo2);
   figure (3)
  subplot(2,1,1);
  plot(segmento1);
  subplot(2,1,2);
  plot(audio(0.8604/T:0.976/T));
  
   figure (4)
  subplot(2,1,1);
  plot(segmento2);
  subplot(2,1,2);
  plot(audio(0.976/T:1.125/T));
  %print('problema.png','-dpng');
 figure (5)
  subplot(2,1,1);
  plot(segmento7);
  subplot(2,1,2);
  plot(audio(1.689/T:1.832/T));
  %print('problema.png','-dpng');
  
  figure (6)
  subplot(2,1,1);
  plot(audio_modificado);
  ylim([-0.6 0.6]);
  subplot(2,1,2);
  plot(audio(0.8604/T:2.06/T));
 soundsc(audio_modificado,f);
 print('psola.png','-dpng');
 