% Give csv without "?"
tic
fid = fopen('data\communities2.data', 'rt');
formatstr = ['%f%f%f%s' repmat('%f',1,125) '\n'];
text = textscan(fid, formatstr, 'Delimiter',',', 'EmptyValue',NaN);
fclose(fid);

% Map for the region names
regions = containers.Map;
for i = 1:length(text{4})
    regions(text{4}{i}) = i;
end

% Cleaning the data: Method 1, replace NaN with mean of that feature
X1 = [];
for i = 1:length(text)-1
    if i == 4
        X1 = [X1 (1:length(text{i}))'];
    else
        X1 = [X1 NaNtoGlobalMean(text{i})];
    end
end
Y1 = NaNtoGlobalMean(text{length(text)});
toc
