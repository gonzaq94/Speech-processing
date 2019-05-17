function [cepstrograma,fo,tfo] = cepstrogram(senal,T,ancho_ventana,corrimiento)

n_ventana=floor(ancho_ventana/T);
paso=floor(corrimiento/T);
w=window(@hamming,n_ventana);
tcep=1:1:n_ventana;
tcep=tcep*T;
trng= tcep(tcep>=2e-3 & tcep<=20e-3);
fo=zeros(floor((length(senal)-length(w))/paso),1);

senal_ventana=w.*senal(paso:paso+n_ventana-1);
cepstrum=rceps(senal_ventana);
cepstrograma=zeros(length(cepstrum(tcep>=2e-3 & tcep<=10e-3)),floor((length(senal)-length(w))/paso));
for i=paso:paso:length(senal)-length(w)
    
    senal_ventana=w.*senal(i:i+n_ventana-1);
    cepstrum=rceps(senal_ventana);
    crng= cepstrum(tcep>=2e-3 & tcep<=20e-3);
    crng_graph= cepstrum(tcep>=2e-3 & tcep<=10e-3);
     cepstrograma(:,i/paso)=crng_graph;
    [v,I] = max(crng);
    fo(i/paso)=1/trng(I);
end
tfo=corrimiento:corrimiento:corrimiento*length(fo);