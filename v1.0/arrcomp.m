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

% Compare two numeric arrays

function v = arrcomp( A1, A2 )

N1 = length(A1);
N2 = length(A2);
for j = 1 : min( N1, N2 )
    if A1(j) < A2(j)
        v = -1;
        return
    elseif A1(j) > A2(j)
        v = 1;
        return
    end
end

if N1 < N2
    v = -1;
elseif N1 > N2
    v = 1;
else
    v = 0;
end

end