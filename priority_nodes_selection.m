function [SN, PN, PN_Cluster] = priority_nodes_selection(SN, dims, ms_path, seed)
%PRIORITY_NODES_SELECTION Summary of this function goes here
%   Detailed explanation goes here

if nargin < 5
    seed = true;
end

% Election Seed
if seed == true
    i_seed = 0;
elseif isnumeric(seed)
    i_seed = seed;
end

% Initiating the priority heads
PN_Cluster = 0; % Initializing the priority nodes count
PN = struct(); % The struct containing the priority node data



end

