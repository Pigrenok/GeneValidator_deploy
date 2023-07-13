!#/bin/bash

latestDir=$(find /genevalidator/output -maxdepth 1 -type d -printf '%T+ %p\n' | sort -r | head -1 | cut -d" " -f2);

find /genevalidator/output/* -maxdepth 0 -type d ! -wholename $latestDir -exec rm -r {} +

find ${latestDir}/GeneValidator/* -maxdepth 0 -type d -atime 5 -exec rm -r {} +
# find ${latestDir}/GeneValidator/* -maxdepth 0 -type d -amin +5 -exec rm -r {} +