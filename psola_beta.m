function [suma] =psola_beta(audio,T,fo,n_segmento,cant_picos_por_segmento,loc_picos,pico_inicial,porcentaje_solap)

n_puntos=ancho_ventana/T;
ventana=hamming(n_puntos);
audio_ventaneado=[];
for i=

for i=pico_inicial:pico_inicial+cant_picos_por_segmento(n_segmento);
    fopico=fo(t);
    ancho_ventana=1/fopico;
    n_puntos=ancho_ventana/T;
    ventana=hamming(n_puntos);
    ventaneo=ventana.*audio(loc_picos(i)/T-n_puntos/2:loc_picos(i)/T+(n_puntos-1)/2);
    audio_ventaneado=horzcat(audio_ventaneado,ventaneo);
end
suma=audio_ventaneado(:,1);
N=length(suma);
for i=1:cant_picos_por_segmento(n_segmento)-1;
    suma((1-porcentaje_solap)*N:N)=suma((1-porcentaje_solap)*N:N)+audio_ventaneado(1:porcentaje_solap*N+1,i+1);
    suma=vertcat(suma,audio_ventaneado(porcentaje_solap*N+1:N,i+1));
end