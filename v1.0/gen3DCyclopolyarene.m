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

%

function coord = gen3DCyclopolyarene( C, T, P )
% C: Curling vector
% T: Axial vector
% P: 2D points of C atoms, for each of which the coordinates are in terms of
%    basic vectors a1 and a2 of the graphene sheet.
%    !!!NOTE: The coordinates of P[] have already been MULTIPLIED BY 3

d_CC = 1.42; % C-C bond length in graphene in Angstrom

% Basis vector of the graphene sheet (in units of interring distance, which
% is equal to sqrt(3)*dC-C ~= sqrt(3)*1.42 Angstrom):
u_a1 = [ 1, 0 ];
u_a2 = [ 0.5, -0.86602540378443864676 ]; % [ 1/2, -sqrt(3)/2 ]

% Vectors in units of 
v_C = C(1)*u_a1 + C(2)*u_a2;
lenC = norm( v_C ); % Length of C
u_C = v_C / lenC; % Normalized C
v_T = T(1)*u_a1 + T(2)*u_a2;
lenT = norm( v_T ); % Length of T
u_T = v_T / lenT; % Normalized T

% Radius of the tube:
r = lenC / (2*pi);

N = size( P, 1 );
coord = zeros( N, 3 );
for j = 1 : N
    v_j = ( P(j,1)*u_a1 + P(j,2)*u_a2 ) / 3;
    % z-coordinates (in the axial direction):
    coord(j,3) = dot( v_j, u_T );
    % xy-coordinates:
    theta = dot( v_j, u_C ) / r;
    coord(j,1) = r * cos( theta );
    coord(j,2) = r * sin( theta );
end

% Convert to Angstrom:
SF = sqrt(3)*d_CC;
coord = coord * SF;

end