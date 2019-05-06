1;# Script file?? Maybe this should be a function file

terrain = './terrains/terrain05.data';
max_epochs = 5;
sample_number = 200;

addpath('./activation_derivatives')
addpath('./activation_functions')
addpath('./utility_functions')
addpath('./terrains')

network_setup(terrain, max_epochs, sample_number)