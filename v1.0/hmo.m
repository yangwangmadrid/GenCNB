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
% Update:
% Oct 5, 2021: Filling electrons complying with Hund's rule

function hmoSol = hmo( lm, q )
%
%  Return:
%  hmoSol: solution which contains:
%    hmoSol.E:   eigven energies in units of -beta
%    hmoSol.C:   coefficients of MO, C(iat, iMO)
%    hmoSol.N:   total number of atoms/MOs
%    hmoSol.Etot:  total pi energy in units of -beta
%    hmoSol.Gap:  HOMO-LUMO gap in units of -beta
%    hmoSol.Chg: atomic charges
%    hmoSol.Spin: atomic spin densities
%    hmoSol.Ne:  total number of electrons
%    hmoSol.Ne_a:  total number alpha of electrons
%    hmoSol.Ne_b:  total number beta of electrons
%    hmoSol.Occ:  occupanies of MOs
%    hmoSol.Occ_a:  occupanies of alpha MOs
%    hmoSol.Occ_b:  occupanies of beta MOs
%    hmoSol.BOs:  bond orders for ALL pairs of atoms no matter bonded or not
%    hmoSol.BO:  bond orders only for bonded pairs
%          .BO(:,1): index of 1st atom
%          .BO(:,2): index of 2nd atom  (.BO(:,1)<.BO(:,2))
%          .BO(:,3): bond order in units of -beta
%    hmoSol.F:  free valences
%    hmoSol.D:  density matrix of all electrons
%    hmoSol.Da: density matrix of alpha electrons
%    hmoSol.Db: density matrix of beta electrons
%    hmoSol.JT: true (subject to Jahn-Teller distortion) or false (not JT)

if( nargin == 1 )
    q = 0;
end

% Check if lm is symmetric (Hermitian):
%assert( isequaln(lm,lm') );

N = size(lm,1); % total number of atoms or MOs

[ C, E ] = eig(lm);
E = -diag(E); % in units of -beta
% sort E from negative to positive values
[ E, IX ] = sort( E );
% sort V with the order of E
C = C( :, IX );


Ne = N - q; % total number of electrons

% Applying Hund's rule and Aufbau principle to fill the levels with
% alpha and beta electrons:
% (1) Degeneracies of of levels:
j = 1;
for k = 1 : length(E)
    if k > 1 && abs( E1(j-1) - E(k)) < eps*20
        Deg(j-1) = Deg(j-1) + 1;
    else
        E1(j) = E(k);
        Deg(j) = 1;
        j = j + 1;
    end
end

% (2) Fill the electrons:
Occ_a = zeros( N, 1 ); % alpha MO occupancies:
Occ_b = zeros( N, 1 ); % beta MO occupancies:
counter = 0;
ia = 1;
ib = 1;
for k = 1 : length( Deg )
    deg_k = Deg(k);
    % Fill with alpha electrons:    
    for j = 1 : deg_k
        if counter == Ne % No eletron left
            break;
        end
        counter = counter + 1;
        Occ_a( ia ) = 1;
        ia = ia + 1;
    end
    % Fill with beta electrons:
    for j = 1 : deg_k
        if counter == Ne % No eletron left
            break;
        end
        counter = counter + 1;
        Occ_b( ib ) = 1;
        ib = ib + 1;
    end
end

Ne_a = sum( Occ_a ); % number of alpha electrons
Ne_b = sum( Occ_b ); % number of beta electrons

Occ = Occ_a + Occ_b;
Occ_spin = Occ_a - Occ_b;

% Total energy
Etot = sum( Occ.*E );

% HOMO-LUMO gap
if( Ne_a ~= Ne_b ) % open-shell
    Gap = 0;
else
    Gap = E( Ne_a + 1 ) - E( Ne_a );
end

% Atomic charges:
Chg = ones(N,1); % initially each atom has one pi-electron
for iat = 1 : N
    Chg(iat) = Chg(iat) - sum( Occ'.*(C(iat,:).^2) );
end

% Atomic spin charges:
Spin = zeros(N,1);
for iat = 1 : N
    Spin(iat) = sum( Occ_spin'.*(C(iat,:).^2) );
end

% Bond orders
for i1 = 1 : N
    for i2 = 1 : N
        BOs( i1, i2 ) = sum( Occ'.*( C(i1,:).*C(i2,:) ) );
    end
end

% Bond orders only for connected bonds:
nBond = 0;
for i1 = 1 : N
    for i2 = i1 + 1 : N
        if( lm(i1,i2) )
            nBond = nBond + 1;
            BO( nBond, 1 ) = i1;
            BO( nBond, 2 ) = i2;
            BO( nBond, 3 ) = BOs( i1, i2 );
        end
    end
end

% Free valence:
F = zeros(N,1); % initialize
for ib = 1 : size( BO, 1 )
    i1 = BO( ib, 1 );
    i2 = BO( ib, 2 );
    F(i1) = F(i1) + BO( ib, 3 );
    F(i2) = F(i2) + BO( ib, 3 );
end
F = (3+sqrt(3)) - (F+3); % there are 3 sigma-bonds already


% Density matrix:
Da = C(:,1:Ne_a)*C(:,1:Ne_a)';
Db = C(:,1:Ne_b)*C(:,1:Ne_b)';
D = Da + Db;

% Jahn-Teller distortion:
JT = false;
if abs( E(Ne_a) - E(Ne_a+1) ) < eps*20
    JT = true;
end
if abs( E(Ne_b) - E(Ne_b+1) ) < eps*20
    JT = true;
end

hmoSol.E = E;
hmoSol.C = C;
hmoSol.N = N;
hmoSol.Ne = Ne;
hmoSol.Ne_a = Ne_a;
hmoSol.Ne_b = Ne_b;
hmoSol.Occ_a = Occ_a;
hmoSol.Occ_b = Occ_b;
hmoSol.Occ = Occ;
hmoSol.Etot = Etot;
hmoSol.Gap = Gap;
hmoSol.Chg = Chg;
hmoSol.Spin = Spin;
hmoSol.BOs = BOs;
hmoSol.BO = BO;
hmoSol.F = F;
hmoSol.D = D;
hmoSol.Da = Da;
hmoSol.Db = Db;
hmoSol.JT = JT;

end
