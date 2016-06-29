function hit_rate_percent=find_accuracy(TestLabels,OriginalLabels)
hit_rate=0;
for i=1:length(TestLabels)
    if TestLabels(i)==OriginalLabels(i)
        hit_rate=hit_rate+1;
    end
end
hit_rate_percent=hit_rate/length(TestLabels)*100;
