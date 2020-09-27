function [] = postProcessEnergy(dirname, outputdir)
    
    system(['rm -rf ' outputdir]);
    system(['mkdir -p ' outputdir]);
    listing = dir([dirname '/dc1d*']);
    Ncases = length(listing);
    legendNames = {};
    figure
    hold on
    for i = 1:Ncases
        dataName = [dirname '/' listing(i).name '/data.csv'];
        infoName = [dirname '/' listing(i).name '/info.mat'];
        legendNames{end+1} = listing(i).name;
        info = load(infoName);
        data = csvread(dataName);
        energy = diag(data'*data);
        energy = energy/energy(1);
        plot(energy)
    end
    %legend(legendNames);
    saveas(gcf, [outputdir '/energy.png']);
    close all
    
end