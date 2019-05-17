function [segmento] =aumento_vel_habla(audio,T,ancho_ventana,n_segmento,cant_picos_por_segmento,loc_picos,pico_inicial,porcentaje_aumento)
n_puntos=ancho_ventana/T;
ventana=hamming(n_puntos);
audio_ventaneado=[];
for i=pico_inicial:pico_inicial+cant_picos_por_segmento(n_segmento);
     ventaneo=ventana.*audio(loc_picos(i)/T-n_puntos/2:loc_picos(i)/T+(n_puntos-1)/2);
     audio_ventaneado=horzcat(audio_ventaneado,ventaneo);
end
[M N]=size(audio_ventaneado);
paso=floor(1/porcentaje_aumento);
n_picos_a_remover=floor(N/paso);
picos_a_remover=zeros(1,n_picos_a_remover);
for i=1:n_picos_a_remover
	picos_a_remover(i)=i*paso;
end
audio_ventaneado(:,picos_a_remover)=[];
[M N]=size(audio_ventaneado);
segmento=audio_ventaneado(:,1);
for i=1:N
   	segmento=vertcat(segmento,audio_ventaneado(:,i));
end
    