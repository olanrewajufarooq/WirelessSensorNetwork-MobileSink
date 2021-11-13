function [ms_path] = sink_path_determination(method, SN, ms_ids, radius)
%SINK_PATH_DETERMINATION Summary of this function goes here
%   Detailed explanation goes here


for ms_id = ms_ids
    if strcmp(method, "predicted")
        angles = 0:1:360;

        ms_path.x = zeros(1, 360);
        ms_path.y = zeros(1, 360);

        % Initialization of point numbers
        i = 0;

        for angle=angles

            i = i + 1;        
            rad_angle = angle*pi/180;

            x = SN.n(ms_id).x + radius*cos(rad_angle);
            y = SN.n(ms_id).y + radius*sin(rad_angle);
            
            ms_path.p(ms_id).id = ms_id;
            ms_path.p(ms_id).x = x;
            ms_path.p(ms_id).y = y;

        end

    elseif strcmp(method, "random")

        ms_path.x = zeros(1, 360);
        ms_path.y = zeros(1, 360);

    end
end


end

