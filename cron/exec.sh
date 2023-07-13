#!/bin/bash

cron &

/genevalidator/bin/genevalidator app -n ${NUMWORKERS:-1} -g/genevalidator/output -d/genevalidator/blast_db