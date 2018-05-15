%% Part 1
close all
clc
%% Import the data
[~, ~, raw] = xlsread('Wave1.xlsx','Sheet1','A2:C1798');

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
t = data(:,1);
Phase_WP = data(:,2);
OWC_WP = data(:,3);

%% Clear temporary variables
clearvars data raw;

%% [1] Plot Data
figure;
hold on;
plot(t,Phase_WP,'.');
plot(t,OWC_WP,'.');
title('Phase_WP and OWC_WP vs Time');
legend("Phase_WP","OWC_WP");
xlabel("Time(s)");
ylabel("Data(mm)");

%% [2] Plot one period
T = 1/f;
t_r = rem(t,T);
figure;
hold on
plot(t_r, Phase_WP, '.');
plot(t_r, OWC_WP, '.');
title('Phase Data vs Remainder Time [1 period]');
legend("Phase_WP","OWC_WP");
xlabel("t_r");
ylabel("Data(mm)");

%% [3] Plot Phase average
Tvec = linspace(0, T, 51);
d_t = Tvec(51)./(length(Tvec)-1);

Phase_PhAv = Tvec;
OWC_PhAv = Tvec;

for i=1:length(Tvec)
    if i == 1 || i == 51
        Phase_PhAv(i) = mean(Phase_WP(t_r<(d_t./2)|t_r>=T-(d_t./2)));
        OWC_PhAv(i) = mean(OWC_WP(t_r<(d_t./2)|t_r>=T-(d_t./2)));
    else
        Phase_PhAv(i) = mean(Phase_WP(Tvec(i)-(d_t./2)<=t_r<Tvec(i)+(d_t./2)));
        OWC_PhAv(i) = mean(OWC_WP(Tvec(i)-(d_t./2)<=t_r<Tvec(i)+(d_t./2)));
    end
end

figure
hold on
plot(Tvec,Phase_PhAv,'.');
plot(Tvec,OWC_PhAv,'.');
