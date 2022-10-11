function [sobelCikisDeegeri] = SobelFonksiyon(inimage, filtreBoyutu)
    %Filtre boyutu

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
    sobelCikisDeegeri=double(zeros(row-filtreBoyutu-1,col-filtreBoyutu-1));    
    filtre1=[-1 -2 -1 ; 0 0 0; 1  2 1];
    filtre2=[-1 0 1 ; -2 0 2; -1 0 1];
    
    %Döngü ile filtreyi görüntü üzerinde gezdiriyoruz.
    for y=boyut2:row-boyut2
        for x=boyut2:col-boyut2
            komsu=inimage((y-boyut1):y+boyut1,x-boyut1:x+boyut1);
            %belirlenmiþ olan noktanýn filtre uygulandýktan sonraki yeni deðeri
            toplam1=0;
            toplam2=0;
            for m=1:filtreBoyutu
                for n=1:filtreBoyutu
                    toplam1=toplam1+filtre1(m,n)*komsu(m,n);
                end
            end
            for m=1:filtreBoyutu
                for n=1:filtreBoyutu
                    toplam2=toplam2+filtre2(m,n)*komsu(m,n);
                end
            end
            deger=power(toplam1,2)+power(toplam2,2);
            sobelCikisDeegeri(y-boyut1,x-boyut1)=sqrt(deger);
        end
    end
    
    %Çýktý resminin veri tipinin integer a dönüþtürülmesi
    sobelCikisDeegeri=uint8(sobelCikisDeegeri);

end


