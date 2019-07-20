function avg = avgscore(testscores, student, first, last)
for k = first : last
    scores(k) = testscores.(student).week(k);
end
avg = sum(scores) / (last - first + 1);