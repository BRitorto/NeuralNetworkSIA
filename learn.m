1;
function ans = learn(W, patterns, g, eta, cant_epochs, is_batch, is_random_approach, momentum, adaptative_eta, record_error)
  cant_layers = numel(W);
  cant_patterns = numel(patterns);
  
  batch_dw = cell(cant_layers, 1);
  % last_dw will hold the weight updates for the previous update (to implement momentum)
  last_dw = cell(cant_layers,1);
  % last_err will hold the error of the last epoch (to implement adaptative eta)
  last_err = Inf;
  % consecutive_success will hold the the consecutive number of cant_epochs during which the
  % learning has been successful
  consecutive_success = 0;
  % error_array(i) will hold the global error at the end of epoch i
  error_array = zeros(cant_cant_epochs, 1);
  
  for i = [1:cant_layers]
    last_dw{i} = zeros(rows(W{i}), columns(W{i}));
  endfor
  
  for k = [1:cant_epochs] 
    % Permute the patterns array uniformly if requested
    if (is_random_approach)
      for i = [n:-1:2]
        j = floor((unifrnd(1, n+1)-1)*0.99999+1);
        temp = patterns{i};
        patterns{i} = patterns{j};
        patterns{j} = temp;
      endfor
    endif

    % Initialize batch_dw, which will accumulate the weight changes for one whole epoch
    if (is_batch)
      for i = [1:cant_layers]
        batch_dw{i} = zeros(rows(W{i}), columns(W{i}));
      endfor
    endif

    % Run each pattern once
    for p = [1:n]
      dw = run_and_correct(W, patterns{p}{1}, g, patterns{p}{2}, eta);
      if (is_batch)
        for i = [1:cant_layers]
          batch_dw{i} += dw{i};
        endfor
      else % is_incremental
        for i = [1:cant_layers]
          W{i} += dw{i} + momentum*last_dw{i};
        endfor
        last_dw = dw;
      endif
    endfor

    % batch update
    if (is_batch)
      for j = [1:cant_layers]
        W{j} += batch_dw{j} + momentum*last_dw{j};
      endfor
      last_dw = batch_dw;
    endif

    % calculate error
    err = 0;
    if (record_error)
      err = calculate_error(W, patterns, g);
      error_array(k) = err;
    endif

    % adaptative eta
    if (adaptative_eta)
      if (record_error)
        err = calculate_error(W, patterns, g);
      endif
      if (err < last_err)
        consecutive_success++;
        if (consecutive_success == adaptative_eta(3))
          eta += adaptative_eta(1);
          consecutive_success = 0;
        endif
      else
        consecutive_success = 0;
        if (err > last_err)
          eta -= adaptative_eta(2)*eta;
        endif
      endif
      last_err = err;
    endif

  endfor
  
  ansWE = cell(2,1);
  ansWE{1} = W;
  if (record_error)
    ansWE{2} = error_array;
  else
    ansWE{2} = [];
  endif
end function


learn(W, patterns, g, eta, epochs, momentum = 0, aep = [], with_error = false)