1;# Script file?? Maybe this should be a function file
addpath('./activation_derivatives')
addpath('./activation_functions')
addpath('./utility_functions')
addpath('./terrains')

source('network_parameters.bin');


%save('varis.mat', 'g', 'arq', 'eta', 'sample_number', 'max_epochs');
network_setup();
