clear
clc
close all
more off

N = 50;
Nt = 40000;
CFL = 0.3;
a = 1.9;
xmin = 0;
xmax = 1;
xfaces = linspace(xmin, xmax, N+1)';
xcells = 0.5*(xfaces(1:end-1) + xfaces(2:end));
u = zeros(N, 1);
energy = zeros(N, 1);

r = 0.2;
xstart = 0.5*(xmin+xmax) - r;
xend = 0.5*(xmin+xmax) + r;

dx = xfaces(3) - xfaces(2);

coeff1 = [-1/2 0 1/2];
coeff1 = [1/280 -4/105 1/5 -4/5 0 4/5 -1/5 4/105 -1/280];

ddx = buildOp(N, coeff1, true);

coeff2 = [13/240 -19/24 87/16 -39/2 323/8 -1023/20 323/8 -39/2 87/16 -19/24 13/240];
diss = 0.0*buildOp(N, coeff2, true);

RHS_OPER = -diss + a*ddx/dx;

for i = 1:N
  u(i) = 0.0;
  if (xcells(i) > xstart && xcells(i) < xend)
    xtilde = (xcells(i)-xstart) / (xend-xstart);
    z = xtilde * (1.0 - xtilde);
    u(i) = exp(-1/z);
  end
end





dt = CFL*dx/a;

figure
for n = 1:Nt
  clf
  plot(xcells, u);
  drawnow
  k1 = RHS_OPER*u;
  k2 = RHS_OPER*(u-0.5*dt*k1);
  k3 = RHS_OPER*(u-0.5*dt*k2);
  k4 = RHS_OPER*(u-dt*k3);
  energy(n) = u'*u/N;
  u = u - dt*(1/6)*(k1+2*k2+2*k3+k4);
  if (energy(n) > 3.0*energy(1))
    error('diverged in time')
  end
end
close all
plot(energy/energy(1))