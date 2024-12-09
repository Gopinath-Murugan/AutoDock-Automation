#! /bin/bash
#! /bin/pythonsh

# Display a header message about the script
cat << "EOF"
            ########################################################################## 
            ##                                                                      ##
            ##                   Automated Docking script for Autodock              ##
            ##                   Written by Gopinath Murugan                        ##
            ##       CAS in Crystallography and Biophysics, University of Madras    ##
            ##                   Email: murugangopinath12@gmail.com                 ##
            ##                                                                      ##  
            ########################################################################## 
EOF

# Iterate over all PDB files in the current directory.
# This loop processes each ligand PDB file for docking.
for f in ./*.pdb; do 
    # Extract the base name of the ligand (file name without extension).
    lig=`basename $f .pdb`
    
    # Skip the protein.pdb file to avoid processing it as a ligand.
    if [ "$lig" == "protein" ]; then
        echo "Skipping protein.pdb"
        continue
    fi
    
    echo "Processing docking for ligand: $lig"

    # Create a directory for the ligand and run all subsequent commands within that directory.
    mkdir -p "$lig" &&

    # Run all preparations in parallel for receptor, ligand, grid, and dock
    (
        cd "$lig" || { echo "Failed to enter directory $lig"; exit 1; }

        # Copy the ligand and protein PDB files to the current directory.
        cp ./../"$lig".pdb ./ &&
        cp ./../protein.pdb ./ &&

        # Prepare receptor for AutoDock
        pythonsh ../prepare_receptor4.py -r protein.pdb -o protein.pdbqt &

        # Prepare ligand for AutoDock
        pythonsh ./../prepare_ligand4.py -l "$lig".pdb -o "$lig".pdbqt &

        # Prepare grid parameter file for AutoGrid
        pythonsh ./../prepare_gpf4.py -l "$lig".pdbqt -r protein.pdbqt -p npts="45,45,45" -i ./../g.gpf -o grid.gpf &

        # Prepare docking parameter file for AutoDock
        pythonsh ./../prepare_dpf42.py -l "$lig".pdbqt -r protein.pdbqt -i ./../d.dpf -o dock.dpf -v &

        # Wait for all preparation processes to complete before running AutoGrid and AutoDock
        wait

        # Run AutoGrid to generate the grid maps in parallel
        autogrid4 -p grid.gpf -l grid.glg &
	
	# Wait for 120 seconds after AutoGrid completes.
	sleep 120
        
	# Run AutoDock for docking simulations in parallel immediately after AutoGrid
        autodock4 -p dock.dpf -l dock.dlg &

        # Wait for AutoGrid and AutoDock to complete before proceeding
        wait
    ) &

done

# Wait for all background jobs to finish before exiting the script
wait

# Final message indicating completion
echo "All docking processes have been completed successfully."
