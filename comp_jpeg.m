function comp_jpeg(target_output)
 
%imgGray openfile fonksiyonumla aldýðým görsel, filename de onun tam yolu+adý
global imgGray;
global FileName;
 
%imfinfo fonksiyonu yolunu+adýný+uzantýsýný verdiðimiz görselin bilgilerini alýr
%info.FileSize diyerek de byte cinsinden boyutuna eriþebiliriz. bunu 1024'e
%bölersek de kb cinsinden deðerini elde ederiz.
infoUncompressed =amp;nbsp;imfinfo(FileName);
tFileSize1 = (infoUncompressed.FileSize/1024);
 
%görselin boyutunu alýp 2 elemanlý tek boyutlu bir matrise atýyorum
[h,w] = size(imgGray);
 
% yüzde 50 sýkýþtýrma özelliðine sahip matrisimiz
matQuality=[...
 16 11 10 16 24 40 51 61
 12 12 14 19 26 58 60 55
 14 13 16 24 40 57 69 56
 14 17 22 29 51 87 80 62
 18 22 37 56 68 109 103 77
 24 35 55 64 81 104 113 92
 49 64 78 87 103 121 120 101
 72 92 95 98 112 100 103 99];
 
% görselin kopyasýný alýp onun üzerinde çalýþalým istedim.
%ve görseli double'a çevirdik
imgCopy = double(imgGray);
% bu adým önemli. matrisin her bir elemanýnda 128 çýkarmamýz gerekiyor ki
% quantization iþlemi sonucu çýkan deðerlerimiz absürd bir aralýkta olmasýn
imgCopy = imgCopy-128;
% 8x8 boyutunda geçici matris oluþturduk. bunu görselimizdeki bloklarýn
% yerini tutmasý için kullanacaðýz.
temp = zeros(8,8);
% geldik esas meselenin döndüðü yere. kelime oyunlu cin þaka time.
% "for i=1:8:h", i deðerini 1 den baþlat (matlab'da 0 dan baþlamaz)
% sekizer sekizer h deðerine gelene kadar arttýr anlamýna gelir.
% bu sayede görselimizi sekizer bloklar halinde gezebiliyoruz.
for i=1:8:h
 for j=1:8:w
% geçici matrisimize görselimizdeki 8x8 bloðu aldýk. dct'den geçirdik.
% quality matrisimize böldük. görselimizdeki o bölgeye geri geçici matrisi
% entegre ettik. en son da görselimizdeki deðerleri round ile tamsayý yaptýk.
 temp = imgCopy(i:i+7, j:j+7);
 temp = dct2(temp);
 temp = temp ./ matQuality;
 imgCopy(i:i+7, j:j+7) = temp;
 end
end
imgCopy = round(imgCopy);
 
% yine geçici matrise bloðu aldýk. quality matrisi ile çarptýk.
% bu sefer inverse dct yaptýk. 128 ekledik deðerlere. görselimizin
% ilgili bloðuna geçici matrisi yabýþtýrdýk.
for i=1:8:h
 for j=1:8:w
 temp = imgCopy(i:i+7, j:j+7);
 temp = temp .* matQuality;
 temp = idct2(temp);
 temp = temp + 128;
 imgCopy(i:i+7, j:j+7) = temp;
 end
end
 
% imwrite fonksiyonu bir matrisi resim olarak kaydetmemizi saðlar.
% iki parametre alýr. ilk parametre görselimiz, ikinci dosya adý+uzantýsýdýr.
imwrite(imgCopy, 'img.jpg');
 
% benim gui'mde axis var o yüzden görselimi orada gösteriyorum. isterseniz
% onu silip figure ekleyebilirsiniz.
axes(target_output);
imshow(imgCopy);
 
% son yazdýðýmýz görselin bilgilerini teee en baþtaki gibi alýyoruz.
infoCompressedImage = imfinfo('img.jpg');
tFileSize2 = infoCompressedImage.FileSize/1024;

end