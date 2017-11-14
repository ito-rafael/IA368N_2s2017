% result = http_delete(resource)
%
% Input:
% - resource: the URL of the resource (protocol can be http or https)
%
% Possible outputs:
% - true (resource deleted)
% - false on HTTP error:
%   400 : Bad Request
%   401 : Unauthorized
%   403 : Forbiden
%   404 : Not Found
%   405 : Method not Allowed



function result = http_delete(resource)
   global http_handler_inst https_handler_inst;
   % check if http or https
   type = strfind(resource, 'http://');
   if type == 1
     handler = http_handler_inst;
   else
     handler = https_handler_inst;
   end

   % do http transaction
   content = handler.sendRequest('DELETE', resource, '', '');
   content = char(content);
   retcode = handler.getStatusCode;
   retcode = char(retcode);
   if strcmp(retcode, '200') == 1 
     result = true;
   else
     warn = ['Access to resource ' resource ' returned HTTP error ' char(retcode)];
     warning(warn);
     result = false;
   end
end
