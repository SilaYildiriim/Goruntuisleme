function [esikSonucu] = convert2binary(img)  

    [x, y, z]=size(img); 
    if z==3 
         img = GrayCevir(img);
    end     
    img=double(img); 
    sum=0;    
    for i=1:x 
         for j=1:y 
            sum=sum+img(i, j); 
        end
    end   
    esik=sum/(x*y); 
    esikSonucu=zeros(x, y);    
    for i=1:x 
     for j=1:y 
        if img(i, j) >= esik 
                esikSonucu(i, j) = 1; 
        else
            esikSonucu(i, j)=0; 
        end
     end
    end
    
end