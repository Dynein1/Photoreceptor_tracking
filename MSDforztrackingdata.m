% Import data from trajectory file generated elsewhere (e.g. IMARIS)
% Calculates average MSD (AvMSD) and standard errors within population of specified
% trajectories (line 130) at given time lags.
%
% trajectory duration code was added at the end
%
% Written by Martha Robinson, Dominic Aghaizu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% GET DATA FROM XLS SPREADSHEET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Reads data from file according to standardised xls spreadsheet. 

%%Open and read in XLS spreadsheet%%%

warning('off'); %need this as get a lot of errors because don't have excel.

    directory='C:';

if ~exist('pathFlnm')
    currentDir=cd;
    cd(directory);
    [flnm path]=uigetfile({'*.xls' 'Excel data files (*.xls)'; '*.*' 'All Files (*.*)'},'Choose Data List');
    [temp, flnm, temp]=fileparts(flnm); %Strip extension
    cd(currentDir);
    clear currentDir temp
else
    [path, flnm, temp]=fileparts(pathFlnm); %Strip extension
    clear temp
end

[num,txt,raw] = xlsread([path,flnm, '.xls']);

pulledData = raw;

%readInData = raw(2:end, :);%Gets rid of headers

% for k = 1:length(readInData)
%     readInData{k,2} = datestr(readInData{k,2} + datenum('30-Dec-1899'), 'dd/mm/yy');%fixes dates from Excel Windows format to MATLAB format
% end

clear path flnm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pulledData = cell2mat(pulledData(2:end, 2:6));

%Pull out different trajectories (numbered)
trajectories = cell(max(pulledData(:, 1)), 1);
for k = 1:max(pulledData(1:end, 1))
    trajectories{k} = pulledData(pulledData(:,1) == k, :); %put in trajectory, frame number and x, y, z data
    
end

%Pull out the different analysis groups and analyse for the groups
nomore = 0;
while nomore == 0;
choice = questdlg('Add another file?', ...
	'Additional Files', ...
	'Yes','No','No');
switch choice
    case 'Yes'
        trajectories = getspreadsheetdata(trajectories, spreadsheetcounter);
        spreadsheetcounter = spreadsheetcounter+1;
    case 'No'
        %do nothing
        nomore = 1;
end
end
%Loop through trajectories

%Insert NaNs into dataset where there's nonconsecutive frame jumps
for k = 1:length(trajectories)
list = diff(trajectories{k}(:,2));
%want to insert right number of NaNs into matrix AFTER the location of a
%value greater than 1 in this list

for i = 1:sum(list)
    if list(i) > 1
        insert = ones(list(i)-1, 5)*NaN;
        insert(:,1) = trajectories{k}(1,1);
        trajectories{k} = [trajectories{k}(1:i,:); insert; trajectories{k}(i+1:end, :)];
        list = [list(1:i); insert(:,2); list(i+1:end)];
        %clear insert
    end 
end

clear list
end



%Loop through values & find the MSD at each timestep
%for each deltatn find the MSD for delta t:
MSD = cell(length(trajectories),1);
for k = 1:length(trajectories)
    
    maxtimestep = length(trajectories{k}) - 1;
    
    MSD{k} = zeros(maxtimestep,1);
    for j = 1:maxtimestep
    
        %pull out all points delta t apart
        counter = length(trajectories{k}(:,1)) - j;
        
        distancesq = zeros(counter,1);
        for p = 1:counter
            t1 = trajectories{k}(p, :);
            t2 = trajectories{k}(p+j,:);
            
            z1 = t1(5);
            z2 = t2(5);
                        
            
            %find distance between these points (not sqrting
            %because then need to immediately square for MSD formula
            distancesq(p) = ((z2-z1))^2;
        end
        
        %sum the sqaured euclidian distances at this time difference
        summed = nansum(distancesq);
        %times by 1/N-n (or the actual length of your pulled data - in this
        %case 'counter'
        MSD{k}(j) = summed*(1/counter);
    end
        

end

%%%%% Ananlysis

%Define group you want to analyse
group = [1, 2, 3];


newgroup = cell(length(group),1);

%Combine all the MSD values for each delta t from each individual
%trajectory & find the mean, to get the average MSD for each timestep for
%each dataset.
for k = 1:length(group)
    newgroup{k} = MSD{group(k)};
end

% Pad with NaN's so everything is as long as the longest entry
[cols, rows] = cellfun(@size, newgroup);
padto = max(cols);


AvMSD = zeros(padto, length(group));
for k = 1:length(group)
    l = length(MSD{group(k)});
    value = [MSD{group(k)}; zeros(padto-l,1)*NaN];
    AvMSD(:, k) = value;
end

%%Std error of mean
standarderrors = zeros(size(AvMSD,1),1);
for i = 1:size(AvMSD,1)
    standarderrors(i) = (nanstd(AvMSD(i, :)) / (sqrt(length(AvMSD(i,:)) - sum(isnan(AvMSD(i,:)))))) ; 
end
%%% Find the mean MSD at each timegap:
AvMSD = nanmean(AvMSD, 2);

% Determine duration of trajectory
duration = cellfun('length',trajectories (:,1))


