#!/bin/bash

#version=v20190920
version=v20191108b
expid=hist-piNTCF
model=NorESM2-LM
#login0
years1=(1849 1850 $(seq 1860 10 1940))
years2=(1859 1859 $(seq 1869 10 1949))
#login1
years1+=($(seq 1950 10 2000) 2010)
years2+=($(seq 1959 10 2009) 2014)

${CMOR_ROOT}/workflow/cmorCheck.sh -v=$version -e=$expid -m=$model -yrs1="${years1[*]}" -yrs2="${years2[*]}"

