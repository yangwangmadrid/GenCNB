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

% Convert a path code to the coordinates of all points on the path (in 
% terms of basis vectors u_a1 and u_a2
 
function P = pathcode2pathcoord( C, pathcode )
%       C: Curling vector == (n,m)
% code: a path code, e.g., each of the lines in file PATH_n_m_R*

nstep = length( pathcode );

P = zeros( sum(C), 2 ); % Coordinates of ring center points
iPt = 1;
for j = 1 : nstep
    if mod(j,2) == 1 % u_a1
        dP = [ 1, 0 ];
    else % u_a2
        dP = [ 0, 1 ];
    end
    if j < nstep
        stepsize = pathcode(j);
    else
        stepsize = pathcode(j) - 1;
    end
    for k = 1 : stepsize
        iPt = iPt + 1;
        P( iPt, : ) = P( iPt-1, : ) + dP;
    end
end


% Check if the path P is a complete looped one:
if C(2) == 0 % Special case of zigzag (n,0) belts:
    ifLooped = isequal( P( end, : ) + [ 1 0 ], C );
else % Other cases:
    ifLooped = isequal( P( end, : ) + [ 0 1 ], C );
end

% If not looped, then try a circularly equivalent pathcode so that a2
% shifts and a1 shifts are switched:
if ~ifLooped
    pathcode = pathcode( [ 2:end, 1 ] );
    P = pathcode2pathcoord( C, pathcode );
end

end