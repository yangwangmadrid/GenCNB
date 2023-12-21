% Copyright 2023 Yang Wang
% All rights reserved
% 
% Author:
% Yang Wang (yangwang@yzu.edu.cn)
% 
% -------------------------------------------------------------------------
% 
% This file is part of GenCNB.
% 
% GenCNB is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
% 
% GenCNB is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE. See the GNU General Public License for more 
% details.
% 
% You should have received a copy of the GNU General Public License along 
% with GenCNB. If not, see <https://www.gnu.org/licenses/>.
% -------------------------------------------------------------------------

% Get canonical path code of a given path code
%
%  Rule for canonical path code:
%    Make a CIRCULAR rearrangement of a code so that the numbers are in
%    descending order as much as possible. That is, the first number should
%    be smallest, and if this cannot decide a unique ordering, then let the
%    second number be the next smallest one, and so on.

function maxcode = pathcode_canon( pathcode )

[ ~, ix ] = find( pathcode == max( pathcode ) );

maxcode = circshift( pathcode, length(pathcode) - ix(1) + 1 );
% Reversed code candidate:
code = [ maxcode(1), fliplr( maxcode(2:end) ) ];
if arrcomp( code, maxcode ) > 0
    maxcode = code;
end
if length(ix) == 1
    return
end
for j = ix(2:end)
    code = circshift( pathcode, length(pathcode) - j + 1 );
    if arrcomp( code, maxcode ) > 0
        maxcode = code;
    end
    % Reversed code candidate:
    code = [ code(1), fliplr( code(2:end) ) ];
    if arrcomp( code, maxcode ) > 0
        maxcode = code;
    end
end


end