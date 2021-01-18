figure(1);
yyaxis left
plot(compression,MRE,'-');
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");
