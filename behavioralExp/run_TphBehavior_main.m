% This program is to plot Tph behaviors for Opto-fMRI experiments
%
%
%
%
%
% by Hiro Taiyo Hamada, 2020/09/29th, 

% data loading
TPH4F = load('Tph4-2_Fixed.mat');
TPH4R = load('Tph4-2_Random.mat');
TPH10F = load('Tph10_Fixed.mat');
TPH10R = load('Tph10_Random.mat');
TPH11F = load('Tph11_Fixed.mat');
TPH11R = load('Tph11_Random.mat');
WT1F = load('WT1-2_Fixed.mat');
WT1R = load('WT1-2_Random.mat');
WT8F = load('WT8_Fixed.mat');
WT8R = load('WT8_Random.mat');

% ranksum, individual fixed and random, Tphskk
[p_tph4f,sig_tph4f] = ranksum(TPH4F.Tph4_Blue, TPH4F.Tph4_Yellow);
[p_tph4r,sig_tph4r] = ranksum(TPH4R.Tph4_Blue, TPH4R.Tph4_Yellow);
[p_tph10f,sig_tph10f] = ranksum(TPH10F.Tph10_Blue, TPH10F.Tph10_Yellow);
[p_tph10r,sig_tph10r] = ranksum(TPH10R.Tph10_Blue, TPH10R.Tph10_Yellow);
[p_tph11f,sig_tph11f] = ranksum(TPH11F.Tph11_Blue, TPH11F.Tph11_Yellow);
[p_tph11r,sig_tph11r] = ranksum(TPH11R.Tph11_Blue, TPH11R.Tph11_Yellow);

% ranksum, individual fixed and random, WT
[p_WT1f,sig_WT1f] = ranksum(WT1F.WT1_Blue, WT1F.WT1_Yellow);
[p_WT1r,sig_WT1r] = ranksum(WT1R.WT1_Blue, WT1R.WT1_Yellow);
[p_WT8f,sig_WT8f] = ranksum(WT8F.WT8_Blue, WT8F.WT8_Yellow);
[p_WT8r,sig_WT8r] = ranksum(WT8R.WT8_Blue, WT8R.WT8_Yellow);

diffTPH4F = mean(TPH4F.Tph4_Blue) - mean(TPH4F.Tph4_Yellow);
diffTPH10F = mean(TPH10F.Tph10_Blue) - mean(TPH10F.Tph10_Yellow);
diffTPH11F = mean(TPH11F.Tph11_Blue) - mean(TPH11F.Tph11_Yellow);
diffWT1F = mean(WT1F.WT1_Blue) - mean(WT1F.WT1_Yellow);
diffWT8F = mean(WT8F.WT8_Blue) - mean(WT8F.WT8_Yellow);

ranksum([diffTPH4F, diffTPH10F, diffTPH11F], [diffWT1F, diffWT8F]);

diffTPH4R = mean(TPH4R.Tph4_Blue) - mean(TPH4R.Tph4_Yellow);
diffTPH10R = mean(TPH10R.Tph10_Blue) - mean(TPH10R.Tph10_Yellow);
diffTPH11R = mean(TPH11R.Tph11_Blue) - mean(TPH11F.Tph11_Yellow);
diffWT1R = mean(WT1R.WT1_Blue) - mean(WT1R.WT1_Yellow);
diffWT8R = mean(WT8R.WT8_Blue) - mean(WT8R.WT8_Yellow);

ranksum([diffTPH4R, diffTPH10R, diffTPH11R], [diffWT1R, diffWT8R]);

ntph4bf = length(TPH4F.Tph4_Blue);
ntph4yf = length(TPH4F.Tph4_Yellow);
ntph10bf = length(TPH10F.Tph10_Blue);
ntph10yf = length(TPH10F.Tph10_Yellow);
ntph11bf = length(TPH11F.Tph11_Blue);
ntph11yf = length(TPH11F.Tph11_Yellow);
nwt1bf = length(WT1F.WT1_Blue);
nwt1yf = length(WT1F.WT1_Yellow);
nwt8bf = length(WT8F.WT8_Blue);
nwt8yf = length(WT8F.WT8_Yellow);

ntph4br = length(TPH4R.Tph4_Blue);
ntph4yr = length(TPH4R.Tph4_Yellow);
ntph10br = length(TPH10R.Tph10_Blue);
ntph10yr = length(TPH10R.Tph10_Yellow);
ntph11br = length(TPH11R.Tph11_Blue);
ntph11yr = length(TPH11R.Tph11_Yellow);
nwt1br = length(WT1R.WT1_Blue);
nwt1yr = length(WT1R.WT1_Yellow);
nwt8br = length(WT8R.WT8_Blue);
nwt8yr = length(WT8R.WT8_Yellow);

% data management, fixed time waiting
ndata = 0;
for ii = ndata+1:ndata+ntph4bf,
    subject_label{ii,:} = 'Trans04';
    waitingdata(ii, 1) = TPH4F.Tph4_Blue(ii-ndata);
    waitingtype{ii, :} = 'blue';
end

ndata = ndata + ntph4bf;
for ii = ndata+1:ndata+ntph4yf,
    subject_label{ii,:} = 'Trans04';
    waitingdata(ii,1) = TPH4F.Tph4_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + ntph4yf;
