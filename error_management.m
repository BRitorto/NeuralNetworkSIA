addpath('./activation_derivatives')
addpath('./utility_functions')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes a neural network, a training pattern and a learning rate
% and calculates the weight updates according to the back-propagation rule
%
% Parameters:
%
% W is a cell array of matrices. W{m}(j, i) holds the weight of the
% connection from unit i in the m-1 layer to unit j in the m layer
%
% E is a column vector. E(i) holds the input for unit i
%
% g is a two dimentional cell array of function handles. g{m}{1} is the the 
% activation function for layer m; g{m}{2} is the derivative of g{m}{1} in 
% terms of g (for example, if g{m}{1}(x) = tanh(x), then g{m}{2}(x) = 1-x^2
%
% S is the expected output as a column vector
%
% eta is the learning rate
%
% Return value:
%
% delta_W is a cell array of matrices. delta_W{m} contains the updates to be added to the 
% weight matrix at layer m
function delta_W = run_and_correct(W, E, g, S, eta)
  % M is the number of layers
  cant_layers = numel(W);
  V = run_pattern(W, E, g);
  
  % ders is a cell array. ders{m}(i) contains the derivative of the mth layer 
  % activation function evaluated at the ith unit's h
  derivatives = V;
  derivatives = apply_derivative(derivatives, V, g, cant_layers);
  
  % delta is a cell array.
  delta = cell(cant_layers, 1);
  delta_W = backpropagation(delta, W, S, V, derivatives, cant_layers);
endfunction

function delta_W = backpropagation(delta, W, S, V, derivatives, cant_layers)
  delta{cant_layers} = tensor_product(S - V{cant_layers+1}, derivatives{cant_layers+1});
  for k = [cant_layers-1:-1:1]
    delta{k} = tensor_product((delta{k+1}*W{k+1})(2:end), derivatives{k+1});
  endfor
  % delta_W is a cell array of matrices; delta_W{m} contains the weight update matrix for 
  % layer m
  delta_W = cell(cant_layers, 1);
  for k = [1:cant_layers]
    delta_W{k} = eta*(V{k}*delta{k})';
  endfor
endfunction

function derivatives = apply_derivative(derivatives, V, g, cant_layers)
  for k = [2:cant_layers]
    derivatives{k} = arrayfun(g{k-1}{2}, V{k}(2:end));
  endfor
  derivatives{cant_layers+1} = arrayfun(g{M}{2}, V{cant_layers+1});
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes a neural network and an input pattern and returns the 
% output at every layer
%
% Parameters:
%
% W is a cell array of matrices. W{m}(j, i) holds the weight of the
% connection from unit i in the m-1 layer to unit j in the m layer
%
% E is a column vector. E(i) holds the input for unit i
%
% g is a two dimentional cell array of function handles. g{m}{1} is the the 
% activation function for layer m
%
% Return value:
%
% V is a cell array of column vectors. V{m}(i) holds the output of unit i at
% layer m-1
function V = run_pattern(W, E, g)
  cant_layers = numel(W);
  V = cell(cant_layers+1, 1);
  V{1} = E;
  for k = [1:cant_layers]
    V{k} = [-1; V{k}];
    V{k+1} = arrayfun(g{k}{1}, W{k}*V{k});
  endfor
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes a neural network and a series of patterns and returns the 
% overall error
%
% Parameters:
%
% W is a cell array of matrices. W{m}(j, i) holds the weight of the
% connection from unit i in the m-1 layer to unit j in the m layer
%
% patterns is a two dimentional cell array. patterns{i}{1} contains and input 
% pattern; patterns{i}{2} holds the expected output
%
% g is a two dimentional cell array of function handles. g{m}{1} is the the 
% activation function for layer m
%
% Return value:
%
% V is a cell array of column vectors. V{m}(i) holds the output of unit i at
% layer m-1
function error = calculate_error(W, patterns, g)
  cant_layers = numel(W);
  outsize = rows(W{cant_layers});
  P = numel(patterns);
  error = 0;
  for p = [1:P]
    res = run_pattern(W, patterns{p}{1}, g){cant_layers+1};
    for o = [1:outsize]
      error += (patterns{p}{2}(o) - res(o))^2;
    endfor
  endfor
  error /= 2;
endfunction