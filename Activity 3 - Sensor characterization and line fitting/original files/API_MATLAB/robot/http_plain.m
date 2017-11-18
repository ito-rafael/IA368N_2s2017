% result = http_plain(method, resource, payload)
%
% Input:
% - method: 'GET', 'PUT', 'POST' or 'DELETE'
% - resource: the URL of the resource (protocol can be http or https)
% - payload: a JSON object (if required);

% Possible outputs:
% - a string containing a JSON object (if returned)
% - NaN on HTTP error:
%   400 : Bad Request
%   401 : Unauthorized
%   403 : Forbiden
%   404 : Not Found
%   405 : Method not Allowed


function result = http_plain(method, resource, payload)
   global http_handler_inst https_handler_inst;
   % check if http or https
   type = strfind(resource, 'http://');
   if type == 1
     handler = http_handler_inst;
   else
     handler = https_handler_inst;
   end

   % check if payload exists
   ct = '';
   if nargin == 3
     ct = 'application/json';
   end

   % do http transaction
   content = handler.sendRequest(method, resource, ct, payload);
   content = char(content);
   retcode = handler.getStatusCode;
   retcode = char(retcode);
   if strcmp(retcode, '200') == 1 
     result = content;
   else
     warn = ['Access to resource ' resource ' returned HTTP error ' char(retcode)];
     warning(warn);
     result = NaN;
   end
end
