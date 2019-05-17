function [audio] =corrector(audio,valor_umbral)

for i=1:length(audio)
    if (audio(i)<valor_umbral)
        audio(i)=valor_umbral;
    end
end