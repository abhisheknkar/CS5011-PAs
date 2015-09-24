function [ in ] = stdnormarlize( in )
    in = (in - repmat(mean(in,1),size(in,1),1)) ./ repmat(std(in,1),size(in,1),1);
end

