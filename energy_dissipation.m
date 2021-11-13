function [SN, round_params] = energy_dissipation(SN, round, ms_path, sel_ms_path, pn_ids, energy, k, round_params)
%SN, round, dims, energy, k, round_params, method
%ENERGY_DISSIPATION Energy dissipation function for the WSN
%   This function evaluates the energy dissipated in the sensor nodes
%   during the transmission netween the nodes to the base station of the
%   network
%
%   INPUT PARAMETERS
%   SN - all sensors nodes (including routing routes)
%   CLheads - number of cluster heads elected.
%   round - the current round in the simulation.
%   dims - container of the dimensions of the WSN plot extremes and the
%           base station point. outputs: x_min, x_min, y_min, x_max, y_max, 
%           bs_x, bs_y.
%   ener - container of the energy values needed in simulation for the
%           transceiver, amplification, aggregation. Outputs: init, tran,
%           rec, amp, agg.
%   rn_ids - ids of all sensor nodes used for routing
%   k - the number of bits transfered per packet
%   round_params - container of the parameters used to measure the
%                   performance of the simulation in a round. The params
%                   are: 'dead nodes', 'operating nodes', 'total energy', 
%                   'packets', 'stability period', 'lifetime', 
%                   'stability period round', 'lifetime round'.
%   method - the approach used in the transfer of data from normal nodes to
%               the base station. The available parameters are: 'force CH'
%               and 'shortest'. Default: 'force CH'. 'force CH' compels the
%               nodes to pass through a channel head. 'shortest' searches
%               for the minimum energy dissipation route.
%
%   OUTPUT PARAMETERS
%   SN - all sensors nodes (including routing routes)
%   round_params - container of the parameters used to measure the
%                   performance of the simulation in a round. The params
%                   are: 'dead nodes', 'operating nodes', 'total energy', 
%                   'packets', 'stability period', 'lifetime', 
%                   'stability period round', 'lifetime round'.


for path = 1:length(ms_path)
    if ismember(path, sel_ms_path)
        pn_id = pn_ids(sel_ms_path==path);
        
        for i = 1:length(SN.n)
            
            % Packet Transfer for Nodes in Given Cluster
            if (SN.n(i).pn_id == pn_id) && strcmp(SN.n(i).cond,'A') && strcmp(SN.n(i).role, 'N')
                
                if SN.n(i).E > 0 % Verification that node is alive
                    ETx = energy('tran')*k + energy('amp') * k * SN.n(i).dnp^2;
                    SN.n(i).E = SN.n(i).E - ETx;
                    round_params('total energy') = round_params('total energy') + ETx;

                    % Dissipation for priority node during reception
                    if SN.n(SN.n(i).pn_id).E > 0 && strcmp(SN.n(SN.n(i).pn_id).cond, 'A') && strcmp(SN.n(SN.n(i).pn_id).role, 'P')
                        ERx=(energy('rec') + energy('agg'))*k;
                        round_params('total energy') = round_params('total energy') + ERx;
                        SN.n(SN.n(i).pn_id).E = SN.n(SN.n(i).pn_id).E - ERx;
                        
                        if SN.n(SN.n(i).pn_id).E<=0  % if priority node energy depletes with reception
                            SN.n(SN.n(i).pn_id).cond = 'D';
                            SN.n(SN.n(i).pn_id).rop=round;
                            round_params('dead nodes') = round_params('dead nodes') + 1;
                            round_params('operating nodes') = round_params('operating nodes') - 1;
                        end
                    end
                end
                
                % Check for node depletion
                if SN.n(i).E<=0 % if nodes energy depletes with transmission
                    round_params('dead nodes') = round_params('dead nodes') + 1;
                    round_params('operating nodes') = round_params('operating nodes') - 1;
                    SN.n(i).cond = 'D';
                    SN.n(i).pn_id=0;
                    SN.n(i).rop=round;
                end
                
            end
        end
        
        % Packet Transmission to the Mobile Sink
        
        if strcmp(SN.n(pn_id).role, 'P') &&  strcmp(SN.n(pn_id).cond,'A')
            
            if SN.n(pn_id).E > 0
            
                ETx = energy('tran')*k + energy('amp') * k * SN.n(pn_id).dpnms^2;
                SN.n(pn_id).E = SN.n(pn_id).E - ETx;
                round_params('total energy') = round_params('total energy') + ETx;
                
                % Check for priority node depletion
                if SN.n(pn_id).E<=0 % if nodes energy depletes with transmission
                    round_params('dead nodes') = round_params('dead nodes') + 1;
                    round_params('operating nodes') = round_params('operating nodes') - 1;
                    SN.n(pn_id).cond = 'D';
                    SN.n(pn_id).pn_id=0;
                    SN.n(pn_id).rop=round;
                end
                
                % Energy Dissipation in Mobile Sink
                ms_id = SN.n(pn_id).ms_id;

                ERx=(energy('rec') + energy('agg'))*k;
                round_params('total energy') = round_params('total energy') + ERx;
                SN.n(ms_id).E = SN.n(ms_id).E - ERx;
                
                if SN.n(ms_id).E<=0  % if mobile sink energy depletes with reception
                    SN.n(ms_id).cond = 'D';
                    SN.n(ms_id).rop=round;
                    round_params('dead nodes') = round_params('dead nodes') + 1;
                    round_params('operating nodes') = round_params('operating nodes') - 1;
                end
                
            end
            
        end
        
    end
end

end

