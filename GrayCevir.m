function [griSeviye] = GrayCevir(inimage)

    %"Size" ile görüntünün boyut bilgilerinin alinmasi
    [satir,sutun,katman]=size(inimage);

    %Cikti resminin tanýmlanmasý
    griSeviye=zeros(satir,sutun);
    %Girdi resmi renkli bir görüntü ise (RGB,katman=3) ise
    % gri seviye resme dondurulmasi    
    if(katman==1)
        msgbox('Resim zaten gri seviye,tekrar gri seviye dönüþüm yapýlamaz.', 'Gri Resim', 'warn');
        griSeviye=inimage;
        return;
    else
        %Renkli görüntü 0.2989 * R + 0.5870 * G + 0.1140 * B oranlarýnda 
        %karýstýrýlarak gri seviye görüntü elde edilir.

        for m=1:satir
            for n=1:sutun
                griSeviye(m,n)=0.2989*inimage(m,n,1)...
                    +0.5870*inimage(m,n,2)...
                    +0.1140*inimage(m,n,3);
            end
        end
    end
    griSeviye = uint8(griSeviye);
end
