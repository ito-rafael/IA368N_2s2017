clear; clc; close all;
addpath("..");
http_init('');

host = 'http://localhost:4950';
vel_lin = '/motion/vel';
vel_rot = '/motion/rotvel';
velocidade_lin = 500; %mm/s
velocidade_rot = 5; %rad/s
current_key = [];
key = getKey();
while(key != 142)
	if (key == current_key)
		velocidade_lin = velocidade_lin +100;
		velocidade_rot = velocidade_rot + 5;
	else
		velocidade_lin = 500;
		velocidade_rot = 5;
	end
	current_key = key;
	if (key == toascii('w'))
		http_put([host vel_lin],velocidade_lin);
		http_put([host vel_rot],0);
	elseif (key == toascii('x'))
		http_put([host vel_lin],-velocidade_lin);
		http_put([host vel_rot],0);
	elseif (key == toascii('a'))
		http_put([host vel_rot],velocidade_rot);
		http_put([host vel_lin],0);
	elseif (key == toascii('d'))
		http_put([host vel_rot],-velocidade_rot);
		http_put([host vel_lin],0);
	else
		http_put([host vel_lin],0);
		http_put([host vel_rot],0);
	end
	key = getKey();
end


