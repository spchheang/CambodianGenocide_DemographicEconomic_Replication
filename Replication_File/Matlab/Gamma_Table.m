function Gamma_Table(cohort_name, gamma, Work_sigmaH, Work_sigmaL, n, filename)
    % Gamma_Table generates a LaTeX table for Relative GDP values
    % Inputs:
    %   mod_name  - 4x1 string array of model descriptions
    %   RelGDP    - 4x1 numeric array of relative GDP values
    %   RelGDPpca - 4x1 numeric array of relative GDP per capita values
    %
    % Output:
    %   Creates a LaTeX table file named 'Filename.tex'

    % Open file for writing
    fileID = fopen(filename,'w');

    % Write LaTeX table preamble
    fprintf(fileID, '\\begin{table}[htbp]\n');
    fprintf(fileID, '\\scalebox{0.7}{\n');
    fprintf(fileID, '\\resizebox{\\columnwidth}{!}{\n');
    fprintf(fileID, '\\begin{threeparttable}\n');
    fprintf(fileID, '\\caption{Calibrated values of $\\gamma_{i}$ and  $\\sigma_{i}^{j}$ by age cohort.}\n');
    fprintf(fileID, '\\begin{tabular}{lccc}\n');
    fprintf(fileID, '\\toprule\n');
    fprintf(fileID, 'Age group & $\\gamma_{i}$   & $\\sigma_{i}^{H}$ & $\\sigma_{i}^{L}$ \\\\\n');
    fprintf(fileID, '\\midrule\n');

    % Write table rows
    for i = 1:n
        fprintf(fileID, '%s & %.3f & %.3f & %.3f \\\\\n', cohort_name(i), gamma(i), Work_sigmaH(i), Work_sigmaL(i));
        if ismember(i, 1:10)
            fprintf(fileID, '[0.1em]\n');
        end
    end

    % Write table notes
    fprintf(fileID, '\\bottomrule\n');
    fprintf(fileID, '\\end{tabular}\n');
    fprintf(fileID, '\\scriptsize \\hfill\\parbox[t]{\\linewidth}{\\emph{Notes: }$\\gamma_{i}$ denotes the calibrated productivity weights by age cohort.  These weights sum to 1 across working-age cohorts (ages 15-69),  and are set to 0 outside this range. $\\sigma_{i}^{j}$ denotes the saving rate from income source $j$''s for cohort $i$, where $j \\in \\{H,L\\}$ represents high-skilled individuals, respectively. These saving rates are assumed to be constant over time.}\n');
    fprintf(fileID, '\\label{tab:gamma}\n');
    fprintf(fileID, '\\end{threeparttable} } }\n');
    fprintf(fileID, '\\end{table}\n');

    % Close file
    fclose(fileID);
end
