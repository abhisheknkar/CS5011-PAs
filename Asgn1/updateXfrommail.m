function [ X ] = updateXfrommail( X, mailfile )
% Update counts of the words occuring in the mail
    fid = fopen(mailfile,'r');
    
    for i = 1:3
        tline = fgetl(fid);
        if i == 3
            words = strsplit(tline);
            for j = 1:size(words,2)
                if ~X.isKey(words{i})
                    X(words{i})=1;
                else
                    X(words{i}) = X(words{i}) + 1;
                end
            end
        end
    end
end