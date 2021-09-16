function plot_vowel_space(f1, f2, group)
    gscatter(f1, f2, group)
    ylim([0, 1400])
    xlim([0, 3500])
    set(gcf,'Position',[100 100 1000 800])
end 