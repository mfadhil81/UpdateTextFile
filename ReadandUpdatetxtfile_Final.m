clc
clear all
%-----------------------------------------------------------------------------
%----------Read The New values from file_ID and save them as xyz vectors-------------------
%Read File_ID-----------The New values -----------------------------------------
fid = fopen('file_ID.txt','r');                        %# Open the file
data = textscan(fid,'%s %s %s','CollectOutput',true);  %# Read the data as strings
fclose(fid);                                        %# Close the file
data = cellfun(@str2num,data{1},'UniformOutput',false);  %# Convert to numbers
data(any(cellfun('isempty',data),2),:) = [];        %# Remove empty cells
data = cell2mat(data);    
x=data(:,1);y=data(:,2);z=data(:,3);
%-------------------% Read orginal txt and update it and save the new txt file in
%------------------------- into new name 
%cell A--------------------------------------
for g=1:80
fid = fopen('HG06.txt','r');% open the orginal file
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
fclose(fid);

% Change cells {VOIPositionSag, VOIPositionCor and VOIPositionTra} by 
% new value that have read by first block.(above)
%------Change X value----------------------
formatSpec = 'VOIPositionSag:%d';
K1 = x(g);
A{1,66} = sprintf(formatSpec,K1);
%------Change Y value----------------------
formatSpec = 'VOIPositionCor:%d';
K2 = y(g);
A{1,67} = sprintf(formatSpec,K2);
%------Change Z value----------------------
formatSpec = 'VOIPositionTra:%d';
K3 = z(g);
A{1,68} = sprintf(formatSpec,K3);
%----------------------------------------------------------
%----------------save it new update in txt file----------
% Write cell A into txt
% Read charctors array involve names form HG1 to HG80
names = regexp(fileread('names.txt'), '\r?\n', 'split');
HG=names{g} ;
 
fid = fopen(HG,'w');

for i = 1:numel(A)
    if A{i+1} == -1
        fprintf(fid,'%s', A{i});
        break
    else
        fprintf(fid,'%s\n', A{i});
    end
end

fclose (fid);
end
