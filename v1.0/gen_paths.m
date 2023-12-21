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

% Generate all shortest paths for carbon nanobelts (n,m)

function gen_paths( n, m )

% Ziazag case:
if m == 0
    P_all = { n };
    write_paths( n, m, P_all );
    %P_all{:}
    return
end

% (n,1) case:
if m == 1
    P_all = { [ n, 1 ] };
    write_paths( n, m, P_all );
    %P_all{:}
    return
end

%comb_n = int_part_perm( n );
comb_n = int_part_perm_canon( n );
comb_m = int_part_perm( m );


P_all = cell( 0, 1 );
p_uniq = [];
len_n0 = -1;
for j = 1 : length( comb_n )
    num_n = comb_n{j};
    len_n = length( num_n );
    if len_n ~= len_n0 && ~isempty( p_uniq )
        % NOTE: unique() returns sorted p_uniq[] already:
        p_uniq = unique( p_uniq, 'rows' );
        P_all{ end+1, 1 } = p_uniq;
        % Reset:
        p_uniq = [];
    end
    
    for k = 1 : length( comb_m )
        num_m = comb_m{k};
        len_m = length( num_m );
        if len_m ~= len_n
            continue
        end
        p = zeros( 1, len_n + len_m );
        p( 1:2:end ) = num_n;
        p( 2:2:end ) = num_m;
        p_uniq = [ p_uniq; pathcode_canon( p ) ];
    end
    
    len_n0 = len_n;
end
% Last set of unique paths:
p_uniq = unique( p_uniq, 'rows' ); % NOTE: unique() also sorts p_uniq[]
P_all{ end+1, 1 } = p_uniq;

%P_all{:}

write_paths( n, m, P_all );


end