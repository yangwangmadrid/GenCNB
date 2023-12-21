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

% Perpendicular indices (n1,m1):

function T = nm_conjugate( C )
% C: Curling vector
% T: Axial vector

n = C(1);
m = C(2);
n1 = 2*m+n;
m1 = -(2*n+m);
gcd_n1m1 = gcd( n1, m1 );
n1 = n1 / gcd_n1m1;
m1 = m1 / gcd_n1m1;
T = [ n1, m1 ];

end