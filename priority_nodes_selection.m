function [SN, sel_ms_path, pn_ids] = priority_nodes_selection(SN, ms_path)
%PRIORITY_NODES_SELECTION Summary of this function goes here
%   Detailed explanation goes here

sel_ms_path = zeros( 1, length(unique([SN.n.cluster])) );
pn_ids = zeros( 1, length(unique([SN.n.cluster])) );

for cluster = unique([SN.n.cluster])
    
    SN_nodes = []; % Node ID
    SN_short_dms = []; % A nodes shortest distance to a predicted path
    ass_path = []; % Associated MS path of the node's shortest distance
    
    for i=1:length(SN.n)
        if strcmp(SN.n(i).role, 'N') && (SN.n(i).cluster == cluster) && isinteger(cluster)
            SN_nodes(end+1) = SN.n(i).id;
            
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
    
    if isinteger(J)
        SN.n(SN_nodes(J)).role = 'P';
        sel_ms_path(cluster) = ass_path(J);
        pn_ids(cluster) = SN_nodes(J);
    end
    
end

for cluster = unique([SN.n.cluster])
   
    if isinteger(cluster)
       pn_id = pn_ids(cluster);

        for i=1:length(SN.n)
            if strcmp(SN.n(i).role, 'N') && (SN.n(i).cluster == cluster) && isinteger(cluster)
                SN.n(i).dnp = sqrt( (SN.n(i).x - SN.n(pn_id).x)^2 + (SN.n(i).y - SN.n(pn_id).y)^2 );
                SN.n(i).pn_id = pn_id;
            end
        end

        ms_path_id = sel_ms_path(cluster);
        SN.n(pn_id).dpnms = sqrt( (SN.n(pn_id).x - ms_path.x(1, ms_path_id))^2 + (SN.n(pn_id).y - ms_path.y(1, ms_path_id))^2 );
        SN.n(pn_id).ms_id = ms_path.id(1, ms_path_id);

        SN.n(pn_id).dnp = 0;
        SN.n(pn_id).pn_id = pn_id; 
    end
    
end

end

