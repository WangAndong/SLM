function show_cluster_centers(idx)

opt = globals;

% load data
object = load('data.mat');
data = object.data;

% load the mean CAD model
cls = 'car';
filename = sprintf('%s/%s_mean.mat', opt.path_slm_geometry, cls);
object = load(filename);
cad = object.(cls);
index = cad.grid == 1;

% cluster centers
centers = unique(idx);
N = numel(centers);

% sort centers according to azimuth
azimuth = data.azimuth(centers);
[~, order] = sort(azimuth);
centers = centers(order);

figure;
ind_plot = 1;
for i = 1:N
    % show center
    ind = centers(i);
    grid = data.grid(:,ind);
    visibility_grid = zeros(size(cad.grid));
    visibility_grid(index) = grid;
    subplot(4, 4, ind_plot);
    ind_plot = ind_plot + 1;
    draw_cad(cad, visibility_grid);
    view(data.azimuth(ind), data.elevation(ind));    
    
    if ind_plot > 16
        ind_plot = 1;
        pause;
    end
end