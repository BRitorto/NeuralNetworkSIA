function out = network_setup()
<<<<<<< HEAD

    global terrain_file;
    global sample_number;
    global test_patterns;
    global train_patterns;
    global result;
    global trained_weights;
    global normalize_fun;
    global is_batch;
    global is_random_approach;
    global adaptative_eta;
    global record_error;
    global g;

    full_patterns = load_file(terrain_file);
    normalized_patterns = normalize_fun(full_patterns);
    patterns = randomize_patterns(normalized_patterns, sample_number);
    train_patterns = patterns{1};
    test_patterns = patterns{2};
    out = learn(train_patterns, is_batch, is_random_approach, adaptative_eta, record_error);    
    trained_weights = out{1};
    plot_nn(trained_weights, test_patterns, g, terrain_file)
    pause(2)
=======
    global sample_number;
    global terrain;
    %global g;

    full_patterns = load_file(terrain);
    normalized_patterns = normalize(full_patterns);
    test_patterns = randomize_patterns(normalized_patterns, sample_number);
    out = learn(test_patterns, false, random_pass = false, aep = [], with_error = true);
    %plot_nn(out{1}, full_patterns, g); 
>>>>>>> 4f07200c7369c015df842dffa95f4b642d1142fe
endfunction