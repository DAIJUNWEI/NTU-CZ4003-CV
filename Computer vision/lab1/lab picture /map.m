function desparity = map(image_left,image_right,template_x,template_y)

x_dim = floor(template_x/2);
y_dim = floor(template_y/2);
[x,y] = size(image_left);
desparity = ones(x-template_x+1,y-template_y+1);

for i=1+x_dim:-x_dim 
    for j =1+y_dim:y-y_dim
        r = image_left(i-x_dim: i+x_dim, j-y_dim: j+y_dim);
        l = rot90(r, 2);
        c = j; 
        min_ssd = 1000000;
        for k = max(1+y_dim , j-14) : j
            T = image_right(i-x_dim: i+x_dim, k-y_dim: k+y_dim);
            r = rot90(T, 2);
            conv_1 = conv2(T, r);
            conv_2 = conv2(T, l);
            ssd = conv_1(template_x,template_y) - 2 * conv_2(template_x, template_y);
            if ssd < min_ssd
                min_ssd = ssd;
                c = k;
            end
        end
        desparity(i - x_dim, j - y_dim) = j - c;
    end
end