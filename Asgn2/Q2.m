clc;clear all;close all;
addpath(genpath('../../pmtk3/'))
load fisheriris
X = meas(:, 3:4);  % for illustrations use 2 species, 2 features
labels = species;
[y, support] = canonizeLabels(labels);
% types = {'quadratic', 'linear', 'RDA'};
types = {'RDA'};
lambdamat = 10.^[-6:4];
% lambdamat = 1:.1:2;
for tt=1:length(types)
    for i = lambdamat
    if strcmp(types{tt},'RDA')
        lambda = i;
        model = discrimAnalysisFit(X, y, types{tt},'lambda',lambda);
    else
        model = discrimAnalysisFit(X, y, types{tt});
    end
    h = plotDecisionBoundary(X, y, @(Xtest)discrimAnalysisPredict(model, Xtest));
    legend(h, support, 'Location', 'NorthWest');
%     set(gca, 'Xtick', 5:8, 'Ytick', 2:0.5:4);
    xlabel('X_1'); ylabel('X_2');
    if strcmp(types{tt},'RDA')
        title(['Discrim. analysis of type ', types{tt} ', lambda=' num2str(lambda)]);
        saveas(gca,['Q2/' types{tt} ', lambda=' num2str(lambda) '.png']);
    else
        title(sprintf('Discrim. analysis of type %s', types{tt}));
        saveas(gca,['Q2/' types{tt} '.png']);
    end
    end
    close all
end