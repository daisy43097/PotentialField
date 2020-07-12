function [dU_total] = gradient_decent(q, qG, CB)
% attractive potential 
k_att = 1; % attractive gain
g_star = 3; % attractive threshold

if norm(q-qG) <= g_star
    dUatt = k_att * (q - qG);
else 
    dUatt = k_att * (q-qG) / norm(q-qG);
end 

% repaulsive potential 
k_rep = 50; % repulsive gain
q_star = 20; % repulsive threshold
dUrep = 0; %initialize repulsive potential

for i = 1:size(CB,2)
    obs = cell2mat(CB(i));
    [c] = ClosestPointOnSquareToPoint(obs, q);
    d = norm(q-c);
    
    if d <= q_star
        dqc = (q-c) / d;
        dUobs = k_rep * ((1/q_star) - (1/d)) * 1/d^2 * dqc;
    else
        dUobs = 0;
    end 
    dUrep = dUrep + dUobs;
end 

dU_total = dUatt + dUrep;