function [] = postProcessDecay(dirname, outputdir)

    system(['rm -rf ' outputdir]);
    system(['mkdir -p ' outputdir]);

end