function [P1,t_ros1] = rosenberg(fo,fs,Po,Tn,Tp)
Ts=1/fs;
To=1/fo;
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