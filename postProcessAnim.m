function [] = postProcessAnim(dirname, outputdir)
    
    system(['rm -rf ' outputdir]);
    system(['mkdir -p ' outputdir]);
    listing = dir([dirname '/dc1d*']);
    Ncases = length(listing);
    legendNames = {};
    datas = {};
    infos = {};
    Ntmin = 100000000;
    x = 1.0;
    for i = 1:Ncases
        dataName = [dirname '/' listing(i).name '/data.csv'];
        infoName = [dirname '/' listing(i).name '/info.mat'];
        legendNames{end+1} = listing(i).name;
        info = load(infoName);
        x = info.caseIn.x;
        infos{end+1} = info;
        datas{end+1} = csvread(dataName);
        Ntmin = min(Ntmin, info.caseIn.Nt);
    end
    
    figure('Position', [10 10 1648 900])
    havebounds = false;
    abounds = [0 1 0 1];
    for n = 1:(Ntmin+1)
        clf
        hold on
        for i = 1:Ncases
            dat = datas{i};
            if ~havebounds
                r = 0.1;
                minVal = min(dat(:, 1));
                maxVal = max(dat(:, 1));
                z = max(abs([minVal maxVal]));
                abounds = [info.caseIn.x0 info.caseIn.x1 -(1+r)*z (1+r)*z];
            end
            plot(x, dat(:, n));
        end
        a = legend(legendNames);
        axis(abounds);
        set(a, 'location', 'northeastoutside');
        drawnow
        hold off
        if (n==(Ntmin+1))
            saveas(gcf, [outputdir '/waveform.png']);
        end
    end
    
    close all

end