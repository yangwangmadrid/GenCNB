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

% All nonequivalent permutated numbers of a collected set consisting of
% n1's parts and n2's parts

function result = int_part_perm_pair_efficient( n1, n2, maxLen )

if n1 < n2
    tmp = n1;
    n1 = n2;
    n2 = tmp;
end


result1 = int_part( n1 );
result2 = int_part( n2 );

result = cell( 0, 1 );
for j1 = 1 : length( result1 )
    if length( result1{j1} ) >= maxLen
        continue
    end
    maxLen2 = maxLen - length( result1{j1} );
    for j2 = 1 : length( result2 )
        if length( result2{j2} ) > maxLen2
            continue
        end
        result_j1j2 = [ result1{j1}, -result2{j2} ];
        P = uniqueperms( result_j1j2 );
        for k = 1 : size( P, 1 )
            result{ end+1, 1 } = P( k, : );
        end
    end
end

% % Output to external file:
% if ~exist( 'int_part', 'dir' )
%     system( 'mkdir int_part' );
% end
% save( datafile, 'result', '-v7.3' );

end