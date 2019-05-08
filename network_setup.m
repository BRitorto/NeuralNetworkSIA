function out = network_setup(terrain_file, epochs, n_samples)
    global arq;
    global W;
    global g;
    full_patterns = load_file(terrain_file);
    normalized_patterns = normalize(full_patterns);
    test_patterns = randomize_patterns(normalized_patterns, n_samples);
    out = learn(test_patterns, epochs, false, random_pass = false, momentum = 0.9, aep = [], with_error = true);
    %plot_nn(out{1}, full_patterns, g); 
endfunction