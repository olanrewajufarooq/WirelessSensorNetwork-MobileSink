function plot_ms_path(ms_path, ms_ids)
%PLOT_MS_PATH Summary of this function goes here
%   Detailed explanation goes here
for ms_id = ms_ids
    
    for path = 1:length(ms_path.p(ms_id).x)
        % Plot Path Points Update
        p = scatter(ms_path.p(ms_id).x(path), ms_path.p(ms_id).y(path), 0.5);
        p.MarkerFaceColor = 'yellow';
        p.MarkerEdgeColor = 'yellow';

        drawnow;
        hold on;
    end
    
end

end

