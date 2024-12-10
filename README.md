# Automated Docking Script for AutoDock

This repository contains a Bash script (`adt_automate.sh`) for automating molecular docking simulations using AutoDock tools.

## Prerequisites

Before using this script, ensure the following:

1. **Operating System**: The script is designed to run on Linux systems.
2. **Software Requirements**:
   - [AutoDock](http://autodock.scripps.edu/) and [AutoGrid](http://autodock.scripps.edu/): Ensure these are installed and added to your `PATH`.
   - [MGLTools](https://ccsb.scripps.edu/mgltools/): Install to access the `pythonsh` and preparation scripts.

## Preparation Steps

Follow these steps to set up your environment and prepare for running the script:

1. **Create a Working Directory**:

   - Create a new directory to store all the required files and results.

2. **Copy Required Files**:

   - Place the `protein.pdb` file (target protein structure) in the directory.
   - Place the ligand PDB files in the directory. These files should:
     - Be in `.pdb` format.
     - Be energy minimized.

3. **Copy Template Files**:

   - Include template `.gpf` (grid parameter file) and `.dpf` (docking parameter file) in the same directory.
   - **Ensure the correct values of grid center and grid points (npts)** in the `.gpf` file. The grid center and the number of grid points (npts) define the docking region and should be adjusted based on the protein structure and ligand to ensure proper docking results.

4. **Copy Python Scripts**:

   - Ensure the directory contains the Python scripts used by the script:
     - `prepare_receptor4.py`
     - `prepare_ligand4.py`
     - `prepare_gpf4.py`
     - `prepare_dpf42.py`

5. **Run the Script**:

   - Execute the script using the command:
     ```bash
     ./adt_automate.sh
     ```

6. **Analyze Results**:

   - After the script finishes, review the generated docking results and log files in the respective ligand directories.

## Output

- Each ligand will have its own directory containing the processed files and docking results, including:
  - Prepared receptor (`protein.pdbqt`)
  - Prepared ligand (`ligand_name.pdbqt`)
  - Grid map files and logs (`grid.gpf`, `grid.glg`)
  - Docking parameter file (`dock.dpf`)
  - Docking log file (`dock.dlg`)

## Notes

- Ensure all input files are correctly formatted and named as expected by the script.
- Modify the script to adjust parameters (e.g., grid size) as needed for your specific docking experiments.
- For any issues or questions, refer to the official AutoDock and MGLTools documentation.

## Example Run

This repository includes example files for reference:
- `protein.pdb` (sample protein structure)
- Ligand PDB files (sample ligands in `.pdb` format)
- Template `.gpf` and `.dpf` files
- Python preparation scripts

You can use these files to test the script and understand its workflow.

## Citation

If you are using this script for your studies, kindly acknowledge the use of AutoDock4 as per its citation guidelines and mention my GitHub repository:

Morris, Garrett M., et al. "AutoDock4 and AutoDockTools4: Automated docking with selective receptor flexibility." Journal of computational chemistry 30.16 (2009): 2785-2791. https://onlinelibrary.wiley.com/doi/full/10.1002/jcc.21256

For the latest version of this script and updates, visit my GitHub repository:
https://github.com/Gopinath-Murugan/AutoDock-Automation

Mentioning this repository in your publications or research would be greatly appreciated.

We appreciate your support!
