function [SN, sel_ms_path] = priority_nodes_selection(SN, ms_path)
%PRIORITY_NODES_SELECTION Summary of this function goes here
%   Detailed explanation goes here

sel_ms_path = zeros( 1, length(unique([SN.n.cluster])) );

for cluster = unique([SN.n.cluster])
    
    SN_nodes = []; % Node ID
    SN_short_dms = []; % A nodes shortest distance to a predicted path
    ass_path = []; % Associated MS path of the node's shortest distance
    
    for i=1:length(SN.n)
        if strcmp(SN.n(i).role, 'N') && (SN.n(i).cluster == cluster)
            SN_nodes(end+1) = i;
            
            % Node Location
            SNx = SN.n(i).x;
            SNy = SN.n(i).y;
            
            dms = zeros(1, length(ms_path.x));
            
            for path = 1:length(ms_path.x)
                pathx = ms_path.x(1, path);
                pathy = ms_path.y(1, path);
                
               dms(path) = sqrt( (pathx - SNx)^2 + (pathy - SNy)^2 ); 
            end
            
            [M,I]=min(dms(:)); % finds the minimum distance of node to MS
            
            SN_short_dms(end+1) = M;
            ass_path(end+1) = I; 
        end 
    end
    
    [~,J]=min(SN_short_dms(:)); % finds the minimum distance of node to RN
    
    SN.n(SN_nodes(J)).role = 'P';
    sel_ms_path(cluster) = ass_path(J);
    
end

end

