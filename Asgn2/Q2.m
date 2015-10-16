load fisheriris

lqrparam = 2

PL = meas(:,3);
PW = meas(:,4);
for i = 1:length(species)
    species{i} = ['Iris-' species{i}];
end

h1 = gscatter(PL,PW,species,'krb','ov^',[],'off');
legend('Setosa','Versicolor','Virginica','Location','best')
hold on

%% Linear classifier
if lqrparam == 1
    X = [PL,PW];
    cls = fitcdiscr(X,species);

    K = cls.Coeffs(2,3).Const; % First retrieve the coefficients for the linear
    L = cls.Coeffs(2,3).Linear;% boundary between the second and third classes
                               % (versicolor and virginica).

    % Plot the curve K + [x,y]*L  = 0.
    f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
    h2 = ezplot(f,[.9 7.1 0 2.5]);
    h2.Color = 'r';
    h2.LineWidth = 2;

    % Now, retrieve the coefficients for the linear boundary between the first
    % and second classes (setosa and versicolor).
    K = cls.Coeffs(1,2).Const;
    L = cls.Coeffs(1,2).Linear;

    % Plot the curve K + [x1,x2]*L  = 0:
    f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
    h3 = ezplot(f,[.9 7.1 0 2.5]);
    h3.Color = 'k';
    h3.LineWidth = 2;
    axis([.9 7.1 0 2.5])
    xlabel('Petal Length')
    ylabel('Petal Width')
    title('{\bf Linear Classification with Fisher Training Data}')
end

%% QDA
if lqrparam == 2
    cqs = fitcdiscr(X,species,...
        'DiscrimType','quadratic');
%     delete(h2); delete(h3) % First, remove the linear boundaries from the plot.

    % Now, retrieve the coefficients for the quadratic boundary between the
    % second and third classes (versicolor and virginica).
    K = cqs.Coeffs(2,3).Const;
    L = cqs.Coeffs(2,3).Linear;
    Q = cqs.Coeffs(2,3).Quadratic;

    % Plot the curve K + [x1,x2]*L + [x1,x2]*Q*[x1,x2]' = 0.
    f = @(x1,x2) K + L(1)*x1 + L(2)*x2 + Q(1,1)*x1.^2 + ...
        (Q(1,2)+Q(2,1))*x1.*x2 + Q(2,2)*x2.^2;
    h2 = ezplot(f,[.9 7.1 0 2.5]);
    h2.Color = 'r';
    h2.LineWidth = 2;

    % Now, retrieve the coefficients for the quadratic boundary between the
    % first and second classes (setosa and versicolor).
    K = cqs.Coeffs(1,2).Const;
    L = cqs.Coeffs(1,2).Linear;
    Q = cqs.Coeffs(1,2).Quadratic;

    % Plot the curve K + [x1,x2]*L + [x1,x2]*Q*[x1,x2]'=0:
    f = @(x1,x2) K + L(1)*x1 + L(2)*x2 + Q(1,1)*x1.^2 + ...
        (Q(1,2)+Q(2,1))*x1.*x2 + Q(2,2)*x2.^2;
    h3 = ezplot(f,[.9 7.1 0 1.02]); % Plot the relevant portion of the curve.
    h3.Color = 'k';
    h3.LineWidth = 2;
    axis([.9 7.1 0 2.5])
    xlabel('Petal Length')
    ylabel('Petal Width')
    title('{\bf Quadratic Classification with Fisher Training Data}')
    hold off
end
