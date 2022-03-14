clc,clear;
numOfSamples = 10000;
n = [10];
lambda = 2;
[mu,variance] = expstat(1/lambda);
sampleMatrix = zeros(numOfSamples,size(n,2));
k = 1;
for n = n
    for i =1:numOfSamples
        sampleMatrix(i,k) = sum(exprnd((1/lambda),n,1));
    end
    k = k + 1;
end
for i=1:size(sampleMatrix,2)
    n = [10];
    subplot(1,1,i);
    histogram(sampleMatrix(:,i),'Normalization','pdf');
    hold on
    meanB=mu*n(i);   % expectation
    stdB=sqrt(variance*n(i));     % std
    xlim = get(gca,'xlim');
    xlim = xlim(1):0.01:xlim(2);
    y=normpdf(xlim,meanB,stdB);
    plot(xlim,y,'LineWidth',2,'color','k');
    ylim = get(gca,'ylim');
    line([meanB meanB], ylim,'color','g')
    hold on
    line([meanB+stdB meanB+stdB NaN meanB-stdB meanB-stdB] ,...
        [ylim NaN ylim], 'color','r')
    title(strcat("n = ",int2str(n(i)),...
        ', # of samples = 10000, \lambda = 2'),...
        'FontSize', 10, 'FontName', 'Times New Roman');
    xlabel('$A = \sum_{i = 1}^{n} K_i$', 'FontSize', 10,...
        'FontName', 'Times New Roman', 'interpreter', 'latex');
    ylabel('$P[A]$', 'FontSize', 10,...
        'FontName', 'Times New Roman', 'interpreter', 'latex');
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName','Times New Roman',...
        'fontsize', 10);
end
legend({'Normalized Histogram PDF',...
    'Gaussian PDF',...
    '\mu (Theoretically Calc.)',...
    '\mu - \sigma, \mu + \sigma  (Theoretically Calc.)'},...
    'FontSize', 10, 'FontName', 'Times New Roman',...
    'Position',[0.714505945123999,...
    0.233778889239893,...
    0.165674605918308,...
    0.137896828424363],'Location','best');



latex_fig(10, 7, 3.5)