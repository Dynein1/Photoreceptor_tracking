% Further kinetic analysis of trajectories previously read in with
% 'MSDforztrackingdata.m' and converted into matrix with
% 'ztrajectory_gen.m'
%
% Smoothens z positional data
% Calculates instantaneous velocities
% Calculates instantaneous accelerations
% Identifies rapid apical translocations within trajectories
%
% Written by Matteo Carandini, Dominic Aghaizu, Martha Robinson


%% Load the data set

WhichData = 2;

switch WhichData
    case 1
        load('nrlgfp_p1_dmso_pool.mat');
        ddd = cones24Jul;
    case 2
        load('nrl.gfp_p3_dmso_pool.mat');
        ddd = ztrajectories;
    otherwise
        disp('Huh?');
end

%% Digest the data set

ncells = size(ddd,1);
nsamples = size(ddd,2); 

% interpolate to get the missing values

xxx = nan(ncells,nsamples);
yyy = nan(ncells,nsamples);

for icell = 1:ncells
    x = find(isfinite(ddd(icell,:)));
    y = ddd(icell,x);
    xq = min(x):max(x);
    yq = interp1(x,y,xq,'linear');
    xxx(icell,xq) = xq;
    yyy(icell,xq) = yq;
end

% ( splinefit did not seem much better )

% filter to get rid of fast fluctuations

fff = filter( [1 1 1]/3, 1, yyy' )';
fff(:,[1:3 end-2:end]) = NaN;
fff = circshift(fff,[0 -1]);



%% The cell velocities, one by one

dyyy = diff(yyy,1,2)./10; % derivatives of unfiltered data,, divided by 10 to give um/min instead of um/10min
z = nan(ncells,1);
dyyy = horzcat(dyyy,z); % pad to original matrix length with NaN


dfff = diff(fff,1,2)./10; % derivatives filtered data, divided by 10 to give um/min instead of um/10min
z = nan(ncells,1);
dfff = horzcat(dfff,z); % pad to original matrix length with NaN

% Apply moving average filter to velocity data set to smoothen

windowsize = 4;
b = (1/windowsize)*ones(1,windowsize);
a = 1;
dim = 2; % to filter rows, not columns

dfff2 = filter(b,a,dfff,[],dim);
dfff2 = circshift(dfff2,[0 -1]);


%% The cell accelerations, one by one

d2fff = diff(dfff,1,2); % derivatives
z = nan(ncells,1);
d2fff = horzcat(d2fff,z); % pad to original matrix length with NaN

% Apply moving average filter to velocity data set to smoothen

windowsize = 4;
b = (1/windowsize)*ones(1,windowsize);
a = 1;
dim = 2; % to filter rows, not columns

d2fff2 = filter(b,a,d2fff,[],dim);
d2fff2 = circshift(d2fff2,[0 -1]);


%% Identifying the cells that show "rapid apical translocation"

% To identify trajectories that exhibit rapid apical nuclear translocation
% (threshold according to Star methods: <= -10um per 30min in apical
% direction;
% 
% first need to create trajectory matrix with positional changes  with 30
% min interval:
% fff3 = diffhigh(fff,3)        
% (note 'fff' needs to be padded with NaNs to contain equal # rows &
% columns
% 
% 'fff3' is then to be trimmed down to original size of fff --> then renamed:
% 'fff31'

jx = nan(ncells,90);
numjumps = zeros(ncells,1);
for icell = 1:ncells
    jumps = find(fff31(icell,:)<=-10);
    if any(jumps)
        jx(icell,1:length(jumps)) = jumps;
        numjumps(icell) = 1;
        for tp = 1: length(jumps)-1
            if jumps(tp+1) - jumps(tp) ~= 1
                numjumps(icell) =  numjumps(icell) + 1;
            end
        end
    end
end

%% extract z position at beginning of jump

 for q = 1:length(locator)
jumpz(q)= fff(locator(q,1),locator(q,2))
 end
%make index matrix (traj#,z) named locator