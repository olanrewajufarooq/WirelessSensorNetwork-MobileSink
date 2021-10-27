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
rn = 4; % Number of routing nodes
rounds = 100; % Number of rounds per simulation
sim = 3; % Number of simulations
k = 80000; % Bits transmitted per packet

% Clustering Paramters
p=0.05; % Percentage of cluster heads