for ii = ndata+1:ndata+ntph10bf,
    subject_label{ii,:} = 'Trans10';
    waitingdata(ii,1) = TPH10F.Tph10_Blue(ii-ndata);
    waitingtype{ii, :} = 'blue';
end

ndata = ndata + ntph10bf;
for ii = ndata+1:ndata+ntph10yf,
    subject_label{ii,:} = 'Trans10';
    waitingdata(ii,1) = TPH10F.Tph10_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + ntph10yf;
for ii = ndata+1:ndata+ntph11bf,
    subject_label{ii,:} = 'Trans11';
    waitingdata(ii,1) = TPH11F.Tph11_Blue(ii-ndata);
    waitingtype{ii,:} = 'blue';
end

ndata = ndata + ntph11bf;
for ii = ndata+1:ndata+ntph11yf,
    subject_label{ii,:} = 'Trans11';
    waitingdata(ii,1) = TPH11F.Tph11_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + ntph11yf;
for ii = ndata+1:ndata+nwt1bf,
    subject_label{ii,:} = 'WT01';
    waitingdata(ii,1) = WT1F.WT1_Blue(ii-ndata);
    waitingtype{ii,:} = 'blue';
end

ndata = ndata + nwt1bf;
for ii = ndata+1:ndata+nwt1yf,
    subject_label{ii,:} = 'WT01';
    waitingdata(ii,1) = WT1F.WT1_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + nwt1yf;
for ii = ndata+1:ndata+nwt8bf,
    subject_label{ii,:} = 'WT08';
    waitingdata(ii,1) = WT8F.WT8_Blue(ii-ndata);
    waitingtype{ii,:} = 'blue';
end

ndata = ndata + nwt8bf;
for ii = ndata+1:ndata+nwt8yf,
    subject_label{ii,:} = 'WT08';
    waitingdata(ii,1) = WT8F.WT8_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

% plotting, fixed time wating
clear g
g(1,1)=gramm('x',subject_label,'y',waitingdata,'color',waitingtype);
g(1,1).set_names('x','Subjects','y','Waiting Time (s)','color','# Stim');

%Jittered scatter plot
g(1,1).stat_violin('half',true,'normalization','count','width',1,'fill','transparent');
g(1,1).set_title('''half'',true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title('Fixed time waiting', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();

% data management, random time waiting
ndata = 0;
for ii = ndata+1:ndata+ntph4br,
    subject_label{ii,:} = 'Trans04';
    waitingdata(ii, 1) = TPH4R.Tph4_Blue(ii-ndata);
    waitingtype{ii, :} = 'blue';
end

ndata = ndata + ntph4bf;
for ii = ndata+1:ndata+ntph4yr,
    subject_label{ii,:} = 'Trans04';
    waitingdata(ii,1) = TPH4R.Tph4_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + ntph4yr;
for ii = ndata+1:ndata+ntph10br,
    subject_label{ii,:} = 'Trans10';
    waitingdata(ii,1) = TPH10R.Tph10_Blue(ii-ndata);
    waitingtype{ii, :} = 'blue';
end

ndata = ndata + ntph10br;
for ii = ndata+1:ndata+ntph10yr,
    subject_label{ii,:} = 'Trans10';
    waitingdata(ii,1) = TPH10R.Tph10_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + ntph10yr;
for ii = ndata+1:ndata+ntph11br,
    subject_label{ii,:} = 'Trans11';
    waitingdata(ii,1) = TPH11R.Tph11_Blue(ii-ndata);
    waitingtype{ii,:} = 'blue';
end

ndata = ndata + ntph11br;
for ii = ndata+1:ndata+ntph11yr,
    subject_label{ii,:} = 'Trans11';
    waitingdata(ii,1) = TPH11R.Tph11_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + ntph11yr;
for ii = ndata+1:ndata+nwt1br,
    subject_label{ii,:} = 'WT01';
    waitingdata(ii,1) = WT1R.WT1_Blue(ii-ndata);
    waitingtype{ii,:} = 'blue';
end

ndata = ndata + nwt1br;
for ii = ndata+1:ndata+nwt1yr,
    subject_label{ii,:} = 'WT01';
    waitingdata(ii,1) = WT1R.WT1_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

ndata = ndata + nwt1yr;
for ii = ndata+1:ndata+nwt8br,
    subject_label{ii,:} = 'WT08';
    waitingdata(ii,1) = WT8R.WT8_Blue(ii-ndata);
    waitingtype{ii,:} = 'blue';
end

ndata = ndata + nwt8br;
for ii = ndata+1:ndata+nwt8yr,
    subject_label{ii,:} = 'WT08';
    waitingdata(ii,1) = WT8R.WT8_Yellow(ii-ndata);
    waitingtype{ii,:} = 'yellow';
end

% plotting, random time waiting
clear g
g(1,1)=gramm('x',subject_label,'y',waitingdata,'color',waitingtype);
g(1,1).set_names('x','Subjects','y','Waiting Time (s)','color','# Stim');

%Jittered scatter plot
g(1,1).stat_violin('half',true,'normalization','count','width',1,'fill','transparent');
g(1,1).set_title('''half'',true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

%g.set_title('Random time waiting', 'FontSize', 15);
g.set_title('Random time waiting', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
