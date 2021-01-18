%plot number of points and mean reprojection error

%% SURF Castle
close all
compression = [1 2 4 8 16 32 64];
MRE = [0.577123	0.610581	0.607515	0.579008	0.387957 NaN NaN];
Points = [8956	8748	7789	6806	2224 NaN NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.35 0.65]);
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([2000 10000])
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

title("Castle SURF descriptors");
xlim([1 16])
%% KAZE Castle
close all
compression = [1 2 4 8 16 32 64];
Points = [8522	9392	9391	8075	2416	NaN	NaN];
MRE = [0.452	0.600	0.618	0.588	0.426	NaN	NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.35 0.65]);
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([2000 10000])
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

xlim([1 16])
title("Castle KAZE descriptors");
%% SURF Portello
close all
compression = [1 2 4 8 16 32 64];
Points = [1601	2818	2423	1908	511	NaN	NaN];
MRE = [0.846073	0.810789	0.796746	0.745568	0.731985 NaN NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.66 0.86]);
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([0 3000])
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

xlim([1 16])
title("Portello SURF descriptors");
%% KAZE Portello
close all
compression = [1 2 4 8 16 32 64];
Points = [428	2933	2846	2262	NaN	NaN	NaN];
MRE = [0.671	0.837	0.851	0.782	NaN NaN NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.66 0.86]);
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([0 3000])
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

title("Portello KAZE descriptors");
%% SURF Tiso
close all
compression = [1 2 4 8 16 32 64];
Points = [13739	12821	11778	8868	2609 NaN NaN];
MRE = [1.07381	1.05752	1.02091	0.972071	0.903944 NaN NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.65 1.1])
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([2000 16000]);
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

xlim([1 16])
title("Tiso SURF descriptors");
%% KAZE Tiso
close all
compression = [1 2 4 8 16 32 64];
Points = [13672	14030	13270	10696	3178 NaN NaN];
MRE = [0.999	1.081	1.092	1.016	0.676 NaN NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.65 1.1])
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([2000 16000]);
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

xlim([1 16])
title("Tiso KAZE descriptors");
%% SURF Fountain
close all
compression = [1 2 4 8 16 32 64];
Points = [1332	1386	1199	1097	NaN	NaN	NaN];
MRE = [0.527116	0.505406	0.500263	0.466449	NaN NaN NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.44 0.58])
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([900 1500])
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

title("Fountain SURF descriptors");
%% KAZE Fountain
close all
compression = [1 2 4 8 16 32 64];
Points = [949	1464	1400	1201	NaN	NaN	NaN];
MRE = [0.446	0.561	0.559	0.489	NaN NaN NaN];

figure(1);
yyaxis left
plot(compression,MRE,'-');
ylim([0.44 0.58])
hold on;
ylabel("Mean Reprojection Error (MRE)");
yyaxis right
plot(compression,Points,'-');
ylim([900 1500])
hold on;
ylabel("Number of points")
xticks(compression);
grid on;
xlabel("Compression rate");

title("Fountain KAZE descriptors");