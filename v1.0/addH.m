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

function [ xyz, elem ] = addH( xyz, lm )

MAX_ITER = 100; % 
d_CH = 1.09; % in Angstrom; C--H bond length
MIN_HH_DIST = 1.5; % in Angstrom

NC = size( xyz, 1 ); % Number of C atoms
CN = sum( lm ); % Coordination number of C atoms
ixC2 = find( CN == 2 ); % All 2-coordinated C atoms
NH = length( ixC2 ); % Number of H atoms


% Determine coordinates of H atoms
xyzH = zeros( NH, 3 );
for j = 1 : NH
    iC = ixC2(j);
    iC_nb = find( lm(iC,:) == 1 );
    v1 = xyz( iC_nb(1), : ) - xyz( iC, : );
    v1 = v1 / norm(v1);
    v2 = xyz( iC_nb(2), : ) - xyz( iC, : );
    v2 = v2 / norm(v2);
    vH = -( v1 + v2 );
    vH = vH / norm(vH);
    xyzH( j, : ) = xyz( iC, : ) + vH*d_CH;
end

% Adjust H atoms that are too close to each other:
for j = 1 : NH
    for k = j+1 : NH
        v = xyzH( k, : ) - xyzH( j, : );
        r = norm( v );
        if r < MIN_HH_DIST
            fprintf( 'H atoms %i--%i too close to each other\n', NC+j, NC+k );
            
            iter = 1;
            while iter <= MAX_ITER
                % Adjust H positions according to H--H distance:
                u = v / r;
                xyzH( j, : ) = xyzH( j, : ) - u*0.2;
                xyzH( k, : ) = xyzH( k, : ) + u*0.2;
                
                % Adjust H-j and H-k positions according to C--H distance:
                for iH = [ j, k ]
                    for iC = 1 : NC
                        w = xyzH( iH, : ) - xyz( iC, : );
                        rw = norm( w );
                        if rw <= d_CH*1.2
                            break;
                        end
                    end
                    u = w / rw;
                    xyzH( iH, : ) = xyzH( iH, : ) + u*( d_CH - rw );
                end
                
                % Update H--H distance:
                r = norm( xyzH( k, : ) - xyzH( j, : ) );
                if r >= MIN_HH_DIST
                    fprintf( 'H%i--H%i distance converged to %.3f Angstrom after %i iterations\n', ...
                        NC+j, NC+k, r, iter );
                    break;
                end
                iter = iter + 1;
                if iter == MAX_ITER
                    fprintf( 'WARNING: H%i--H%i distance NOT converged: ', ...
                        NC+j, NC+k );
                    fprintf( '%.3f Angstrom\n', r );
                end
            end
        end
    end
end

xyz = [ xyz; xyzH ];

elem = cell( NC+NH, 1 );
for j = 1 : NC
    elem{j} = 'C';
end
for j = NC+1 : NC+NH
    elem{j} = 'H';
end

end