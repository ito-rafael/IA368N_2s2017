% result = http_init(sessid)
%
% Set paths for http_xxx functions
%
% Input:
% - sessid: the REALabs session ID (not needed on simulated robots)
%
% Output:
% - none

function result = http_init(sessid)

   addpath('C:\Users\eric\Dropbox\UNICAMP\cours\IA368N Introdução a robotica movel\API_MATLAB\jsonlab');
   addpath('C:\Users\eric\Dropbox\UNICAMP\cours\IA368N Introdução a robotica movel\API_MATLAB\robot');
   
   % Melhor adicionar ao static path do Matlab 
   % Instruï¿½ï¿½es: file:///Applications/MATLAB_R2013a.app/help/matlab/matlab_external/bringing-java-classes-and-methods-into-matlab-workspace.html#f111065
   % Por que nï¿½o usar o javaddpath: 
   % MATLAB calls the clear java command whenever you change the dynamic path. 
   % This command clears the definitions of all Java classes defined by files on the dynamic class path, removes all variables 
   % from the base workspace, and removes all compiled scripts, functions, and MEX-functions from memory.
   % javaaddpath('/Users/amadeu/Google Drive/Unicamp/Disciplina/Matlab'); 
   global http_handler_inst https_handler_inst;
   http_handler_inst = javaObject('resthru.HttpClient');
   https_handler_inst = javaObject('resthru.HttpsClient');
   % check if sessid was passed
   if nargin == 1
     http_handler_inst.setCookie(sessid);
     https_handler_inst.setCookie(sessid);
   end
end

