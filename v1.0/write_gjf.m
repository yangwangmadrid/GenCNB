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
function write_gjf( outp, coord, elem, title )

if nargin == 3
    title = outp;
end
if nargin == 2
    title = outp;
    elem = {};
    for j = 1 : size(coord,1)
        elem{j} = 'C';
    end
end

if ~iscell( elem )
    elem_val = elem;
    elem = cell( size( coord, 1 ) );
    for j = 1 : size( coord, 1 )
        elem{j} = elem_val;
    end
end

fid = fopen( outp, 'w' );
fprintf( fid, '#P wB97XD/cc-pVDZ OPT NOSYMM' );
fprintf( fid, '\n\n%s\n\n0 1\n', title );
for j = 1 : size(coord,1)
    fprintf( fid, '%3s  %12.6f %12.6f %12.6f\n', elem{j}, coord(j,:) );
end
fprintf( fid, '\n' );

fclose( fid );
if ~strcmpi( title, 'MUTE-MODE' )
    fprintf( 'Coordinates written to file %s\n', outp );
end

end