function [outimage] = HistogramEsitleme(image)

    if (size(image, 3) >1 )
        image = GrayCevir(image);
    end
    
    sat = size (image, 1);
    sut =size (image, 2);
    histogram = zeros ([1 256]);
    cumulative_hist = zeros ([1 256]);
    
    for r = 1:sat
        for c = 1 : sut
            for count = 1:256
                if(image(r,  c) == count - 1)
                    histogram (count) = histogram (count) + 1;
                    break;
                end
            end
        end
    end
    
    current_value = 0;
    
    for count = 1 : 256
        current_value = current_value + histogram (count);
        cumulative_hist(count) = current_value;
    end
    
    normalized_hist = zeros ([1 256]);
    cdf_min = min (cumulative_hist) ;
    
    for count = 1:256
        normalized_hist(count) = cumulative_hist(count) - cdf_min;
        normalized_hist(count) = normalized_hist (count) / ((sat*sut) - cdf_min);
        normalized_hist(count) = round (normalized_hist (count) * 255);
    end
    
    equalized_image = zeros ([sat sut]);
    
    for r  =  1:sat
        for c=  1 : sut
            for count = 1:256
                if(image(r, c) == (count - 1))
                    equalized_image(r, c) = normalized_hist(count);
                    break;
                end
            end
        end
    end
    outimage = uint8(equalized_image);

end
