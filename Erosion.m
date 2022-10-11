function [asinmaCikisDegeri] = Erosion(image)
image = im2bw(image);
structMatris = ones(3); %butun elemanlari bir olan yapi elemani
   [x, y]  = size(image);
    for i=2: x-1
        for j=2: y-1
            asinmaCikisDegeri(i,j) = 1;
            temp = image(i-1:i+1,j-1:j+1);
            %ve islemi
            result = structMatris & temp;
            if min(min(result))==0
                asinmaCikisDegeri(i,j) = 0;
            end
        end
    end
end