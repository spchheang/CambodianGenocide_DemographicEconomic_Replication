function Plot_PiH_3Cases(y_data, y_label, location, filename)
% Plot_PiH_3Cases Plots multiple series against a common x-axis (year).
% Inputs:
%   y_data   - cell array of y vectors (e.g., {y1, y2, y3})
%   y_label  - string for y-axis label
%   location - location of the legend
%   filename - name of the file to save as PDF (without extension)

    % Use global or workspace variable for x-axis
    if evalin('base', 'exist(''year'', ''var'')')
        year = evalin('base', 'year');
    else
        error('Variable "year" must be defined in the base workspace.');
    end

    % Legend labels (LaTeX formatting fixed)
    default_labels = {
        'Low case: $\pi^H=0.30$, $\pi^L=0.10$'; 
        'Med case: $\pi^H=0.60$, $\pi^L=0.06$'; 
        'High case: $\pi^H=0.80$, $\pi^L=0.03$'
    };

    % Plot styles
    colors = {[0.7 0 0], [0 0 0.5], [0 0.4 0]}; % red, dark blue, dark green
    markers = {'-*', '-o', '-p'};

    % Plotting
    figure;
    hold on;
    for i = 1:length(y_data)
        y_i = y_data{i};
        if size(y_i,1) > 1
            y_i = y_i';  % Transpose if it's a column vector
        end
        plot(year, y_i(1:14), markers{i}, 'Color', colors{i}, ...
            'MarkerFaceColor', colors{i}, 'MarkerSize', 3, 'LineWidth', 2, ...
            'DisplayName', default_labels{i});
    end
    %ylim padded;
    ylim([0.097,0.125]);
    xlabel('Year','Interpreter','latex','FontSize',15);
    ylabel(y_label,'Interpreter','latex','FontSize',15);
    legend('Location', location,'Interpreter','latex','FontSize',14);
    box on;
    grid off;
    hold off;

    % Save figure as PDF
    exportgraphics(gcf, [filename, '.pdf']);
    fprintf('Saved plot to %s.pdf\n', filename);
end
