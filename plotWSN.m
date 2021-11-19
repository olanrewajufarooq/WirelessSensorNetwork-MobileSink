function plotWSN(SN, dims)
%PLOTWSN Graphical Representation of Wireless Sensor Network
%   This function provides of the graphical representation of a Wireless 
%   Sensor Network (WSN). 
%
%   INPUT PARAMETERS
%   SN - all sensors nodes (including routing nodes)
%   dims - container of the dimensions of the WSN plot extremes and the
%           base station point. outputs: x_min, x_min, y_min, x_max, y_max, 
%           bs_x, bs_y
%   rn_circle - a boolean for plotting routing node line. DEFAULT: false
%   sim_name - the name of the wireless network simulation. 
%               Default: 'LEACH'.
%
%   OUTPUT: the graphical representation of the WSN

figure(1)

plot( dims('x_min'),dims('y_min'),dims('x_max'),dims('y_max') )
hold on

for i=1:length(SN.n)
    % Plots
    p = scatter(SN.n(i).x, SN.n(i).y);
    if strcmp(SN.n(i).role, 'N')
        p.MarkerFaceColor = 'red';
        p.MarkerEdgeColor = 'red';
        p.MarkerFaceAlpha = 0.01 - SN.n(i).E/50;
    else
        p.MarkerFaceColor = 'black';
        p.MarkerEdgeColor = 'black';
    end
    hold on
end

title ({'Mobile Sink'; 'Wireless Sensor Network';})
xlabel '(m)';
ylabel '(m)';


end

