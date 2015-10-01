a = csvread('Q2Out(v0)/ridgeRSS.csv');
b = csvread('Q2Out(v1)/ridgeRSS.csv');
figure(1);
subplot(311); plot(a(2:end,1),a(2:end,2));
title('(a)RSS for replacement with global mean (M1)');
xlabel('lambda');
ylabel('RSS');

subplot(312); plot(b(2:end,1),b(2:end,2),'r');
title('(b)RSS for replacement with class-wise mean (M2)');
xlabel('lambda');
ylabel('RSS');

subplot(313); plot(a(2:end,1),a(2:end,2)); hold on; plot(b(2:end,1),b(2:end,2),'r');
title('(c)Comparison between RSS for replacement with global mean and class-wise mean');
xlabel('lambda');
ylabel('RSS');
legend('Global mean replacement', 'Class-wise mean replacement');
