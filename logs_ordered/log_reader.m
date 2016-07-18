function log_reader(varargin)
    clc
    if(nargin~=0)
        if(isnumeric(varargin{1}))
            expression = ['ls *',num2str(varargin{1})];
            [status,list_logs]=system(expression);
            list_logs = strsplit(list_logs);
            list_logs = list_logs(1:end-1);
            n_logs = size(list_logs,2);
            
        elseif(iscellstr(varargin))
            list_logs = varargin;
            n_logs = nargin;
        end
        
        read_plot(list_logs,n_logs);
    
    else
        fprintf('Please give at least one valid log file.\n');
    end
end

function read_plot(list_logs,n_logs)
    for i = 1:1:n_logs
        text = list_logs{i};
        fprintf('Reading file %s...\n',text);
        [num_params, rawdata, array_params,swtch] = read_one_log(text);
        if(swtch == 1 && size(rawdata,2) ~= 0)
            fig_hdl = figure(i);
            set(fig_hdl,'units','normalized','position',[0 0 1 1]);
            subplot(1,2,1)
%             subplot(2,3,[1,2]);
            fprintf('Plotting file %s...\n',text);
            plotter_params(num_params, rawdata, array_params,text);
            %save('test1.mat');
            subplot(1,2,2)
%             subplot(2,3,[4,5]);
            fft_plotter(num_params, rawdata, array_params,text);
%             ax = subplot(2,3,[3,6]);
%             annotation('textbox',ax.Position,'String',array_params,'Interpreter','Latex','FitBoxToText','on');
%             axis off
        else
            fprintf('File %s was empty.\n',text);
        end
    end
end

function [num_params, rawdata, array_params,swtch] = read_one_log(text)
    fileID = fopen(text,'r');
    params = fgets(fileID);  % Gets first line

    if(size(params,2) ~= 1)
        swtch = 1;
        array_params = get_array_params(params);

        num_params = size(array_params,2);

        str = [];
        [str, array_params] = rename_strings_latex(str, array_params, num_params);

        rawdata = fscanf(fileID, str, [num_params inf]);
    else
        swtch = 0;
        array_params = 0;
        num_params = 0;
        rawdata=0;
    end
end

function array = get_array_params(params)
    array = strsplit(params);
    array = array(1:end-1);
end

function [str, array_params] = rename_strings_latex(str, array_params, num_params)
    for i = 1:1:num_params
        str= [str '%f '];
        char_param = char(array_params(i));
        char_param = strrep(char_param,'__','_');
        
        char_idx_num = size(strfind(char_param,'_'),2);
        char_param = strrep(char_param,'_','_{');
        char_end = [];
        for j=1:1:char_idx_num
            char_end = [char_end '}'];
        end
        char_param = [char_param char_end];
        
        array_params(i) = cellstr(char_param);
        array_params(i) = strcat('$',array_params(i),'$');
    end
end

function plotter_params(num_params, rawdata, array_params, text)
    colors = winter(num_params);
    
    t = (1:1:size(rawdata,2))./1000; % To have time in [s]
    
    hold on;
    for i = 1:1:num_params 
        hdl(i) = plot(t,rawdata(i,:),'Color',colors(i,:));
    end
    hold off;
    title('Temporal evolution of different signals','Interpreter','Latex');
   
    legend(array_params,'Interpreter','Latex');
    %gridLegend(hdl,3,array_params,'Interpreter','Latex');
    xlabel('Time step [s]','Interpreter','Latex')
    
    char_idx = strfind(text,'_');
    if(size(char_idx)==[1 1])
        char_less = text(1:1:char_idx);
        char_more = ['{',text(char_idx+1:1:end),'}'];
        text = [char_less,char_more];
    end
    text_y = strcat(text,' [p.u.]');
    ylabel(text_y)
    %axis([0 10 -inf inf])
end

function fft_plotter(num_params, rawdata, array_params, text)
    colors = winter(num_params);
    
    L = size(rawdata,2);
    if(mod(L,2)==1)
        rawdata = rawdata(:,1:end-1);
        L = L-1;
    end
    
    Y = zeros(num_params,L);
    P2 = zeros(num_params,L);
    P1 = zeros(num_params,L/2+1);
    f = (0:(L/2));
        
    hold on;
    for i=1:1:num_params
        Y(i,:) = fft(rawdata(i,:));
        P2(i,:) = abs(Y(i,:)/L);
        P1(i,:) = P2(i,1:L/2+1);
        
        P1(i,2:end-1) = 2*P1(i,2:end-1);
        plot(f,P1(i,:),'Color',colors(i,:));
    end
    mean_sig = mean(P1,1);
    [max_sig,max_idx] = max(mean_sig(2:end));
    plot(f,mean_sig,'-g','LineWidth',2)
    title('Single-Sided Amplitude Spectrum (FFT) of different signals','Interpreter','Latex');
    array_params2 = array_params;
    array_params2{end+1} = ['$Mean\ Signal\ with\ main\ frequency\ at\ ',num2str(max_idx),'[kHz]$'];
    legend(array_params2,'Interpreter','Latex');
    xlabel('f (kHz)','Interpreter','Latex');
    
    char_idx = strfind(text,'_');
    if(size(char_idx)==[1 1])
        char_less = text(1:1:char_idx);
        char_more = ['{',text(char_idx+1:1:end),'}'];
        text = [char_less,char_more];
    end
    text_y = strcat({'|P1(f)| '},text);
    ylabel(text_y)
    
    axis([0 200 -inf inf]);
    hold off;    
end