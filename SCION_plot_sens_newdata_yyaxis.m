%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                               %
%              110111010                                                                        %
%           111010-1-----101                                                                    %
%        1011111---------101111                                                                 %
%      11011------------------101         SCION: Spatial Continuous Integration                 %
%     111-----------------10011011        Earth Evolution Model                                 %
%    1--10---------------1111011111                                                             %
%    1---1011011---------1010110111       Lead developer: Benjamin J. W. Mills                  %
%    1---1011000111----------010011       email: b.mills@leeds.ac.uk                            %
%    1----1111011101----------10101                                                             %
%     1----1001111------------0111        Sensitivity analysis plotting script                  %
%      1----1101-------------1101         CALLED IN SCRIPT - DO NOT RUN DIRECTLY                %
%        1--111----------------1                                                                %
%           1---------------1                                                                   %
%               111011011                                                                       %
%                                                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% define colours
% c_mean = [255 132 34]./255 ;
% c_std = [255 225 192]./255 ;
% c_range = [255 225 192]./255 ;
c_mean = [225 0 0]./255 ;
c_std = [250 192 192]./255 ;
c_range = [250 192 192]./255 ;

%%%% Proxy color chart
pc1 = [65 195 199]./255 ;
pc2 = [73 167 187]./255 ;
pc3 = [82 144 170]./255 ;
pc4 = [88 119 149]./255 ;
pc5 = [89 96 125]./255 ;
pc6 = [82 56 100]./255 ;

%%%% output to screen
fprintf('running sens plotting script... \t')
tic

%%%%%%% make figure
figure('Color',[0.80 0.80 0.70])

%%%% load geochem data
load('data/geochem_data_2020.mat')
load('data\Scotese_GAT_2021.mat')
load('Geo_data_J1_updated.mat')
load('Geo_data_J2_updated.mat')

%%%% make column vector
sens.time_myr = sens.time_myr(:,1) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Load NEW proxy datasets (optional): temperature curve + CO2 scatter
%%%%   - SCION time axis: 0 = present, negative = past (Ma)
%%%%   - Temperature file (curve): 2021.xlsx (columns: Age [Ma], GAT [°C])
%%%%   - CO2 file (scatter): CO2.xlsx (columns: age [kyr], co2 [ppmv], optional uncertainty)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% Forcings
subplot(5,2,1)
hold on
box on
xlabel('Time (Ma)')
ylabel('Forcings')
%%%% plot DEGASS
plot((sens.time_myr),nanmean(sens.DEGASS,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.DEGASS,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.DEGASS,[],2),'linewidth',0.5,'color',c_range)
%%%% plot GRAN_AREA
plot((sens.time_myr),nanmean(sens.GRAN_AREA,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.GRAN_AREA,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.GRAN_AREA,[],2),'linewidth',0.5,'color',c_range)
%%%% plot BAS_AREA
plot((sens.time_myr),nanmean(sens.BAS_AREA,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.BAS_AREA,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.BAS_AREA,[],2),'linewidth',0.5,'color',c_range)

%%%% d13C record
subplot(5,2,2)
hold on
box on
xlim([-203 -122])
xlabel('Time (Ma)')
ylabel('\delta^{13}C_{carb}')
%%%% plot data comparison
% plot(d13c_x,d13c_y,'.','color',pc2)
plot(dataJ2.Age, dataJ2.C_carb, 'b')
% plot(dataJ2.Age, dataJ2.C_carb, '.','Markersize', 16 ,'color',pc2)
%%%% plot this model
plot((sens.time_myr),nanmean(sens.delta_mccb,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.delta_mccb,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.delta_mccb,[],2),'linewidth',0.5,'color',c_range)

%%%% d34S record
subplot(5,2,3)
hold on
box on
xlabel('Time (Ma)')
ylabel('\delta^{34}S_{sw}')
%%%% plot data comparison
plot(d34s_x,d34s_y,'.','color',pc2)
%%%% plot this model
plot((sens.time_myr),nanmean(sens.d34s_S,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.d34s_S,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.d34s_S,[],2),'linewidth',0.5,'color',c_range)

%%%% Ocean 87Sr/86Sr 
subplot(5,2,4)
hold on
box on
ylim([0.706 0.71])
xlabel('Time (Ma)')
ylabel('^{87}Sr/^{86}Sr seawater')
%%%% plot data comparison
plot(sr_x,sr_y,'color',pc2)
%%%% plot this model
plot((sens.time_myr),nanmean(sens.delta_OSr,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.delta_OSr,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.delta_OSr,[],2),'linewidth',0.5,'color',c_range)

