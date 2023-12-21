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

% Generate all extended (not shortest) paths for carbon nanobelts (n,m,l)

function gen_paths_ext( n, m, l )
% l: number of additional rings attached to the `standard' CNB (n,m)

% Check validity of input n, m, l:
if l < 1
    fprintf( 'Integer l must be at least 1\n' );
    fprintf( 'ABORTED\n' );
    return
elseif n < l + 2
    fprintf( 'Integer n must be at least l+2\n' );
    fprintf( 'ABORTED\n' );
    return
else
    % CHECK: n >= m && n > 0 && m >= 0:
    if n < m || n <= 0 || m < 0
        fprintf( 'CONDITIONS for n, m:\n\tn >= m && n > 0 && m >= 0\n' );
        fprintf( 'ABORTED\n' );
        return
    end
end


% New n, m to partition:
n1 = n - l;
m1 = m + l;
fprintf( 'n1 = %i, m1 = %i\n', n1, m1 );

comb_n1 = int_part_perm_canon( n1 );
N_max = length( comb_n1{1} ); % Max. length of paritions in comb_n1
%comb_m1_l = int_part_perm_pair( m1, l );
comb_m1_l = int_part_perm_pair_efficient( m1, l, N_max );

P_all = cell( 0, 1 );
p_uniq = [];
N0 = 0; % To record last N value
for j = 1 : length( comb_n1 )
    num_n1 = comb_n1{ j };
    N = length( num_n1 );

    if N0 > 0 && N < N0
        ifNewN = true;
    else
        ifNewN = false;
    end

    if ~isempty( p_uniq ) && ifNewN
        % NOTE: unique() returns sorted p_uniq[] already:
        p_uniq = unique( p_uniq, 'rows' );
        P_all{ end+1, 1 } = p_uniq;
        % Reset:
        p_uniq = [];
    end

    for k = 1 : length( comb_m1_l )
        num_m1_l = comb_m1_l{ k };
        M_L = length( num_m1_l );
        if M_L ~= N
            continue
        end

        % Matched: N == M + L:
        p = zeros( 1, N + M_L );
        p( 1:2:end ) = num_n1;
        p( 2:2:end ) = num_m1_l;
        p_uniq = [ p_uniq; pathcode_canon_ext( p ) ];
    end

    N0 = N;
end

if ~isempty( p_uniq )
    xxxxx
    % Last set of unique paths:
    p_uniq = unique( p_uniq, 'rows' ); % NOTE: unique() also sorts p_uniq[]
    P_all{ end+1, 1 } = p_uniq;
end

%P_all{:}

write_paths_ext( n, m, l, P_all );

end