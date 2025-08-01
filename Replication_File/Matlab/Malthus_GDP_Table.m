function Malthus_GDP_Table(mod_name, RelGDP, RelGDPpca, n, filename)
    % Malthus_GDP_Table generates a LaTeX table for Relative GDP values
    % Inputs:
    %   mod_name  - 4x1 string array of model descriptions
    %   RelGDP    - 4x1 numeric array of relative GDP values
    %   RelGDPpca - 4x1 numeric array of relative GDP per capita values
    %
    % Output:
    %   Creates a LaTeX table file named 'Table.tex'

    % Open file for writing
    fileID = fopen(filename,'w');

    % Write LaTeX table preamble
    fprintf(fileID, '\\begin{table}[htbp]\n');
    fprintf(fileID, '\\scalebox{0.9}{\n');
    fprintf(fileID, '\\resizebox{\\columnwidth}{!}{\n');
    fprintf(fileID, '\\begin{threeparttable}\n');
    romanLabel = "II";
    fprintf(fileID, '\\caption{Relative GDP and GDP per capita (2010) without capital and skill heterogeneity: Special case %s.}\n', romanLabel);
    fprintf(fileID, '\\begin{tabular}{lcc}\n');
    fprintf(fileID, '\\toprule\n');
    fprintf(fileID, 'Substitution parameters & Relative GDP & Relative GDP per capita \\\\\n');
    fprintf(fileID, '\\midrule\n');

    % Write table rows
    for i = 1:n
        fprintf(fileID, '%s & %.4f & %.4f \\\\\n', mod_name(i), RelGDP(i), RelGDPpca(i));
        if ismember(i, 1:3)
            fprintf(fileID, '\\addlinespace\n');
        end
    end

    % Write table notes
    fprintf(fileID, '\\bottomrule\n');
    fprintf(fileID, '\\end{tabular}\n');
    fprintf(fileID, ['\\scriptsize \\hfill\\parbox[t]{\\linewidth}{\\emph{Notes:} Relative GDP measures the total output in 2010 of actual GDP relative to counterfactual scenarios, ' ...
        'with relative GDP per capita defined analogously. The production function uses factor shares of $\\beta = 0.9$ for labor, and ' ...
        'the remaining share $1{-}\\beta = 0.1$ for land.}\n']);
    fprintf(fileID, '\\label{tab:MathusainGDP}\n');
    fprintf(fileID, '\\end{threeparttable} } }\n');
    fprintf(fileID, '\\end{table}\n');

    % Close file
    fclose(fileID);
end
