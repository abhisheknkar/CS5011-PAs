% Give csv without "?"
clc;clear all;close all
tic
fid = fopen('data/communities1.data', 'rt');
formatstr = ['%f%f%f%s' repmat('%f',1,124) '\n'];
text = textscan(fid, formatstr, 'Delimiter',',', 'EmptyValue',NaN);
fclose(fid);

% Map for the region names
regions = containers.Map;
for i = 1:length(text{4})
    regions(text{4}{i}) = i;
end

% Cleaning the data: Method 1, replace NaN with mean of that feature
X1 = [];
X0 = [];
for i = 6:length(text)-1
    i
    X0 = [X0 NaNtoGlobalMean(text{i})];
    X1 = [X1 NaNtoClassWiseMean(text{i}, text{length(text)}, 10)];
end
Y1 = NaNtoGlobalMean(text{length(text)});
toc