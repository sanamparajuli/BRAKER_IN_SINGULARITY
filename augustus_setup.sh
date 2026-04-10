#mount your directory
singularity exec --bind /path/to/rundir:/mnt ./braker3.sif bash

singularity exec braker3.sif bash #this will open the sif image, now copy the files from the image to the mounted dir

Singularity cp -r /opt/Augustus/config /mnt/augustus_config

#test if it is writable
touch ./augustus_config/config/species/test #if it creates a new file test, it is writable
