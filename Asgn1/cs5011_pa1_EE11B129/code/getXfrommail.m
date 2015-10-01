function [ X, words ] = getXfrommail( mailfile, mode )
% Get counts of the words occuring in the mail
    fid = fopen(mailfile,'r');
    X = zeros(1,24748);
    for i = 1:3
        tline = fgetl(fid);
        if i == 3
            words = strsplit(tline);
            if strcmp(mode,'binomial') == 1
                words = unique(words);
            end
            for j = 1:size(words,2)
                word2num = str2double(words{j})+1;
                X(word2num) = X(word2num) + 1;
            end
        end
    end
    fclose(fid);
end