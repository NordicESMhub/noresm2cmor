#!/bin/bash

#version=v20191108b
version=v20200218
expid=piClim-CH4
model=NorESM2-LM
years1=(0  1  11 21)
years2=(10 10 20 30)

${CMOR_ROOT}/workflow/cmorCheck.sh -v=$version -e=$expid -m=$model -yrs1="${years1[*]}" -yrs2="${years2[*]}"

