% Load outputs
% cvals = 1*10.^[-3:3];
% gvals = 1*10.^[-3:3];
cvals = 0.01;
gvals = 0:10:100;
accmat = [];
for cc = 1:length(cvals)
    cval = cvals(cc);
    for gg = 1:length(gvals)
        [cc gg]
        gval = gvals(gg);
        foutname = ['Q4gridout/c=10^' num2str(log(cval)/log(10)) ';g=10^' num2str(log(gval)/log(10)) '.mat']
        if exist(foutname)
            load(foutname)
        end
        accmat(cc,gg) = mean(acc(:,1));
    end
end

% Plot
% surf(cvals,gvals,accmat);