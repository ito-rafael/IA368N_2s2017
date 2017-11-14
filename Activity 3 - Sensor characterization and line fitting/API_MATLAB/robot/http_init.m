% result = http_init()
%
% Set pathes for http_xxx functions

function result = http_init()
%addpath('./jsonlab');
%addpath('./robot');
%javaaddpath('.')
    global http_handler_inst https_handler_inst;
    http_handler_inst = javaObject('resthru.HttpClient');
    https_handler_inst = javaObject('resthru.HttpsClient');
    % check if sessid was passed
    if nargin == 1
     http_handler_inst.setCookie(sessid);
     https_handler_inst.setCookie(sessid);
    end
end
