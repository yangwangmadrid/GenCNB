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

function write_paths( n, m, P_all )

outp = sprintf( 'PATH_%i_%i_R%i', n, m, n+m );
fid = fopen( outp, 'w' );

Ntot = 0;
for j = 1 : length( P_all )
    P = P_all{j};
    N = size( P, 1 );
    Ntot = Ntot + N;
    for k = 1 : N
        fprintf( fid, ' %i', P(k,:) );
        fprintf( fid, '\n' );
    end
end
fclose( fid );

fprintf( 'File %s written\n', outp );

end