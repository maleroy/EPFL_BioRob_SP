%Plots parameters after different exp_stagePSO.xml optimizations
function proj_plots()
    close all
%     % 1st test with fitness = distance
%     test_proj('pso_1.3-FBL.1.db.mat');
%     
%     % 1st test with fitness = distance - 10*abs(desired_duration-duration)
%     % - abs(desired_energy-energy)/1000 - abs(torque_sum/1000)
%     test_proj('pso_1.3-FBL.3.db.mat');
%     
%     % 1st test with fitness = distance - 10*abs(desired_duration-duration)
%     % - abs(desired_energy-energy)/1000 - abs(torque_sum/1000) and all
%     % commented extensions active    
%     test_proj('pso_1.3-FBL.4.db.mat');
%     
%     % 1st test with fitness = -energy
%     %test_proj('pso_1.3-FBL.5.db.mat');
    
    %test_proj('pso_1.3-FBL_DES.1.db.mat');
    %test_proj('pso_1.3-FBL_DSE.1.db.mat');
    
    %test_proj('pso_1.3-FBL_EDS.1.db.mat');
    %test_proj('pso_1.3-FBL_ESD.1.db.mat');
    
    test_proj('pso_1.3-FBL_SDE.1.db.mat');
    test_proj('pso_1.3-FBL_SED.1.db.mat');
    
    fig1 = figure(1);
    set(fig1,'OuterPosition',[10 40 1420 850]);
    
    subfig1 = subplot(2,1,1);
    set(subfig1,'Position',[0.02 0.6 0.96 0.36]);
    
    subfig2 = subplot(2,1,2);
    set(subfig2,'Position',[0.02 0.1 0.96 0.36]);
    
end