# Script file?? Maybe this should be a function file
addpath('./activation_derivatives')
addpath('./utility_functions')

function out = network_setup(terrain_type, epochs, n_samples)
    g = {{@tanh, @dtanh}, {@tanh, @dtanh}, {@(x) x, @(x) 1}};
    W = generate_weights_heEtAl([2 10 10 1]);
    full_patterns = load_file(terrain_file);
    test_patterns = n_random_patterns(full_patterns, n_samples);
    %out = incremental_learn(W, test_patterns, g, eta=0.1, epochs, random_pass= true, momentum= 0.9, aep = [], with_error=true);
    out = learn(W, test_patterns, g, eta = 0.1, epochs, momentum = 0, aep = [], with_error = false)
endfunction

network_setup('terrain05.data', 3, 10);