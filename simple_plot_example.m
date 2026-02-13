% Egyszerű ábrázolási példa
% A függvény:
%	f(t) = A cos(omega t + phi) + B
% Az ábrázolási tartomány:
%	[t_1, t_2]
% A pontok száma
%	N

% Paraméterek
N = 5000;
t_1 = 0;
t_2 = 10;

A = 2;
f_0 = 0.5;
omega = 2*pi*f_0;
phi = deg2rad(45);
B = 1;

% Az ábrázolandó függvény
f = @(t) A*cos(omega*t + phi) + B;
g = @(t) A*sin(omega*t + phi) + B;

% Ábrázolás
Window = figure();
Window.Color = [1, 1, 1];

hold on;
box on;
grid on;

% Feliratozás
title("Koszinusz és szinusz ábrázolása", FontSize=16);
xlabel("Idő, t, s", FontSize=14);
ylabel("Érték, y", FontSize=14);

%t = t_1:((t_2-t_1)/N):t_2;
t = linspace(t_1, t_2, N);
y_f = f(t);
y_g = g(t);

%plot(t, y, "b--", "LineWidth", 3)
plot(t, y_f, "b-", LineWidth=3);
plot(t, y_g, "r--", LineWidth=3);

