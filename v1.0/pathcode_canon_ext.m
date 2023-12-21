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

% Get canonical path code of a given EXTENDED path code
%
%  Rule for canonical path code of EXTENDED paths:
%    Make a DOUBLE-CIRCULAR rearrangement of a code so that 
%    (1) Circular shifts must be an EVEN number so that the odd digits
%        always correspond to u_a1 steps while even digits always 
%        correspond to u_a2 or u_a2' steps
%    (2) The numbers are in descending order as much as possible. 
%        That is, the first number should be smallest, and if this cannot 
%        decide a unique ordering, then let the second number be the next 
%        smallest one, and so on.
%    (3) For the special case of zigzag (n,0,l) type, owing to its mirror
%        symmetry (reflection with respect to the curl vector), taking the
%        opposite values of the even-indexed numbers (i.e, corresponding to 
%        u_a2 and u_a2' steps in the path) results in an equivlant path code.

function maxcode = pathcode_canon_ext( pathcode, flag )
% flag:  0 ==> Max code of the ORGINAL pathcode
%        1 ==> Max code of the MIRROR pathcode where even-indexed numbers
%              take their opposite values
%        2 ==> Max code between the max code of ORGINAL pathcode and the
%              max code of MIRROR pathcode

% Determine if this is a zigzag type:
pathcode_even = pathcode(2:2:end);
m_ = sum( pathcode_even(pathcode_even>0) );
l = -sum( pathcode_even( pathcode_even<0 ) );
m = m_ - l;


if m == 0
    if nargin == 1
        flag = 2;
    end

    if flag == 2
        maxcode1 = pathcode_canon_ext( pathcode, 0 );
        maxcode2 = pathcode_canon_ext( pathcode, 1 );
        if arrcomp( maxcode1, maxcode2 ) > 0
            maxcode = maxcode1;
        else
            maxcode = maxcode2;
        end
        return
    end

    if flag == 1
        % Make the mirror of pathcode:
        pathcode( 2:2:end ) = -pathcode( 2:2:end );
    end
end


% Make sure that only find max. at odd positions:
pathcode_odd = pathcode;
pathcode_odd( 2:2:end ) = -1;

[ ~, ix ] = find( pathcode_odd == max( pathcode_odd ) );

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