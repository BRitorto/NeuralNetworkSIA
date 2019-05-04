function info = load_file(terrain)
    data = load('-ascii', terrain);
    length = length(data / 3);
    x = data(1:length);
    y = data(length+1: length*2);
    z = data(length*2 + 1: length*3);

    # Info format
    # [x1 y1]   z1 (k = 1)
    # [x2 y2]   z2 (k= 2)
    # . . . 
    # [xn yn]   zn (k=n)
    info = {};
    for k = [1:length]
        info{k}{1} = [x(k) ; y(k)];
        info{k}{2} = z(k);
    end
    # info # --> Uncomment if running terrain-test.m
endfunction