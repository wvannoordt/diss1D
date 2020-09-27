function [noOut] = runCase(caseIn)
    outputDir = caseIn.outputDir;
    Nt = caseIn.Nt;
    RHS = caseIn.RHS;
    dt = caseIn.dt;
    N = caseIn.N;
    u = caseIn.initialCondition;
    system(['mkdir -p ' outputDir]);
    infoName = [outputDir '/info.mat'];
    dataName = [outputDir '/data.csv'];
    save(infoName, 'caseIn');
    energy = zeros(1, Nt);
    solutionOutput = zeros(N, Nt+1);
    solutionOutput(:, 1) = u;
    for n = 1:Nt
        k1 = RHS*u;
        k2 = RHS*(u-0.5*dt*k1);
        k3 = RHS*(u-0.5*dt*k2);
        k4 = RHS*(u-dt*k3);
        energy(n) = u'*u/N;
        u = u - dt*(1/6)*(k1+2*k2+2*k3+k4);
        if (energy(n) > 3.0*energy(1))
            error([caseIn.name ' diverged in time'])
        end
        solutionOutput(:, 1+n) = u;
    end
    csvwrite(dataName, solutionOutput);
    noOut = 0;
end