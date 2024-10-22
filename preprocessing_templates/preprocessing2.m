% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/realignment.m',
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/slice.m',
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/coregister.m',
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/normalization.m',
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/smoothing.m',
};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

delete('r*.nii');
delete('a*.nii');
delete('w*.nii');

newfolder = '/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/preprocessed1';
mkdir(newfolder);
movefile('/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/swrar*.nii',newfolder);