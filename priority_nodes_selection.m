function [SN, sel_ms_path, path_ms, pn_ids] = priority_nodes_selection(SN, ms_ids, ms_path)
%PRIORITY_NODES_SELECTION Summary of this function goes here
%   Detailed explanation goes here

sel_ms_path = zeros( 1, length(unique([SN.n.cluster])) );
pn_ids = zeros( 1, length(unique([SN.n.cluster])) );

for cluster = unique([SN.n.cluster])
    
    SN_nodes = []; % Node ID
    SN_short_dms = []; % A nodes shortest distance to a predicted path
    ass_path = []; % Associated MS path of the node's shortest distance
    ass_ms = []; % Associated MS of the node's shortest distance
    
    for i=1:length(SN.n)
        if strcmp(SN.n(i).role, 'N') && (SN.n(i).cluster == cluster) && (~isnan(cluster))
            SN_nodes(end+1) = SN.n(i).id;
            
            % Node Location
            SNx = SN.n(i).x;
            SNy = SN.n(i).y;
            
            ms_mins = zeros(1, length(ms_ids)); % Minimum DMS for each mobile nodes
            ms_mins_paths = zeros(1, length(ms_ids)); % Path with the minimum DMS for the given MS
            
            c = 0; % Counter initiation
            for ms_id = ms_ids
                c = c + 1; % Counter update
                
                dms = zeros(1, length(ms_path.p(ms_id).x));

                for path = 1:length(ms_path.p(ms_id).x)
                    pathx = ms_path.p(ms_id).x(path);
                    pathy = ms_path.p(ms_id).y(path);

                   dms(path) = sqrt( (pathx - SNx)^2 + (pathy - SNy)^2 ); 
                end

                [M,I]=min(dms(:)); % finds the minimum distance of node to MS
                
                ms_mins(1, c) = M;
                ms_mins_paths(1, c) = I;
            end
            
            [M,min_id]=min(ms_mins(:)); % finds the minimum distance of node to MS
            I = ms_mins_paths(min_id); % Corresponding ID
            
            SN_short_dms(end+1) = M; % The shortest dist between node and any MS
            ass_ms(end+1) = ms_ids(min_id); % The closest MS to the node
            ass_path(end+1) = I; % The id of the closest path
        end 
    end
    
    [min_dist,J]=min(SN_short_dms(:)); % finds the minimum distance of node to MS
    
    % To detect is J returns sn empty array
    j_shape = size(J);
    
    if j_shape(1) > 0
        pn_id = SN_nodes(J);
        SN.n(pn_id).role = 'P';
        SN.n(pn_id).ms_id = ass_ms(J);
        SN.n(pn_id).ms_path_id = ass_path(J);
        SN.n(pn_id).dpnms = min_dist;
        sel_ms_path(cluster) = ass_path(J);
        path_ms(cluster) = ass_ms(J);
        pn_ids(cluster) = pn_id;
        
        for i=1:length(SN.n)
            if strcmp(SN.n(i).role, 'N') && (SN.n(i).cluster == cluster) && isinteger(cluster)
                SN.n(i).dnp = sqrt( (SN.n(i).x - SN.n(pn_id).x)^2 + (SN.n(i).y - SN.n(pn_id).y)^2 );
                SN.n(i).pn_id = pn_id;
            end
        end
        
        SN.n(pn_id).dnp = 0;
        SN.n(pn_id).pn_id = pn_id;
    end
    
end


end

