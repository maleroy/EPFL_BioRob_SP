function energy_over_dist_plotter(varargin)
    close all
    clc
    if nargin == 0
        n = 10:1:16;
    else
        n = varargin{1}; 
    end
    
    for i = 1:1:size(n,2)
        if(n(i)<17)
            s1 = strcat('energy',num2str(n(i)));
            r1 = read_one_log(s1);
            s2 = strcat('distance',num2str(n(i)));
            r2 = read_one_log(s2);

            r = r1./r2;

            t = (1:1:size(r,2))./1000;

            idx = 2000;
            figure(1);
            hold on;
            plot(t(idx:end),r(idx:end),'LineWidth',2);
            xlabel('Time [s]','Interpreter','Latex','FontSize',20);
            ylabel({'$\frac{Energy}{Distance}[J \cdot m^{-1}]$'},'Interpreter','Latex','FontSize',20);

        else
            fprintf('Please give a correct log number.\n');
        end
    end
    legend({'DES','DSE','SDE'},'Interpreter','Latex','FontSize',15);
    title({'Cost of Transport evolution'},'Interpreter','Latex','FontSize',25);
    grid on;
end

function rawdata = read_one_log(text)
    fileID = fopen(text,'r');
    params = fgets(fileID);  % Gets first line
    
    rawdata = fscanf(fileID, '%f', [1 inf]);
end