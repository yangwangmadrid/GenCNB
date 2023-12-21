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

% All nonequivalent permutated partitions of a given integer

function result = int_part_perm( n )

datafile = sprintf( 'int_part/int_part_perm_%i.mat', n );
if exist( datafile, 'file' )
    load( datafile );
    return
end

result0 = int_part( n );

result = cell( 0, 1 );
for j = 1 : length( result0 )
    P = uniqueperms( result0{j} );
    for k = 1 : size( P, 1 )
        result{ end+1, 1 } = P( k, : );
    end
end

% Output to external file:
if ~exist( 'int_part', 'dir' )
    system( 'mkdir int_part' );
end
save( datafile, 'result' );

end