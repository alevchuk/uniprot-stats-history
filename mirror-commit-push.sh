#!/bin/bash

SWISSPROT_URL=http://web.expasy.org/docs/relnotes/relstat.html
TREMBL_URL=http://www.ebi.ac.uk/uniprot/TrEMBLstats/relstat.html

( set -e
  set -u
  cd swiss-prot/
  wget        --quiet -E -H -k -K -p $SWISSPROT_URL )

( set -e
  set -u
  cd trembl/
  wget        --quiet -E -H -k -K -p $TREMBL_URL )

git add .
git commit    --quiet -a -m "Automtic commit" 
git push      --quiet 
