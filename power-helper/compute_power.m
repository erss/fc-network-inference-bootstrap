function model_region = compute_power( model,data)
% model_region = compute_power( model,nodes,data_cell)
% Computes power for group of nodes over time such that each node pair
% within group and all 1 s intervals are treated as trials.
%
% INPUTS:
% model = structure with network inference parameters
% node  = vector of indices for nodes for which to compute power
%
% OUTPUTS:
%   -- New 'model_zone' structure: --
% phi       = absolute value of mean phase over frequency bands where
%             coherence occurs [node x node x time]
% kC        = mean coherence over frequency bands for each signal pair and
%             at each moment of time [1 x time]
% kLo, kUp  = lower and upper bounds respectively on estimate of coherence
% f         = frequency axis

% 1. Remove artifacts & transform data into appropriate trial structure
band_params = cfg_band('power',model.sampling_frequency);
f0 = model.sampling_frequency;
T=band_params.movingwin(1);

%%% ---- Convert region into 1 s trials -------------------------
% data_clean = convert_to_trials( data', T*f0 );
% trialtemp = size(data_clean,2);
% for i = size(data_clean,2):-1:1 % remove any trial that contains a nan
%     dtemp = data_clean(:,i);
%     if any(isnan(dtemp)) % col contains at least one nan
%         data_clean(:,i)=[];
%     end
%
% end

data = data_clean';
model_region.ntrials = size(data_clean,2);
model_region.ntrials_removed = trialtemp-size(data_clean,2);

% 2. Load model parameters
model.band_params=band_params;

% 3. Compute power
params    = band_params.params;
movingwin = band_params.movingwin;                                   % ... Window size and step.
if ~isempty(data)
    [S,t,f,Serr]  = mtspecgramc(data,movingwin,params);
    
    total_power = nan(1,length(t));
    Srel = nan(size(S));
    sigma_bump = nan(1,length(t));
    for k = 1:length(t)
        model_region.sbratio    = mean(S(k,f<=15 &f>=10))/ mean(k,S(f<=30 &f>=15));
        
        total_power(k) = sum(S(k,:));
        
        Srel(k,:)= S(k,:)./total_power(k);
        
        
        Sfit = fit_line(f,Srel(k,:),10,15);
        sigma_bump(k) = compute_statistic( f,Srel(k,:),Sfit,10,15,'area' );
        
    end
    model_region.total_power = total_power;
    model_region.Srel = Srel;
    model_region.S    = S;
    model_region.f    = f;
    model_region.Serr = Serr;
    model_region.sigma_bump = sigma_bump;
else
    model_region.sbratio    = nan;
    model_region.total_power = nan;
    model_region.S    = nan;
    model_region.Srel = nan;
    model_region.f    = nan;
    model_region.Serr = nan;
    model_region.sigma_bump = nan;
    
end

end