%%%% SO4
subplot(5,2,5)
hold on
box on
xlabel('Time (Ma)')
ylabel('Marine SO_{4} (mM)')
%%%% plot algeo data window comparison
plot(sconc_max_x,sconc_max_y,'color',pc1)
plot(sconc_min_x,sconc_min_y,'color',pc1)
plot(sconc_mid_x,sconc_mid_y,'color',pc2)
%%%% plot fluid inclusion data comparison
for u = 1:2:length(SO4_x-1)
   plot( [SO4_x(u) SO4_x(u)] , [SO4_y(u) SO4_y(u+1)], 'color' , pc3 ) ;     
end
%%%% plot this model
plot((sens.time_myr),nanmean(sens.SmM,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.SmM,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.SmM,[],2),'linewidth',0.5,'color',c_range)

%%%% O2 (%) 
subplot(5,2,6)
hold on
box on
xlabel('Time (Ma)')
ylabel('Atmospheric O_{2} (%)')
%%%% plot data comparison
for u = 1:2:length(O2_x) - 1
   plot( [O2_x(u) O2_x(u)] , [O2_y(u) O2_y(u+1)] , 'color' , pc2  ) ;     
end
%%%% plot this model
plot((sens.time_myr),nanmean(sens.mrO2.*100,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.mrO2.*100,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.mrO2.*100,[],2),'linewidth',0.5,'color',c_range)


%%%% CO2ppm
subplot(5,2,7)
set(gca, 'YScale', 'log')
hold on
box on
xlim([-203 -122])
ylim([100 10000])
xlabel('Time (Ma)')
ylabel('Atmospheric CO_{2} (ppm)')

%%% load NEW CO2 dataset
S = load('CO2_proxies_SCION_time.mat');

% SCION time
NEW_co2_time  = S.co2_time_myr(:);
NEW_co2_ppm   = S.co2_ppm(:);
NEW_co2_xline = S.co2_xline(:);
NEW_co2_yline = S.co2_yline(:);


% NEW_co2_time  = S.co2_age_Ma(:);
% NEW_co2_xline = -S.co2_xline(:);

hold on

if ~isempty(NEW_co2_time)
    % vertical uncertainty bars
    plot(NEW_co2_xline, NEW_co2_yline, '-', ...
         'Color', [0.7 0.7 0.7], ...
         'LineWidth', 0.5);

    % scatter points
    idx_pt = ~isnan(NEW_co2_time) & ~isnan(NEW_co2_ppm);
    plot(NEW_co2_time(idx_pt), NEW_co2_ppm(idx_pt), '.', ...
         'Color', [0 0.75 1], ...
         'MarkerSize', 12);

    % label
    try
        text(pars.whenstart/1e6 + 10, 120, 'NEW CO_2', ...
             'Color', [0.929 0.694 0.125]);
    catch
    end
end

box on

%%%% plot this model
plot((sens.time_myr),nanmean(sens.CO2ppm,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.CO2ppm,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.CO2ppm,[],2),'linewidth',0.5,'color',c_range)

% % Keep x-limits consistent with model output
% try
%     xlim([min(sens.time_myr) max(sens.time_myr)])
% catch
% end
% 
% % Use a COMMON y-range for BOTH axes (avoids misleading scaling)
% yl = [100 10000];
% try
%     mmin = min(sens.CO2ppm(:));
%     mmax = max(sens.CO2ppm(:));
%     if isfinite(mmin) && mmin > 0
%         yl(1) = min(yl(1), mmin);
%     end
%     if isfinite(mmax)
%         yl(2) = max(yl(2), mmax);
%     end
% catch
% end
% if ~isempty(NEW_co2_ppm)
%     yl(1) = min(yl(1), min(NEW_co2_ppm));
%     yl(2) = max(yl(2), max(NEW_co2_ppm));
% end
% yl(1) = max(yl(1), 1);          % log axis must be >0
% yl(2) = max(yl(2), yl(1)*10);    % avoid degenerate limits
% 
% % --- Right y-axis: NEW proxy CO2 dataset (scatter) ---
% yyaxis right
% set(gca, 'YScale', 'log')
% ylabel('CO_{2} proxies (ppm)')
% 
% % uncertainty (grey vertical bars)
% if ~isempty(NEW_co2_xline)
%     plot(NEW_co2_xline, NEW_co2_yline, 'Color', [0.75 0.75 0.75]);
% end
% 
% % scatter points (keep duplicates)
% if ~isempty(NEW_co2_time)
%     scatter(NEW_co2_time, NEW_co2_ppm, 10, 'filled', ...
%         'MarkerFaceColor', [0.929 0.694 0.125], 'MarkerEdgeColor', [0.929 0.694 0.125]);   %%%% [0 0.75 1] 
% end
% ylim(yl)
% 
% % --- Left y-axis: model CO2 (curves) ---
% yyaxis left
% set(gca, 'YScale', 'log')
% ylabel('Model atmospheric CO_{2} (ppm)')
% 
% hMean = plot((sens.time_myr),nanmean(sens.CO2ppm,2),'linewidth',1,'color',c_mean);
% hMax  = plot((sens.time_myr),max(sens.CO2ppm,[],2),'linewidth',0.5,'color',c_range);
% hMin  = plot((sens.time_myr),min(sens.CO2ppm,[],2),'linewidth',0.5,'color',c_range);
% 
% ylim(yl)
% 
% % curve on top, points underneath
% try
%     uistack(hMean,'top'); 
%     uistack(hMax,'top'); 
%     uistack(hMin,'top');
% catch
% end

