% List of open inputs
nrun = 1; % enter the number of runs here
jobfile = {
'/Users/hirotaiyohamada/Desktop/replication_optofMRI/sub-572/ses-4/run-1/dataseg_4Dto3D.m',
};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});