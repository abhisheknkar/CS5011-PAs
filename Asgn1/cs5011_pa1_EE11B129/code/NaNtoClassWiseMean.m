function cleaned = NaNtoGlobalMean( X, Y, bincount )
% Replaces the occurrences of NaN in a vector with the class wise mean amongst
% the non-NaN values in that class
    Y = (Y - min(Y)) / max(Y);
    cleaned = X;
%     classes = unique(Y);
    Ybinned = ceil(Y*bincount);
    Ybinned(Ybinned==0)=1;
    for i = 1:bincount
        whereclass = find(Ybinned==i);
        whereNaN = intersect(find(isnan(cleaned)==1),whereclass);
        whereaN = intersect(find(isnan(cleaned)==0),whereclass);
        cleaned(whereNaN) = mean(cleaned(whereaN));
    end
end

