function [gaussCikisDegeri] = GaussFonksiyon(image, sigma)

    [m, n, k] = size(image);    
    if(k==1)
        msgbox('Bu resimde dönüþüm saðlanamamaktadýr .. ', 'BÝLGÝLENDÝRME', 'warn');
    end
    
    I = GrayCevir(image);
    kernel = zeros(5,5);
    w=0;
    for i=1:5
        for j=1:5
            sq=(i-3)^2+(j-3)^2;
            kernel(i,j) = exp(-1*(sq)/(2*sigma*sigma));
            w=w+kernel(i,j);
        end
    end
    kernel = kernel/w;
    
    gaussCikisDegeri=zeros(m,n);
    Im = padarray(I, [2 2]);
    for i=1:m
        for j=1:n
            temp = Im(i:i+4, j:j+4);
            temp=double(temp);
            conv=temp.*kernel;
            gaussCikisDegeri(i,j)=sum(conv(:));
        end
    end
    gaussCikisDegeri=uint8(gaussCikisDegeri);

end
