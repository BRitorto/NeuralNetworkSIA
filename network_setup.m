function out = network_setup(terrain_file, epochs, n_samples)
    W = generate_weights_heEtAl([2 3 10 1]);
    full_patterns = load_file(terrain_file);
    test_patterns = randomize_patterns(full_patterns, n_samples);
    g = {{@tanh, @dtanh}, {@tanh, @dtanh}, {@(x) x, @(x) 1}};
    %out = incremental_learn(W, test_patterns, g, eta=0.1, epochs, random_pass= true, momentum= 0.9, aep = [], with_error=true);
    out = learn(W, test_patterns, g, eta = 0.1, epochs, false, false, momentum = 0, aep = [], record_error = true);
endfunction