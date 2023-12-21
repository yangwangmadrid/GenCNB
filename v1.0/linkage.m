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

% linkage.m
% Get linkage matrix from coordinates
function [ lm, iswarning ] = linkage( coord, MAX_BONDLEN )
% Parameters:
%   coord <N*3 matrix>: coordinates of molecule
%
% Return:
%   lm <N*N matrix>: linkage matrix

% =========== CONSTANTS ===========
if nargin == 1
    MAX_BONDLEN = 1.75;
end
% =================================

iswarning = false;

sz = size( coord );
N = sz(1);

% check number of atoms
if(  mod(N,2) == 1 )
    %error( 'Number of atoms is %i.\n It should be even.', N );    
    %  fprintf( 'Warning: Number of atoms is %i.\n It should be even.\n', N );    
end

for iat1 = 1 : N
    for iat2 = 1 : N        
        if( iat1 == iat2)
            lm(iat1, iat2) = 0;
        else
            lm(iat1, iat2) = ...
                norm( coord(iat1,:) - coord(iat2,:) ) <= MAX_BONDLEN;
        end
    end 
end

% check linkages
if(  ~all( sum(lm) == 3) )
    %error( 'Not all atoms have coordination number of 3.' );
    % fprintf( 'Warning: Not all atoms have coordination number of 3.\n' );
    iswarning = true;
    
    % fprintf(' %i\n', length(lm));
    slm = sum(lm);
    % ix = find( slm~= 3 )
    % fprintf('Atom %i with coordination number of %i.\n', ix, slm(ix));
end
