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

% Generate structures (path and 3D coordinates) of EXTENDED CNBs (n,m,l)


function gen_belts_ext( n, m, l, ifGenCoord )
% ifGenCoord: true  ==> generate also coordinate (gjf) files (slower);
%             false ==> generate only XPATHS_n_m_l_R{NR} files (faster)

addpath ~/work/My_Matlab/BuckyToolkit/

if nargin == 3
    ifGenCoord = false;
end

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

path_file = sprintf( 'XPATH_%i_%i_%i_R%i', n, m, l, n+m+l );
list = dir( path_file );

if isempty( list )
    fprintf( 'Enumerating all nonequivalent (%i,%i,%i) nanobelts isomers ...\n', ...
        n, m, l );
    gen_paths_ext( n, m, l );
    list = dir( path_file );
else
    fprintf( '(%i,%i,%i) nanobelts have already been enumerated in %s.\n', ...
        n, m, l, path_file );
end

if length( list ) > 1
    error( 'There are more than ONE file of %s', path_file )
end

% Do not generated coordinates files:
if ~ifGenCoord
    return
end


fprintf( 'Generating 3D coordinates in gjf files ...\n' );

% Get number of rings from the file name:
NR = str2double( regexprep( path_file, '^.*R', '' ) );

outdir = sprintf( 'XR%02i-%02i_%02i_%02i', NR, n, m, l );
if ~exist( outdir, 'dir' )
    cmd = sprintf( 'mkdir %s', outdir );
    system( cmd );  
    fprintf( 'Folder %s created\n', outdir );
else
    fprintf( 'WARNING: Folder %s already exists\n', outdir );
    fprintf( 'ABORTED\n' );
    return
end

% Read path numbers from path_file:
fid = fopen( path_file, 'r' );
NIso = 0;
path_codes = cell( 0, 1 );
while ~feof( fid )
    tline = fgetl( fid );
    NIso = NIso + 1;
    path_codes{ end+1, 1 } = str2double( strsplit( strtrim(tline) ) );
end
fclose( fid );
if NIso > 0
    fprintf( '%i isomers read from %s\n', NIso, path_file );
else
    fprintf( 'ERROR: No isomers found in %s\n', path_file );
    return
end


C = [ n, m ]; % Curling vector
T = nm_conjugate( C ); % Axial vector
for iIso = 1 : NIso
    pathcode = path_codes{ iIso };
    P_c = pathcode2pathcoord_ext( C, pathcode ); % Path coord. of ring centers
    P = gen_2d_belt_from_path( C, P_c );
    coord = gen3DCyclopolyarene( C, T, P );

    % Add H atoms:
    lm = linkage( coord );
    [ xyz, elem ] = addH( coord, lm );
    NR0 = size( P_c, 1 );
    assert( NR0 == NR )
    NC = size(coord,1);
    NH = length(elem) - NC;
    assert( NC == NR*4 )
    assert( NH == NR*2 )
    title = sprintf( 'C%iH%i Isomer %i: ', NC, NH, iIso );

    %------------------------------------------------------------
    % Get HMO energy and gap:
    hmosol = hmo( lm );
    title = sprintf( '%s %.8f %.8f', title, hmosol.Etot, hmosol.Gap );
    %------------------------------------------------------------

    for j = 1 : length( pathcode )
        title = sprintf( '%s %i', title, pathcode(j) );
    end
    fprintf( '%s\n', title );
    fmt = sprintf( '%%s/XR%%i-%%i_%%i_%%i-C%%iH%%i_%%0%ii.gjf', floor(log10(NIso))+1 );
    outp = sprintf( fmt, outdir, NR, n, m, l, NC, NH, iIso );
    write_gjf( outp, xyz, elem, title );
end

end