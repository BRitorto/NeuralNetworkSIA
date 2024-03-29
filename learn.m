function answer = learn(patterns, is_batch, is_random_approach, adaptative_eta, record_error)

  global W;
  global cant_layers;
  global eta;
  global max_epochs;
  global g;
  global arq;
  global momentum;
  global max_error;
  global min_epochs;

  cant_layers = numel(W);
  cant_patterns = numel(patterns);

  batch_delta_W = cell(cant_layers, 1);
  last_delta_W = cell(cant_layers,1);
  last_error = Inf;

  % consecutive_success will hold the the consecutive number of max_epochs during which the
  % learning has been successful
  consecutive_success = 0;
  % error_array(i) will hold the global error at the end of epoch i
  error_array = zeros(max_epochs, 1);
  
  for i = [1:cant_layers]
    last_delta_W{i} = zeros(rows(W{i}), columns(W{i}));
  endfor

  for k = [1:max_epochs] 
    % Permute the patterns array uniformly if requested
    if (is_random_approach)
      for i = [cant_patterns:-1:2]
        j = floor((unifrnd(1, cant_patterns+1)-1)*0.99999+1);
        temp = patterns{i};
        patterns{i} = patterns{j};
        patterns{j} = temp;
      endfor
    endif

    if (is_batch)
      for i = [1:cant_layers]
        batch_delta_W{i} = zeros(rows(W{i}), columns(W{i}));
      endfor
    endif

    for p = [1:cant_patterns]
      delta_W = run_and_correct(W, patterns{p}{1}, g, patterns{p}{2}, eta);
      if (is_batch)
        for i = [1:cant_layers]
          batch_delta_W{i} += delta_W{i};
        endfor
      else 
        for i = [1:cant_layers]
          W{i} += delta_W{i} + momentum*last_delta_W{i};
        endfor
        last_delta_W = delta_W;
      endif
    endfor
    
    if (is_batch)
      for j = [1:cant_layers]
        W{j} += batch_delta_W{j} + momentum*last_delta_W{j};
      endfor
      last_delta_W = batch_delta_W;
    endif


    error = 0;
    if (record_error)
      error = calculate_error(W, patterns, g);
      error_array(k) = error;
      if (error <= max_error && k >= min_epochs )
        answer = cell(2,1);
        answer{1} = W;
        answer{2} = error_array;
        return;
      endif
    endif

    if (adaptative_eta)
      if (record_error)
        error = calculate_error(W, patterns, g);
      endif
      if (error < last_error)
        consecutive_success++;
        if (consecutive_success == adaptative_eta(3))
          eta = eta*adaptative_eta(1);
          consecutive_success = 0;
          momentum = 0.9;
        endif
      else
        consecutive_success = 0;
        if (error > last_error)
          eta = eta*adaptative_eta(2);
          momentum = 0;
        endif
      endif
      last_error = error;
    endif
      plot_error(error_array)
      refresh(2)
      error
  endfor
  
  answer = cell(2,1);
  answer{1} = W;
  if (record_error)
    answer{2} = error_array;
  else
    answer{2} = [];
  endif
  plot_error(error_array)
  refresh(2)
endfunction
