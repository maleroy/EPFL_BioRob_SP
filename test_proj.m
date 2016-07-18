function test_proj(filename)
    
    load(filename);
    tab = tab_best(filename);
    
%     if filename == 'pso_1.3-FBL.1.db.mat'
%         best = 98;
%         error_color = 'r';
%         marker_color = 'rx';
% 
%     elseif filename == 'pso_1.3-FBL.3.db.mat'
%         best = 98;
%         error_color = 'b';
%         marker_color = 'bx';
%         
%     elseif filename == 'pso_1.3-FBL.4.db.mat'
%         best = 94;
%         error_color = 'g';
%         marker_color = 'gx';    
%     
%     elseif filename == 'pso_1.3-FBL.5.db.mat'
%         best = 92;
%         error_color = 'g';
%         marker_color = 'cx';    
    
    if filename == 'pso_1.3-FBL_DES.1.db.mat'
        best = 95;
        error_color = 'r';
        marker_color = 'rx';    

    elseif filename == 'pso_1.3-FBL_DSE.1.db.mat'
        best = 75;
        error_color = 'g';
        marker_color = 'gx';    
        
    elseif filename == 'pso_1.3-FBL_EDS.1.db.mat'
        best = 3;
        error_color = 'b';
        marker_color = 'bx';    
        
    elseif filename == 'pso_1.3-FBL_ESD.1.db.mat'
        best = 82;
        error_color = 'y';
        marker_color = 'yx';    
        
    elseif filename == 'pso_1.3-FBL_SDE.1.db.mat'
        best = 94;
        error_color = 'c';
        marker_color = 'cx';    
        
    elseif filename == 'pso_1.3-FBL_SED.1.db.mat'
        best = 94;
        error_color = 'k';
        marker_color = 'kx';    

    else
        return;
    end
    
    
    for i = 1:1:100
        params(i,:) = squeeze(parameter_values(i,tab(i),:));
        fits(i,:) = squeeze(fitness_values(i,tab(i),:));
    end

    fig = figure(1);
    subfig1 = subplot(2,1,1);
    hold on;
    for i = 1:1:37
        means(i) = mean(params(:,i));
        stds(i) = std(params(:,i));
        errorbar(i,means(i),stds(i),error_color,'LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','w');
        plot(i,params(best,i),marker_color,'MarkerSize',10);
    end
    title('Parameters values');
    hold off;

    names = names_fct();
    subfig1.XTick = 1:1:37;
    subfig1.XTickLabel = names;
    subfig1.XTickLabelRotation = 45;
    grid on;
    
    
    subfig2 = subplot(2,1,2);
    hold on;
    for i = 1:1:59
        means_fit(i) = mean(fits(:,i));
        stds_fit(i) = std(fits(:,i));
        errorbar(i,means_fit(i),stds_fit(i),error_color,'LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','w');
        plot(i,fits(best,i),marker_color,'MarkerSize',10);
    end
    hold off;
    title('Fitness parameters values');
    axis([0 60 -2 2]);
    
    names_fit = names_fit_fct;
    subfig2.XTick = 1:1:59;
    subfig2.XTickLabel = names_fit;
    subfig2.XTickLabelRotation = 45;
    grid on;
    
end