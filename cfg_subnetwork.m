function subnetwork = cfg_subnetwork( patient_coordinates )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

[LN,RN] = find_subnetwork_coords(patient_coordinates);

%%%% 1) Left SOZ

 subnetwork.leftSOZ.nodes = LN;

%%%% 2) Right SOZ

subnetwork.rightSOZ.nodes = RN;

%%%% 3) From Left to Right SOZ

subnetwork.acrossSOZ.nodes.source = LN;
subnetwork.acrossSOZ.nodes.target = RN;

%%%% 4) Pre to post CG - left 

%%%% 5) Pre to post CG - right

%%%% 6) Upper pre to post CG - left

%%%% 7) Upper pre to post CG - right

%%%% 8) Superior temporal lobe - left

%%%% 9) SOZ + Superior temporal lobe



end



% fprintf('...computing dom pre-post SOZ coherence \n')
% [PreN,PostN,PrUp,PoUp] = find_subnetwork_prepost(pc);
% nodes.source = PreN;
% nodes.target = PostN;
% model.prepost = compute_soz_coherence(model,nodes);
% 
% fprintf('...computing dom pre-post in upper SOZ coherence \n')
% nodes.source = PrUp;
% nodes.target = PoUp;
% model.prepost_upper = compute_soz_coherence(model,nodes);
% 
% 
% fprintf('...computing dom pre & post SOZ coherence \n')
% model.prepost_all = compute_soz_coherence(model,[PreN; PostN]);
% 
% fprintf('...computing dom pre & post upper SOZ coherence \n')
% model.prepost_all_upper = compute_soz_coherence(model,[PrUp; PoUp]);
% 
% % ----- Find other pre to post coherence -----------------------------
% pc_temp =pc;
% hand = pc.hand;
% if strcmp(hand,'right')
%    pc_temp.hand = 'left';
% end
% 
% if strcmp(hand,'left')
%     pc_temp.hand = 'right';
% end
% 
% fprintf('...computing non dom pre-post SOZ coherence \n')
% [PreN,PostN,PrUp,PoUp] = find_subnetwork_prepost(pc_temp);
% nodes.source = PreN;
% nodes.target = PostN;
% model.prepost_nondom = compute_soz_coherence(model,nodes);
% 
% fprintf('...computing non dom pre-post in upper SOZ coherence \n')
% nodes.source = PrUp;
% nodes.target = PoUp;
% model.prepost_upper_nondom = compute_soz_coherence(model,nodes);
% 
% 
% fprintf('...computing non dom pre & post SOZ coherence \n')
% model.prepost_all_nondom = compute_soz_coherence(model,[PreN; PostN]);
% 
% fprintf('...computing non dom pre & post upper SOZ coherence \n')
% model.prepost_all_upper_nondom = compute_soz_coherence(model,[PrUp; PoUp]);
% 
% [ LNstl,~ ] = find_subnetwork_str( pc,'superiortemporal');
% fprintf('...computing SOZ to superior temporal lobe coherence left \n')
% nodes.source = LN;
% nodes.target = LNstl;
% model.phoneme_left =compute_soz_coherence(model,nodes);
% 
% fprintf('...computing within left superior temporal lobe coherence \n')
% model.left_stl =compute_soz_coherence(model,LNstl);


