close all;
clc;
clear;

%% Simulation Details

% Initialization Inputs
max_dimension = 100; % Maximum Dimension of the WSN Plot

initial_energy = 500e-3; % Initial node energy
transceiver_energy = 50e-9; % Energy Required for transmission and receiving of packet
ener_amp = false; % Amplification Energy
ener_agg = false; % Aggregation Energy

% Parameter Initialization
[dims, ener] = param_init(max_dimension, initial_energy, transceiver_energy, ener_agg, ener_amp);

% Simulation Parameters
n = 104; % Number of nodes
sn = 1; % Number of mobile sink
ms_radius = 30;
rounds = 150; % Number of rounds per simulation
sim = 3; % Number of simulations
k = 80000; % Bits transmitted per packet

% Clustering Paramters
n_clusters=4; % Percentage of cluster heads

%% Initialization of the WSN
[initial_SN, ms_ids] = createWSN(n, sn, dims, ener('init'));

%% Smiluation of the WSN
[SN, round_params, sim_params] = simulation_rounds(rounds, initial_SN, ener, k, ms_ids, ms_radius, n_clusters);

%% Lifetime and Stability Periods.

fprintf('\n\nSimulation Summary\n')
fprintf('Stability Period: %d\n', round(round_params('stability period'), 2))
fprintf('Stability Period Round: %d\n', round_params('stability period round'))
fprintf('Lifetime: %d\n', round(round_params('lifetime'), 2))
fprintf('Lifetime Round: %d\n', round_params('lifetime round'))