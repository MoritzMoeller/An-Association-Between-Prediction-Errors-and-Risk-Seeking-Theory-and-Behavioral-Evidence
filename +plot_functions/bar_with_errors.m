function bar_with_errors(x,y,e, c)

hold on

%bar(x, y, "EdgeAlpha", 0, "FaceColor", c)
bar(x, y, "FaceColor", c)
errorbar(x, y, e, "CapSize", 0, "LineStyle", "none", "LineWidth", 1, "Color", 'k')


end