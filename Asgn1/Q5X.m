% This script maps all the distinct words in the dictionary to numbers

clc;clear all;close all;
tic
maxword = 0;
wordmap = containers.Map;
for i = 1:10
    i
    foldername = ['data/Q10/part' num2str(i) '/'];
    files = dir([foldername '*.txt']);
    for j = 1:size(files,1)
        filepath = [foldername files(j).name];
        fid = fopen(filepath,'r');
        for k = 1:3
            tline = fgetl(fid);
            if k == 3
                words = strsplit(tline);
                words = unique(words);
                for m = 1:size(words,2)
                    if ~wordmap.isKey(words{m})
                        wordmap(words{m})=length(wordmap);
                        if str2double(words{m}) > maxword
                            maxword = str2double(words{m})
                        end
                    end                    
                end
            end
        end
        fclose(fid);
    end
end
% save('Q5wordmap.mat', 'wordmap');
toc