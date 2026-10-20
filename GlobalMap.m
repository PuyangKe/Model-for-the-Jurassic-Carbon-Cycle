load("forcings\INTERPSTACK_1Ga_2025.mat");
load("data\SCION_gridstate");
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%   define colorbars   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% IPCC precip colorbar modified
IPCC_pre = [ 223 194 125 ;
246 232 195 ;
245 245 245 ;
199 234 229 ;
128 205 193 ;
53 151 143 ;
1 102 94 ;
0 60 48 ] ./ 255 ;

%%%% IPCC temp colorbar
IPCC_temp = flipud( [103 0 31 ;
178 24 43 ;
214 96 77 ;
244 165 130 ;
253 219 199 ;
247 247 247 ;
209 229 240 ;
146 197 222 ;
67 147 195 ;
33 102 172 ;
5 48 97 ]./ 255 ) ;

%%%% IPCC sequential
IPCC_seq = [255 255 204 ;
161 218 180 ;
65 182 196 ;
44 127 184 ;
37 52 148] ./ 255 ;

%%%% IPCC sequential 2
IPCC_seq_2 = [ 237 248 251 ;
179 205 227 ;
140 150 198 ;
136 86 167 ;
129 15 124 ] ./ 255 ;

%%%% Proxy color chart
pc1 = [65 195 199]./255 ;
pc2 = [73 167 187]./255 ;
pc3 = [82 144 170]./255 ;
pc4 = [88 119 149]./255 ;
pc5 = [89 96 125]./255 ;
pc6 = [82 56 100]./255 ;

%%%% greens
greens = [ 237 244 226 ;
   219 232 202 ;
   200 223 171 ;
   178 204 143 ;
   157 192 112 ;
   146 181 99 ;
   133 171 84 ;
   120 158 71 ;
   106 145 56 ;
   95 133 46 ;
   85 120 36 ;
   75 110 28 ;
   66 98 22 ;
   56 88 15]./ 255;
%% 
%%% plot Palaeogeography
% subplot (2,3,1)
% range = [-5000 5000];
% this_TOPO = gridstate.TOPO(:,:,22) ;
% % this_TOPO(this_TOPO<1) = NaN ;
% this_TOPO(gridstate.TOPO(:,:,22) == 0 ) = NaN ;
% m_proj('robinson','longitude',[-180 172.5],'latitude',[-86.6 86.6]);
% m_pcolor(INTERPSTACK.lon - 180,INTERPSTACK.lat,this_TOPO) ;
% m_grid('box','on','xticklabels','','yticklabels','','linestyle','-','gridcolor',[0.7 0.7 0.7],'ticklength',0)
% colormap(gca,cmap)
% clim([-5000 5000])
% axis off
% % title(ha(1), "Grid with 40*48");
% cmap = ttcmap([-5000 5000],'cmap','gmtrelief');
% colormap(gca,cmap)


hold on
grid on

%%
%%% plot Air Temp
figure
subplot (2,2,1)
range = [-40,40];
thisfield = gridstate.Tair(:,:,3);
thisfield(gridstate.land(:,:,3) == 0 ) = NaN ;
m_proj('robinson','longitude',[-180 172.5],'latitude',[-86.6 86.6]);
m_pcolor(INTERPSTACK.lon - 180,INTERPSTACK.lat,thisfield) ;
m_grid('box','on','xticklabels','','yticklabels','');
clim(range);
axis off
% title(ha(1), "Grid with 40*48");
colormap(gca, IPCC_temp );
clb = colorbar;
clb.Label.String = "Air Temperature ℃";
clb.Ticks = range(1):20:range(2);
% clb.Position = [0.05,0.76,0.025,0.18];
clb.FontSize = 10;
set(gca,"FontSize",8,"FontName","Times New Roman");


%%%
%%% plot Runoff
% figure
subplot (2,2,2)
range = [0,4];
thisfield   = gridstate.Q(:,:,3);
thisfield(gridstate.land(:,:,3) == 0 ) = NaN ;
m_proj('robinson','longitude',[-180 172.5],'latitude',[-86.6 86.6]);
m_pcolor(INTERPSTACK.lon - 180,INTERPSTACK.lat,log10(thisfield)) ;
% m_grid('box','on','xticklabels','','yticklabels','');
m_grid('box','on','xticklabels','','yticklabels','','linestyle','-','gridcolor',[0.7 0.7 0.7],'ticklength',0)
clim(range);
axis off
% title(ha(1), "Grid with 40*48");
colormap(gca, IPCC_pre );
clb = colorbar;
clb.Label.String = "Runoff (log mm/yr)";
clb.Ticks = range(1):1:range(2);
% clb.Position = [0.05,0.76,0.025,0.18];
clb.FontSize = 10;
set(gca,"FontSize",8,"FontName","Times New Roman");

%%
%%% plot Erosion
subplot (2,2,3)
range = [0,4];
thisfield   = gridstate.EPSILON(:,:,3);
thisfield(gridstate.land(:,:,3) == 0 ) = NaN ;
m_proj('robinson','longitude',[-180 172.5],'latitude',[-86.6 86.6]);
m_pcolor(INTERPSTACK.lon - 180,INTERPSTACK.lat,log10(thisfield)) ;
% m_grid('box','on','xticklabels','','yticklabels','');
m_grid('box','on','xticklabels','','yticklabels','','linestyle','-','gridcolor',[0.7 0.7 0.7],'ticklength',0)
clim(range);
axis off
% title(ha(1), "Grid with 40*48");
colormap(gca, IPCC_seq_2 );
clb = colorbar;
clb.Label.String = "Erosion (log t/km2/yr)";
clb.Ticks = range(1):1:range(2);
% clb.Position = [0.05,0.76,0.025,0.18];
clb.FontSize = 10;
set(gca,"FontSize",8,"FontName","Times New Roman");

%%
%%% plot Silw
subplot (2,2,4)
range = [0,2];
thisfield   = gridstate.Q(:,:,3);
thisfield(gridstate.land(:,:,3) == 0 ) = NaN ;
m_proj('robinson','longitude',[-180 172.5],'latitude',[-86.6 86.6]);
m_pcolor(INTERPSTACK.lon - 180,INTERPSTACK.lat,log10(thisfield)) ;
% m_grid('box','on','xticklabels','','yticklabels','');
m_grid('box','on','xticklabels','','yticklabels','','linestyle','-','gridcolor',[0.7 0.7 0.7],'ticklength',0)
clim(range);
axis off
% title(ha(1), "Grid with 40*48");
colormap(gca, IPCC_seq );
clb = colorbar;
clb.Label.String = "Silw (log t/km2/yr)";
clb.Ticks = range(1):1:range(2);
% clb.Position = [0.05,0.76,0.025,0.18];
clb.FontSize = 10;
set(gca,"FontSize",8,"FontName","Times New Roman");