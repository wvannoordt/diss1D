clear
clc
close all

globalSettings.N = 50;
globalSettings.Nt = 400;
globalSettings.CFL = 0.3;
globalSettings.a = 1.9;
globalSettings.xmin = 0;
globalSettings.xmax = 1;
globalSettings.radius = 0.2;

ddx={};
ddxLabel={};
ddx{end+1} = [-1/2 0 1/2];
ddx{end+1} = [1/12 -2/3 0 2/3 -1/12];
ddx{end+1} = [-1/60 3/20 -3/4 0 3/4 -3/20 1/60];
ddx{end+1} = [1/280 -4/105 1/5 -4/5 0 4/5 -1/5 4/105 -1/280];
ddxLabel{end+1} = 'cent-2';
ddxLabel{end+1} = 'cent-4';
ddxLabel{end+1} = 'cent-6';
ddxLabel{end+1} = 'cent-8';

diss = {};
dissLabel={};
diss{end+1} = [1 -2 1];
diss{end+1} = [-1/12 4/3 -5/2 4/3 -1/12];
diss{end+1} = [1/90 -3/20 3/2 -49/18 3/2 -3/20 1/90];
dissLabel{end+1} = 'diss-2-1';
dissLabel{end+1} = 'diss-2-3';
dissLabel{end+1} = 'diss-2-5';

diss{end+1} = -1*[1 -4 6 -4 1];
diss{end+1} = -1*[-1/6 2 -13/2 28/3 -13/2 2 -1/6];
diss{end+1} = -1*[7/240 -2/5 169/60 -122/15 91/8 -122/15 169/60 -2/5 7/240];
dissLabel{end+1} = 'diss-4-1';
dissLabel{end+1} = 'diss-4-3';
dissLabel{end+1} = 'diss-4-5';


diss{end+1} = [1 -6 15 -20 15 -6 1];
diss{end+1} = [-1/4 3 -13 29 -75/2 29 -13 3 -1/4];
diss{end+1} = [13/240 -19/24 87/16 -39/2 323/8 -1023/20 323/8 -39/2 87/16 -19/24 13/240];
dissLabel{end+1} = 'diss-6-1';
dissLabel{end+1} = 'diss-6-3';
dissLabel{end+1} = 'diss-6-5';

cases = createCases(globalSettings, ddx, ddxLabel, diss, dissLabel);

for i = 1:length(cases)
    runCase(cases{i});
end