# GenCNB
Generating structuress of carbon nanobelts (CNBs)

This program generates structures of carbon nanobelts (CNBs), including both the standard and nonstandard CNBs. All constructed molecular structures are exported in Cartesian coordinates in \*.xyz files.


## Copyright and License
The Author of the GenCNB software is Yang Wang 
(yangwang@yzu.edu.cn; [orcid.org/0000-0003-2540-2199](https://orcid.org/0000-0003-2540-2199)). The GenCNB program is 
released under GNU General Public License v3 (GPLv3).

<img src="https://www.gnu.org/graphics/gplv3-or-later.png" 
     alt="Logo of GPLv3 or later" title="GPLv3 or later" />
 
 
## Disclaimer
The GenCNB software is provided as it is, with no warranties. The Author shall not be liable for any use derived from it. Feedbacks and bug reports are always welcome (yangwang@yzu.edu.cn). However, it is kindly reminded that the Author does not take on the responsibility of providing technical support.  
 
 
## How to Install
No installation is required as this program is composed of MATLAB scripts, which have been tested with MATLAB version R2023a/b.


## How to Use

### I. Generation of standard CNBs

To enumerate and generate the structures of all possible isomers of the standardCNBs (n,m), simply call the function:
```
gen_belts( n, m, true )
```
which first generates a path file named `PATH_{n}_{m}_R{NR}` and then a folder named `R{NR}-{n}_{m}` that stores the xyz files. Note that `{NR}` represent the number of rings for the CNB. The path code file lists the canonical path codes of all enumerated isomers. Each xyz file in folder `R{NR}-{n}_{m}` contains the following information of the corresponding CNB isomer:

- Number of atoms
- Stoichiometry, Isomer No.: [path code] Hueckel total energy, Hueckel HOMO-LUMO gap
- Atomic numbers/symbols + Cartesian coordinates

*NOTE: If the last argument of `gen_belts()` is `false`, then only the path code file is generated without producing any Cartesian coordinates.


#### Example: 
Upon execution of 
```
gen_belts( 7, 3, true )

```
we enumerate and obtain all isomers of the standard [10]CNBs (7,3). The onscreen
output is as follows:
```
Enumerating all nonequivalent (7,3) nanobelt isomers ...
File PATH_7_3_R10 written
Generating 3D coordinates in xyz files ...
Folder R10-07_03 created
8 isomers read from PATH_7_3_R10
C40H20 Isomer 1:  [ 3 1 2 1 2 1 ] -57.12321180 0.49143180
Coordinates written to file R10-07_03/R10-7_3-1.xyz
C40H20 Isomer 2:  [ 3 1 3 1 1 1 ] -57.08934344 0.46822321
Coordinates written to file R10-07_03/R10-7_3-2.xyz
C40H20 Isomer 3:  [ 4 1 2 1 1 1 ] -57.07766625 0.42782322
Coordinates written to file R10-07_03/R10-7_3-3.xyz
C40H20 Isomer 4:  [ 5 1 1 1 1 1 ] -57.02514860 0.35638249
Coordinates written to file R10-07_03/R10-7_3-4.xyz
C40H20 Isomer 5:  [ 4 2 3 1 ] -56.91984845 0.41115384
Coordinates written to file R10-07_03/R10-7_3-5.xyz
C40H20 Isomer 6:  [ 5 2 2 1 ] -56.90061329 0.35551010
Coordinates written to file R10-07_03/R10-7_3-6.xyz
C40H20 Isomer 7:  [ 6 2 1 1 ] -56.83596861 0.29433540
Coordinates written to file R10-07_03/R10-7_3-7.xyz
C40H20 Isomer 8:  [ 7 3 ] -56.61671443 0.24447759
Coordinates written to file R10-07_03/R10-7_3-8.xyz
```


### II. Generation of nonstandard CNBs

We call the function:
```
gen_belts_ext( n, m, l, true )
```
to enumerate and generate all possible isomers of the nonstandard CNBs
(n,m,l). The corresponding path code file is generated as `XPATH_{n}_{m}_{l}_R{NR}` and, if the last argument of `gen_belts_ext()` is `true`, the folder is created as `XR{NR}-{n}_{m}_{l}` containing the xyz files for all isomers.

#### Example: 
We want to construct all possible isomers of the nonstandard CNBs (6,2,3). Simply call 
```
gen_belts_ext( 6, 2, 3, true )
```
We obtain the path code file `XPATH_6_2_3_R11` and the folder `XR11-06_02_03` where there are four xyz files, XR11-6_2_3-1.xyz, ..., XR11-6_2_3-4.xyz for the four possible isomers. The output on screen is collected in the following:
```
Enumerating all nonequivalent (6,2,3) nanobelt isomers ...
n1 = 3, m1 = 5
File XPATH_6_2_3_R11 written
Generating 3D coordinates in xyz files ...
Folder XR11-06_02_03 created
4 isomers read from XPATH_6_2_3_R11
H atoms 47--66 too close to each other
H47--H66 distance converged to 1.577 Angstrom after 3 iterations
H atoms 60--63 too close to each other
H60--H63 distance converged to 1.577 Angstrom after 3 iterations
C44H22 Isomer 1:  [ 1 3 1 2 1 -3 ] -62.75076792 0.56607072
Coordinates written to file XR11-06_02_03/XR11-6_2_3-1.xyz
H atoms 47--66 too close to each other
H47--H66 distance converged to 1.577 Angstrom after 3 iterations
H atoms 60--63 too close to each other
H60--H63 distance converged to 1.577 Angstrom after 3 iterations
C44H22 Isomer 2:  [ 1 4 1 1 1 -3 ] -62.70769145 0.47883420
Coordinates written to file XR11-06_02_03/XR11-6_2_3-2.xyz
H atoms 47--66 too close to each other
H47--H66 distance converged to 1.577 Angstrom after 3 iterations
H atoms 58--61 too close to each other
H58--H61 distance converged to 1.577 Angstrom after 3 iterations
C44H22 Isomer 3:  [ 1 5 1 -1 1 -2 ] -62.69242729 0.39166782
Coordinates written to file XR11-06_02_03/XR11-6_2_3-3.xyz
H atoms 60--63 too close to each other
H60--H63 distance converged to 1.577 Angstrom after 3 iterations
C44H22 Isomer 4:  [ 2 5 1 -3 ] -62.54187725 0.40476208
Coordinates written to file XR11-06_02_03/XR11-6_2_3-4.xyz
```
