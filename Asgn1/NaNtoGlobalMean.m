function cleaned = NaNtoGlobalMean( in )
% Replaces the occurrences of NaN in a vector with the global mean amongst
% the non-NaN values in that vector
    cleaned = in;
    whereNaN = find(isnan(cleaned)==1);
    whereaN = find(isnan(cleaned)==0);
    cleaned(whereNaN) = mean(cleaned(whereaN));
end

