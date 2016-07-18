function energy_over_dist_plotter(varargin)
    clc
    if nargin == 0
        error('Please provide some arguments.');
        
    else
        n = varargin{1};
        leg_in = varargin{2};
    end
    
    cst = 1;
    colors = jet(cst*size(n,2));
    
    for i = 1:1:size(n,2)
        if(isnumeric(n(i)))
            
            s1 = strcat('energy',num2str(n(i)));
            r1 = read_one_log(s1);
            s2 = strcat('distance',num2str(n(i)));
            r2 = read_one_log(s2);
            
            r = r1./r2;

            t = (1:1:size(r,2))./1000;

            idx = 2000;
            fig = figure(1);
            
            subplot(1,2,1);
            hold on;
            grid on;
            plot(t(idx:end),r(idx:end),'LineWidth',2,'Color',colors(cst*i,:));
            xlabel('Time [s]','Interpreter','Latex','FontSize',15);
            ylabel('$\frac{Energy}{Distance} [J \cdot m^{-1}]$','Interpreter','Latex','FontSize',15);
            leg1 = legend(leg_in{1:i});
            set(leg1,'Interpreter','Latex','Fontsize',12);
            
            subplot(1,2,2);
            hold on;
            grid on;
            plot(t(idx:end),r2(idx:end),'LineWidth',2,'Color',colors(cst*i,:));
            xlabel('Time [s]','Interpreter','Latex','FontSize',15);
            ylabel('Distance [m]','Interpreter','Latex','FontSize',15);
            leg2 = legend(leg_in{1:i},'Location','SouthEast');
            set(leg2,'Interpreter','Latex','Fontsize',12);
            
        else
            fprintf('Please give a correct log number.\n');
        end
    end
    
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,'Cost of Transport and distance evolutions','HorizontalAlignment','center','VerticalAlignment','top','Interpreter','Latex','Fontsize',20)
    set(fig,'Units','normalized','OuterPosition',[0.2 0.3 0.6 0.5])
end

function rawdata = read_one_log(text)
    fileID = fopen(text,'r');
    params = fgets(fileID);  % Gets first line
    
    rawdata = fscanf(fileID, '%f', [1 inf]);
end