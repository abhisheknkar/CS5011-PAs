function [ in, mu, sigma ] = stdnormarlize( in )
    mu = mean(in,1);
    sigma = std(in,1);
    in = (in - repmat(mu,size(in,1),1)) ./ repmat(sigma,size(in,1),1);
end