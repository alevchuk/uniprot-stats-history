#!/bin/bash

(set -e; set -u;
  sp_file="swiss-prot/web.expasy.org/docs/relnotes/relstat.html"
  line=$(grep "protein knowledgebase release" "$sp_file" | head -1)
  sp_release=$(expr "$line" : '.*release \(.*\) statistics')
  #echo "$sp_release"
  sp_dir="$sp_release-swiss-prot"
  mkdir "$sp_dir" 2> /dev/null && true
  mv --no-clobber "swiss-prot/"* "$sp_dir/")

(set -e; set -u;
  tr_file="trembl/www.ebi.ac.uk/uniprot/TrEMBLstats.html"
  line=$(grep "PROTEIN DATABASE RELEASE" "$tr_file" | head -1)
  tr_release=$(expr "$line" : '.*RELEASE \(.*\) STATISTICS')
  #echo "$tr_release"
  tr_dir="$tr_release-trembl"
  mkdir "$tr_dir" 2> /dev/null && true
  mv --no-clobber "trembl/"* "$tr_dir/")


set -e; set -u;
(
  for f in *"/web.expasy.org/docs/relnotes/relstat.html"; do
    echo "<p><a href=\"$f\">$f</a></p>"
  done
  
  for f in *"/www.ebi.ac.uk/uniprot/TrEMBLstats/"*".html"; do
    echo "<p><a href=\"$f\">$f</a></p>"
  done
) | sort > index.html-tmp

echo "<p>Code for the script that generated these archives:
<a href=\"https://github.com/alevchuk/uniprot-stats-history/\"
>https://github.com/alevchuk/uniprot-stats-history/</a></p>" >> index.html-tmp

mv index.html{-tmp,}
