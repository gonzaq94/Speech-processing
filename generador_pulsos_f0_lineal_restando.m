function [P,t_ros] = generador_pulsos_f0_lineal_restando(fo1,fo2,n_ciclos,fs,Po)
paso=(fo2-fo1)/(n_ciclos-1);
 To=1/fo1;
 Tn=0.16*To;
 Tp=0.4*To;
[P,t_ros]=rosenberg(fo1,fs,Po,Tn,Tp);
for i=1:n_ciclos-1
    fo=fo2-paso*i;
    To=1/fo;
    Tn=0.16*To;
    Tp=0.4*To;
    [Paux,t_rosaux]=rosenberg(fo,fs,Po,Tn,Tp);
    t_rosaux=t_rosaux+t_ros(length(t_ros));
    P=vertcat(P,Paux);
    t_ros=horzcat(t_ros,t_rosaux);
end