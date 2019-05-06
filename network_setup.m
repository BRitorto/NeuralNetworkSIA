function out = network_setup(terrain_file, epochs, n_samples, arq)
    W = generate_weights_heEtAl(arq);
    full_patterns = load_file(terrain_file);

    normalized_patterns = normalize(full_patterns);

    test_patterns = randomize_patterns(normalized_patterns, n_samples);
    g = {{@sigmoid_exp, @dsigmoid_exp}, {@sigmoid_exp, @dsigmoid_exp}, {@(x) x, @(x) 1}};
    %out = incremental_learn(W, test_patterns, g, eta=0.1, epochs, random_pass= true, momentum= 0.9, aep = [], with_error=true);
    out = learn(W, test_patterns, g, eta = 0.0005, epochs, false, false, momentum = 0.9, aep = [], record_error = true)
endfunction