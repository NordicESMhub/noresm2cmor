#!/bin/bash

version=v20190810
version=v20190813
version=v20190814
#version=v20191108b
#version=v20200218
expid=historical
model=NorESM2-LM

years1=(1849 1850 $(seq 1860 10 1940))
years2=(1859 1859 $(seq 1869 10 1949))
years1+=($(seq 1950 10 2000) 2010)
years2+=($(seq 1959 10 2009) 2014)

years1+=($(seq 1950 10 2000) 2010)
years2+=($(seq 1960 10 2010) 2015)

${CMOR_ROOT}/workflow/cmorCheck.sh -v=$version -e=$expid -m=$model -yrs1="${years1[*]}" -yrs2="${years2[*]}"

