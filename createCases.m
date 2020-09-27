function [casesOut] = createCases(globalSettings, ddx, ddxLabel, diss, dissLabel, outputDirName)

    casesOut = {};
    idx = 1;
    for i1 = 1:length(ddx)
        for i2 = 1:length(diss)
            
            N = globalSettings.N;
            
            u = zeros(N, 1);
            globalSettings.N;
            Nt = globalSettings.Nt;
            CFL = globalSettings.CFL;
            a = globalSettings.a;
            xmin = globalSettings.xmin;
            xmax = globalSettings.xmax;
            xfaces = linspace(xmin, xmax, N+1)';
            xcells = 0.5*(xfaces(1:end-1) + xfaces(2:end));
            r = globalSettings.radius;
            xstart = 0.5*(xmin+xmax) - r;
            xend = 0.5*(xmin+xmax) + r;

            dx = xfaces(3) - xfaces(2);
            
            dissOp = buildOp(N, diss{i2}, true);
            ddxOp = buildOp(N, ddx{i1}, true);
            RHS_OPER = -dissOp + a*ddxOp/dx;

            for i = 1:N
              u(i) = 0.0;
              if (xcells(i) > xstart && xcells(i) < xend)
                xtilde = (xcells(i)-xstart) / (xend-xstart);
                z = xtilde * (1.0 - xtilde);
                u(i) = exp(-1/z);
              end
            end
            
            
            casesOut{idx}.globalSettings = globalSettings;
            casesOut{idx}.outputDirName = outputDirName;
            casesOut{idx}.dx = dx;
            casesOut{idx}.x0 = xstart;
            casesOut{idx}.x1 = xend;
            casesOut{idx}.initialCondition = u;
            casesOut{idx}.x = xcells;
            casesOut{idx}.ddxCoeff = ddx{i1};
            casesOut{idx}.dissCoeff = diss{i2};
            casesOut{idx}.RHS = RHS_OPER;
            casesOut{idx}.dt = CFL*dx/a;
            casesOut{idx}.Nt = Nt;
            casesOut{idx}.N = N;
            casesOut{idx}.name = ['dc1d-' ddxLabel{i1} '-' dissLabel{i2}];
            casesOut{idx}.outputDir = [outputDirName '/' casesOut{idx}.name];
            idx = idx + 1;
        end
    end

end