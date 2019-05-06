function out = getMin(terrain_matrix)
    row_num = size(terrain_matrix, 2);
    current_min=0;
    for i=[1: row_num]
        if(terrain_matrix{i}{1}(1) < current_min)
            current_min = terrain_matrix{i}{1}(1);
        endif

        if(terrain_matrix{i}{1}(2) < current_min)
            current_min = terrain_matrix{i}{1}(2);
        endif

        if(terrain_matrix{i}{2} < current_min)
            current_min = terrain_matrix{i}{2};
        endif 
    endfor 
    out = current_min 

endfunction