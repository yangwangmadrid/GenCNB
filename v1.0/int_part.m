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

% See https://jeromekelleher.net/category/combinatorics
%     Ref.: https://arxiv.org/abs/0909.2331
%
% Adapted from their python code

function result = int_part( n )

datafile = sprintf( 'int_part/int_part_%i.mat', n );
if exist( datafile, 'file' )
    load( datafile );
    return
end

a = zeros(1, n + 1);
k = 1;
a(2) = n;
result = cell(0, 1);

while k ~= 0
    x = a(k) + 1;
    y = a(k + 1) - 1;
    k = k - 1;

    while x <= y
        k = k + 1;
        a(k) = x;
        y = y - x;
    end

    a(k + 1) = x + y;
    result{end + 1, 1} = a(1:k + 1);
end

% Output to external file:
if ~exist( 'int_part', 'dir' )
    system( 'mkdir int_part' );
end
save( datafile, 'result' );

end