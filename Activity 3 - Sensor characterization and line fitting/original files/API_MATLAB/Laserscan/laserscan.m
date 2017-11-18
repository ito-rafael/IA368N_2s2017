clear; clc; close all;
addpath('..')
http_init('');

host = 'http://192.168.2.105:4950';

% obtem leituras do laser do robo
laser = '/perception/laser/1/global_poses';
rposes = http_get([host laser]);
px = [];
py = [];
for i=1:1:length(rposes)
	px = [px rposes{i}.x];
	py = [py rposes{i}.y];
end
% gira o robo 180 graus
delta = 180;
http_put([host '/motion/heading'], delta);
% verifica se o movimento foi completado
status = 1;
while (status == 1)
  pause(1);
  status = http_get([host '/motion/heading/status']);
end
rposes = http_get([host laser]);
for i=1:1:length(rposes)
	px = [px rposes{i}.x];
	py = [py rposes{i}.y];
end
  
plot(px, py, 'k' , 'LineWidth' , 2);

