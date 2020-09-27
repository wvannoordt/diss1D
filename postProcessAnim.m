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
    
    figure
    for n = 1:(Ntmin+1)
        clf
        hold on
        for i = 1:Ncases
            dat = datas{i};
            plot(x, dat(:, n));
        end
        drawnow
        hold off
    end
    %legend(legendNames);
    %saveas(gcf, [outputdir '/energy.png']);
    close all

end