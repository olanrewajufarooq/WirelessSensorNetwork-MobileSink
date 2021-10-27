function SN = createWSN(nodes, sink_nodes, dims, energy, seed)
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
    %SN.n(i).rleft = 0;  % rounds left for node to become available for Cluster Head election
    %SN.n(i).dnc = 0;	% nodes distance from the cluster head of the cluster in which he belongs
    SN.n(i).dnb = sqrt( (dims('bs_x')-SN.n(i).x)^2 + (dims('bs_y')-SN.n(i).y)^2 );    % nodes distance from the base station
    %SN.n(i).chelect = 0;	% states how many times the node was elected as a Cluster Head
    %SN.n(i).rnd_chelect = 0;     % round node got elected as cluster head
    %SN.n(i).chid = 0;   % node ID of the cluster head which the "i" normal node belongs to
    
end

%% Building the mobile sinks

for i=1:sink_nodes
        
    if seed ~= false
        rng(i_seed);
        i_seed = i_seed + 1;
    end

    SN.n(i).id = nodes-sink_nodes+i;	% sensor's ID number
    SN.n(i).x = rand(1,1)*dims('x_max');	% X-axis coordinates of sensor node
    SN.n(i).y = rand(1,1)*dims('y_max');	% Y-axis coordinates of sensor node
    SN.n(i).E = inf;     % nodes energy levels (initially set to be equal to "ener('init')"
    SN.n(i).role = 'S';   % node acts as normal if the value is 'N', if elected as a priority node it  gets the value 'P' (initially all nodes are normal). Nodes can also be designed as sink => 'S'
 
end

end

