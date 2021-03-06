#!/bin/bash

source ${CMOR_ROOT}/workflow/cmorRun1memb.sh

# initialize
login0=false
login1=false

# set active
login0=true
login1=true

# initialize
version=v20200702
expid=pa-pdSIC-ext
model=NorESM2-LM

# --- Use input arguments if exits
if [ $# -ge 1 ] 
then
     while test $# -gt 0; do
         case "$1" in
             -m=*)
                 model=$(echo $1|sed -e 's/^[^=]*=//g')
                 shift
                 ;;
             -e=*)
                 expid=$(echo $1|sed -e 's/^[^=]*=//g')
                 shift
                 ;;
             -v=*)
                 version=$(echo $1|sed -e 's/^[^=]*=//g')
                 shift
                 ;;
             * )
                 echo "ERROR: option $1 not allowed."
                 echo "*** EXITING THE SCRIPT"
                 exit 1
                 ;;
         esac
    done
fi
# --- 

echo "--------------------"
echo "EXPID: $expid       "
echo "--------------------"

echo "                    "
echo "START CMOR...       "
echo "$(date)             "
echo "                    "

wait
rm -f /projects/NS9560K/cmor/noresm2cmor/bin/filelist_N2000_PAMIP_6_1_v1
if $login0
then
#----------------
# part 1
#----------------
CaseName=N2000_PAMIP_6_1_v1
real=1
physics=1
years1=(2000 $(seq 2010 10 2080) 2090)
years2=(2009 $(seq 2019 10 2089) 2100)

runcmor -c=$CaseName -m=$model -e=$expid -v=$version -r=$real -p=$physics -yrs1="${years1[*]}" -yrs2="${years2[*]}" -mpi=DMPI
#---
fi
#---

wait
rm -f /projects/NS9560K/cmor/noresm2cmor/bin/filelist_N2000_PAMIP_6_1_v1
if $login1
then
#----------------
# part 2
#----------------
CaseName=N2000_PAMIP_6_1_v1
real=1
physics=1
years1=(2000 $(seq 2010 10 2080) 2090)
years2=(2009 $(seq 2019 10 2089) 2100)

runcmor -c=$CaseName -m=$model -e=$expid -v=$version -r=$real -p=$physics -yrs1="${years1[*]}" -yrs2="${years2[*]}" -mpi=DMPI -s=EP
#---
fi
#---

wait
echo "         "
echo "CMOR DONE"
echo "$(date)  "
echo "~~~~~~~~~"

# PrePARE QC check, create links and update sha256sum
${CMOR_ROOT}/workflow/cmorPost.sh -m=${model} -e=${expid} -v=${version} --verbose=false
