
load("working_basedata.mat");

%Create double_matrix containing all miRseq data
double_matrix = table2array(basedatampm(:, 2:1047));

%Get dimensions of double matrix
mat_size = size(double_matrix);

%Find genes where over 90% of samples have a value of zero
idx = double_matrix==0;
c = sum(idx,1);
cp = c / mat_size(1);
idx = find(cp>=.9);

%Delete any genes that were found to exist above the threshold
double_matrix(:,idx) = [];

%Retrieve feature names
headers = basedatampm.Properties.VariableNames;

%Remove feature names who were above the threshold
headers = headers(2:1047);
headers(idx) = [];

%Apply log2 transformation
processed_data = log2(replaceZeros(double_matrix, 'lowval'));

%Delete removed columns from original data table
basedatampm(:, idx + 1) = [];

%Replace with log2 transformed data
table_double = array2table(processed_data, 'VariableNames', headers);
basedatampm(:, 2:645) = table_double;

%Write data to excel file
%writetable(basedatampm,'normalized_log2_transformed.xlsx','Sheet',1);


%Get labels
binary_labels = table2array(basedatampm(:, 663));
%high_low_labels = table2array(basedatampm(:, 664));
%three_labels = table2array(basedatampm(:, 665));


%Y = tsne(double_matrix);
%gscatter(Y(:,1), Y(:,2), three_labels);


%[raw_outliers, raw_high_outliers, raw_low_outliers] = scatterplot_mark_outliers(processed_data(:,1), "Alpha", computeAlphaOutliers(756), "PlotTitle", 'Gene 1 Outliers', "ylabel",'Expression Value');

%spearman = SampleCorrelation(processed_data, "Spearman");
%[raw_outliers, raw_high_outliers, raw_low_outliers] = scatterplot_mark_outliers(spearman, "Alpha", computeAlphaOutliers(756), "PlotTitle", "Base Data Spearman", "ylabel",'Correlation');
iqr_range = iqr(processed_data);
%[raw_outliers, raw_high_outliers, raw_low_outliers] = scatterplot_mark_outliers(iqr_range, "Alpha", computeAlphaOutliers(756), "PlotTitle", 'Base Data IQR', "ylabel",'IQR');

iqr_idx = find(iqr_range==0);

processed_data(:, iqr_idx) = [];
headers(iqr_idx) = [];

basedatampm(:, iqr_idx + 1) = [];

iqr_range = iqr(processed_data);
%[raw_outliers, raw_high_outliers, raw_low_outliers] = scatterplot_mark_outliers(iqr_range, "Alpha", computeAlphaOutliers(756), "PlotTitle", 'Filtered IQR', "ylabel",'IQR');

%spearman = SampleCorrelation(processed_data, "Spearman");
%[raw_outliers, raw_high_outliers, raw_low_outliers] = scatterplot_mark_outliers(spearman, "Alpha", computeAlphaOutliers(756), "PlotTitle", "Filtered Spearman", "ylabel",'Correlation');

%Write data to excel file
%writetable(basedatampm,'IQR_Filtered_log2_transformed.xlsx','Sheet',1);

%boxplot(processed_data)
%title('Data Boxplot')

%low_iqr_idx = find(iqr_range<5);
%processed_data(:, low_iqr_idx) = [];
%headers(low_iqr_idx) = [];
%basedatampm(:, low_iqr_idx + 1) = [];





%Y = tsne(processed_data);
%gscatter(Y(:,1), Y(:,2), binary_labels, 'br');



%[c_idx, C] = kmeans(processed_data, 2);



%figure;
%gscatter(processed_data(:,1),processed_data(:,2),c_idx,'rgbcmy')
%hold on
%plot(C(:,1),C(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster Centroid')



%cgObj1 = clustergram(processed_data', 'ColumnLabels', binary_labels, 'RowLabels', headers, 'ColumnPDist', 'spearman');




%significant_genes = table2cell(significantgenes)';

%mcheck = ismember(headers, significant_genes);
%sig_idx = find(mcheck==0);

%processed_data(:, sig_idx) = [];
%headers(sig_idx) = [];

%basedatampm(:, sig_idx + 1) = [];



[feature_idx, scores] = fscmrmr(processed_data, binary_labels);

%Create plot of importance scores
%bar(scores(feature_idx))
%xlabel('Predictor rank')
%ylabel('Predictor importance score')
%xticklabels(strrep(headers(feature_idx),'_','\_'))
%xtickangle(45)


%Filter to only include the top 40 most important features
final_data = processed_data(:, feature_idx(1:20));
final_headers = headers(feature_idx(1:20));



Y = tsne(final_data);
gscatter(Y(:,1), Y(:,2), binary_labels, 'br');

