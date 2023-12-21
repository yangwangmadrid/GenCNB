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

% Generate 2D coordinates (in terms of u_a1/3 and u_a2/3 of C atoms of the 
% UNCURLED nanobelt from a given path coordinates of ring centers
 
function P = gen_2d_belt_from_path( C, P_c )
%   C: Curling vector
% P_c: Coordinates of ring center points (in units of basis vectors a1, a2)

NR = size( P_c, 1 ); % Number of ring centers

% Generate all vertices of each of the rings:
% NOTE: all coordinates are multipled by 3
% 1. The 6 vectors from each of the 6 ring vertices to the ring center
%    [!!!Also multipled by 3 already!!!]:
v = [
     2, -1
     1, -2
    -1, -1
    -2,  1
    -1,  2
     1,  1
    ];
P_c3 = 3*P_c;
P = [];
for j = 1 : NR
    for k = 1 : 6
        P = [ P; P_c3(j,:) + v(k,:) ];
    end
end

% Remove duplicated points:
P = unique( P, 'rows' );

% Remove equivalent points that can be translated to each other by vec. C:
C3 = C*3;
N = size( P, 1 );
P1 = [];
ifRemove = zeros( 1, N );
for j = 1 : N
    if ifRemove(j)
        continue
    end
    for k = j+1 : N
        d = P(k,:) - P(j,:);
        if isequal( d, C3 ) || isequal( d, -C3 )
            ifRemove(k) = 1;
            break
        end
    end
    P1 = [ P1; P(j,:) ];
end
P = P1;

end