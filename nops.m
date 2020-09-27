clear
clc
close all
more off

N = 100;
coeffs = {};
colors = {};

coeffs{end+1} = [1 -2 1];
coeffs{end+1} = [-1/12 4/3 -5/2 4/3 -1/12];
coeffs{end+1} = [1/90 -3/20 3/2 -49/18 3/2 -3/20 1/90];
colors{end+1} = [0.3 0 0];
colors{end+1} = [0.6 0 0];
colors{end+1} = [0.9 0 0];

coeffs{end+1} = [1 -4 6 -4 1];
coeffs{end+1} = [-1/6 2 -13/2 28/3 -13/2 2 -1/6];
coeffs{end+1} = [7/240 -2/5 169/60 -122/15 91/8 -122/15 169/60 -2/5 7/240];
colors{end+1} = [0 0.3 0];
colors{end+1} = [0 0.6 0];
colors{end+1} = [0 0.9 0];

coeffs{end+1} = [1 -6 15 -20 15 -6 1];
coeffs{end+1} = [-1/4 3 -13 29 -75/2 29 -13 3 -1/4];
coeffs{end+1} = [13/240 -19/24 87/16 -39/2 323/8 -1023/20 323/8 -39/2 87/16 -19/24 13/240];
colors{end+1} = [0 0 0.3];
colors{end+1} = [0 0 0.6];
colors{end+1} = [0 0 0.9];
figure
hold on
for z = 1:length(coeffs)
  oper = buildOp(N, coeffs{z}, true);
  [v, lambda] = eig(oper);
  lambda = diag(lambda);
  if (max(-lambda) > 0.001)
    lambda = -lambda
  end
  if (lambda(end) < lambda(1))
    lambda = lambda(N:-1:1);
  end
  plot(1:2:N, lambda(1:2:N), 'color', colors{z}, 'lineWidth', 3)
end
xlabel('1/\lambda')
ylabel('A')
saveas(gcf, 'ops.png');
