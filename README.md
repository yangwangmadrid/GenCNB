# GenCNB
Generating structuress of carbon nanobelts (CNBs)

<img src="https://repository-images.githubusercontent.com/619128989/08bf4173-9a9c-48e2-89e0-eb4848209aeb" 
     alt="Logo of the GenCNB program" title="GenCNB" width=360 />
     
This program generates structures of carbon nanobelts (CNBs), including both the standard and nonstandard CNBs. All constructed molecular structures are exported in Cartesian coordinates in \*.xyz files.


## Copyright and License
The Author of the GenCNB software is Yang Wang 
(yangwang@yzu.edu.cn; [orcid.org/0000-0003-2540-2199](https://orcid.org/0000-0003-2540-2199)). The GenCNB program is 
released under GNU General Public License v3 (GPLv3).

<img src="https://www.gnu.org/graphics/gplv3-or-later.png" 
     alt="Logo of GPLv3 or later" title="GPLv3 or later" />
 
 
## Disclaimer
The GenCNB software is provided as it is, with no warranties. The Author shall 
not be liable for any use derived from it. Feedbacks and bug reports are always 
welcome (yangwang@yzu.edu.cn). However, it is kindly reminded that the Author 
does not take on the responsibility of providing technical support.  
 
 
## How to Install
No installation is required as this program is composed of MATLAB scripts, which have been tested with MATLAB version R2023a/b.


## How to Use

### I. Generation of standard CNBs

To enumerate and generation the structures of all possible isomers of standard
CNBs (n,m), simply call the function:
```
gen_belts( n, m )
```
which generates a folder named R{NR}-{n}\_{m} that stores the xyz files. Each xyz file contains the following information of the corresponding CNB isomer:
Number of atoms
Stoichiometry, Isomer No.: [path code] Hueckel total energy, Hueckel HOMO-LUMO
gap
Atomic numbers/symbols + Cartesian coordinates



