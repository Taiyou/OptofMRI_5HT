tasks = {
%'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/preprocessing2.m',
%'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-2/preprocessing2.m',
%'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-3/preprocessing2.m',
%'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-5/run-1/preprocessing2.m',
%'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-5/run-2/preprocessing2.m',
%'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-5/run-3/preprocessing2.m',
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-8/run-1/preprocessing2.m',
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-9/run-1/preprocessing2.m'
};

for ii = 1:length(tasks)
	run(tasks{ii})
end