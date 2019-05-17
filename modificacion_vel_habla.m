function [audio_modificado] =modificacion_vel_habla(audio,T,tiempos,sordos,cant_picos_por_segmento,loc_picos,porcentaje_aumento,periodo)

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

segmento1=aumento_vel_habla(audio,T,0.0057,1,cant_picos_por_segmento,loc_picos,1,porcentaje_aumento);
segmento2=aumento_vel_habla(audio,T,0.00286,2,cant_picos_por_segmento,loc_picos,43,porcentaje_aumento);
segmento3=aumento_vel_habla(audio,T,periodo(3),3,cant_picos_por_segmento,loc_picos,121,porcentaje_aumento);
segmento4=aumento_vel_habla(audio,T,periodo(4),4,cant_picos_por_segmento,loc_picos,155,porcentaje_aumento);
segmento5=aumento_vel_habla(audio,T,periodo(5),5,cant_picos_por_segmento,loc_picos,179,porcentaje_aumento);
segmento6=aumento_vel_habla(audio,T,periodo(6),6,cant_picos_por_segmento,loc_picos,235,porcentaje_aumento);
segmento7=aumento_vel_habla(audio,T,periodo(7),7,cant_picos_por_segmento,loc_picos,262,porcentaje_aumento);
segmento8=aumento_vel_habla(audio,T,periodo(8),8,cant_picos_por_segmento,loc_picos,333,porcentaje_aumento);
segmento9=aumento_vel_habla(audio,T,periodo(9),9,cant_picos_por_segmento,loc_picos,354,porcentaje_aumento);

audio_modificado=[sordo1;segmento1;sordo2;segmento2;sordo3;segmento3;sordo4;segmento4;sordo5;segmento5;sordo6;segmento6;sordo7;segmento7;sordo8;segmento8;sordo9;segmento9;sordo10];