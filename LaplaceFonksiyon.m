function [laplaceCikisDegeri] = LaplaceFonksiyon(inimage, filtreBoyutu)

    %Girdi resminin boyutlarýnýn alýnmasý
    [row,col,katman]=size(inimage);
    if(katman>1)
       inimage=GrayCevir(inimage);
    end
    
    %Sýnýr deðerleri için alýnan veriler
    boyut1=(filtreBoyutu-1)/2;
    boyut2=((filtreBoyutu-1)/2)+1;
    
    %Girdi resminin veri tipinin double'ye dönüþtürülmesi
    inimage=double(inimage);
    
    %Filtre uygulanýrken taþmalar olacaðýndan çýktý resmini tekrar
    %boyutlandýrýyoruz.
    laplaceCikisDegeri=double(zeros(row-filtreBoyutu-1,col-filtreBoyutu-1));    
    filtre=[1 1 1; 1 -8 1; 1 1 1];
    
    %Döngü ile filtreyi görüntü üzerinde gezdiriyoruz.
    for y=boyut2:row-boyut2
        for x=boyut2:col-boyut2
            komsu=inimage((y-boyut1):y+boyut1,x-boyut1:x+boyut1);
            %belirlenmiþ olan noktanýn filtre uygulandýktan sonraki yeni deðeri
            toplam=0;
            for m=1:filtreBoyutu
                for n=1:filtreBoyutu
                    toplam=toplam+filtre(m,n)*komsu(m,n);
                end
            end
            laplaceCikisDegeri(y-boyut1,x-boyut1)=toplam;
        end
    end
    
    %Çýktý resminin veri tipinin integer a dönüþtürülmesi
    laplaceCikisDegeri=uint8(laplaceCikisDegeri);
    
end


