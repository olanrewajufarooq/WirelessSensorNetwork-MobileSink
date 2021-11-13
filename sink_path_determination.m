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

            ms_path.x(1, i) = x;
            ms_path.y(1, i) = y;
            ms_path.id(1, i) = ms_id;

        end

    elseif strcmp(method, "random")

        ms_path.x = zeros(1, 360);
        ms_path.y = zeros(1, 360);

    end
end


end