%%%% TEMP
%%% load PhanDA GMST ensemble
S = load('PhanDA_GMST_ensemble.mat');
GMST = S.GMST;

NEW_gmst_time = -GMST.AverageAge(:);

NEW_gmst50 = cellfun(@(x) median(x(:)), GMST.ScenarioAll);
NEW_gmst16 = cellfun(@(x) prctile(x(:),16), GMST.ScenarioAll);
NEW_gmst84 = cellfun(@(x) prctile(x(:),84), GMST.ScenarioAll);

[NEW_gmst_time, idx] = sort(NEW_gmst_time);
NEW_gmst50 = NEW_gmst50(idx);
NEW_gmst16 = NEW_gmst16(idx);
NEW_gmst84 = NEW_gmst84(idx);

%%%%%%%%%%%%%%%%
subplot(5,2,8)
hold on
box on
xlim([-203 -122])
xlabel('Time (Ma)')
ylabel('GAST (C)')

%%%% plot data comparison
plot(Scotese_2021_age, Scotese_2021_GAT, 'color', pc1)

%%%% plot this model
plot((sens.time_myr),nanmean(sens.T_gast,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.T_gast,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.T_gast,[],2),'linewidth',0.5,'color',c_range)

% %%%% plot this model tropical T
% plot((sens.time_myr),nanmean(sens.SAT_tropical,2),'linewidth',1,'color',c_mean,'linestyle',':')
% plot((sens.time_myr),max(sens.SAT_tropical,[],2),'linewidth',0.5,'color',c_range,'linestyle',':')
% plot((sens.time_myr),min(sens.SAT_tropical,[],2),'linewidth',0.5,'color',c_range,'linestyle',':')
% 
% %%%% plot this model equatorial T
% plot((sens.time_myr),nanmean(sens.SAT_equator,2),'linewidth',1,'color',c_mean,'linestyle',':')
% plot((sens.time_myr),max(sens.SAT_equator,[],2),'linewidth',0.5,'color',c_range,'linestyle',':')
% plot((sens.time_myr),min(sens.SAT_equator,[],2),'linewidth',0.5,'color',c_range,'linestyle',':')

%%%% plot NEW temperature curve (PhanDA GMST)
if exist('NEW_gmst_time','var') && ~isempty(NEW_gmst_time)

    % uncertainty band
    patch([NEW_gmst_time; flipud(NEW_gmst_time)], ...
          [NEW_gmst16;  flipud(NEW_gmst84)], ...
          pc3, ...
          'FaceAlpha', 0.20, ...
          'EdgeColor', 'none');

    % median line
    plot(NEW_gmst_time, NEW_gmst50, ...
         'Color', pc3, ...
         'LineWidth', 1.5);

    try
        text(pars.whenstart/1e6 + 10, 38, 'PhanDA GMST', 'Color', pc3);
    catch
    end
end



%%%% ICE LINE
subplot(5,2,9)
hold on
box on
xlabel('Time (Ma)')
ylabel('Ice line')
%%%% plot iceline proxy
plot(paleolat_x,paleolat_y,'color' ,pc2) ;
%%%% plot this model
plot((sens.time_myr),nanmean(sens.iceline,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.iceline,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.iceline,[],2),'linewidth',0.5,'color',c_range)

%%%% P and N
subplot(5,2,10)
hold on
box on
xlabel('Time (Ma)')
ylabel('P (-), N (--)')
%%%% plot this model
plot((sens.time_myr),nanmean(sens.P,2),'linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.P,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.P,[],2),'linewidth',0.5,'color',c_range)
plot((sens.time_myr),nanmean(sens.N,2),'--','linewidth',1,'color',c_mean)
plot((sens.time_myr),max(sens.N,[],2),'--','linewidth',0.5,'color',c_range)
plot((sens.time_myr),min(sens.N,[],2),'--','linewidth',0.5,'color',c_range)


%%%%% plotting script finished
fprintf('Done: ')
endtime = toc ;
fprintf('time (s): %d \n', endtime )



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%   Cleanup workspace   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear stepnumber
clear u
clear numfields
clear trecords
clear finalrecord
clear field_names
clear n
clear veclength
clear xvec
clear yvec
clear endtime


%%%%% plotting script finished
fprintf('Done: ')
endtime = toc ;
fprintf('time (s): %d \n', endtime )
