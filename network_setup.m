function out = network_setup()
    global sample_number;
    global terrain;
    %global g;

    full_patterns = load_file(terrain);
    normalized_patterns = normalize(full_patterns);
    test_patterns = randomize_patterns(normalized_patterns, sample_number);
    out = learn(test_patterns, false, random_pass = false, momentum = 0.9, aep = [], with_error = true);
    %plot_nn(out{1}, full_patterns, g); 
endfunction