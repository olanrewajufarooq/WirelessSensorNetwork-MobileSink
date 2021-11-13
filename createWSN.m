function [SN, ms_ids] = createWSN(nodes, sink_nodes, dims, energy, seed)
%CREATEWSN Creation of the Wireless Sensor Network
%   This function gives the initialization of the sensor nodes, the routing
%   nodes and the base station of the wireless sensor network (WSN). It
%   also initiates the energy values and some important conditions for the
%   WSN simulation.
%
%   INPUT PARAMETERS
%   nodes - the total number of sensor and routing nodes
%   sink_nodes - the number of mobile sinks
%   dims - the dimensions of the WSN
%   energy - initial energy of the nodes (excluding the sinks - whose
%               energy are infinite).
%   seed - the random generation seed. Default: true. But you can pass a
%               new seed by assigning a numeric valid to the seed
%               parameter. If you don't want seeding, assign 'false'.
%
%   OUTPUT PARAMETERS
%   SN - all sensors nodes (including routing routes)

%% Function Default Values

if sink_nodes >= nodes
    error('The number of mobile sinks must be less than the total number of nodes')
end

if nargin < 5
    seed = true;
end

% Simulation Seed Initiation
if seed == true
    i_seed = 0;
elseif isnumeric(seed)
    i_seed = seed;
end


%% Building the sensor nodes of the WSN

SN = struct();

for i=1:nodes-sink_nodes
        
    if seed ~= false
        rng(i_seed);
        i_seed = i_seed + 1;
    end

    SN.n(i).id = i;	% sensor's ID number
    SN.n(i).x = rand(1,1)*dims('x_max');	% X-axis coordinates of sensor node
    SN.n(i).y = rand(1,1)*dims('y_max');	% Y-axis coordinates of sensor node
    SN.n(i).E = energy;     % nodes energy levels (initially set to be equal to "ener('init')"
    SN.n(i).role = 'N';   % node acts as normal if the value is 'N', if elected as a priority node it  gets the value 'P' (initially all nodes are normal). Nodes can also be designed as sink => 'S'
    SN.n(i).cluster = 0;	% the cluster which a node belongs to
    SN.n(i).cond = 'A';	% States the current condition of the node. when the node is operational (i.e. alive) its value = 'A' and when dead, value = 'D'
    SN.n(i).rop = 0;	% number of rounds node was operational
       
end

%% Building the mobile sinks

ms_ids = zeros(1, sink_nodes); % Initializing array of mobile sink IDs

for i=1:sink_nodes
        
    if seed ~= false
        rng(i_seed);
        i_seed = i_seed + 1;
    end
    
    j = nodes-sink_nodes+i;

    SN.n(j).id = j;	% sensor's ID number
    SN.n(j).x = 0.5*dims('x_max');	% X-axis coordinates of sensor node
    SN.n(j).y = 0.5*dims('y_max');	% Y-axis coordinates of sensor node
    SN.n(j).E = inf;     % nodes energy levels (initially set to be equal to "ener('init')"
    SN.n(j).role = 'S';   % node acts as normal if the value is 'N', if elected as a priority node it  gets the value 'P' (initially all nodes are normal). Nodes can also be designed as sink => 'S'
    SN.n(j).cluster = NaN;	% the cluster which a node belongs to
    SN.n(j).cond = 'A';	% States the current condition of the node. when the node is operational (i.e. alive) its value = 'A' and when dead, value = 'D'
    SN.n(j).rop = 0;	% number of rounds node was operational
    
    ms_ids(1, i) = j;
 
end

end

