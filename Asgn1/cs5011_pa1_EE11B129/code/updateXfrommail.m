function [ X, words ] = updateXfrommail( X, mailfile, addtoX, mode )
% Update counts of the words occuring in the mail
    fid = fopen(mailfile,'r');
    
    for i = 1:3
        tline = fgetl(fid);
        if i == 3
            words = strsplit(tline);
            if strcmp(mode,'binomial') == 1
                words = unique(words);
            end
            if addtoX
                for j = 1:size(words,2)
                    if ~X.isKey(words{j})
                        X(words{j})=1;
                    else
                        X(words{j}) = X(words{j}) + 1;
                    end
                end
            end
        end
    end
    fclose(fid);
end