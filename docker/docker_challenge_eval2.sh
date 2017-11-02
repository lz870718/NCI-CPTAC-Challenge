#!/bin/bash
# Automation of validation and scoring
# Make sure you point to the directory where challenge.py belongs and a log directory must exist for the output
# Set environment variables for synapse username and password
script_dir=$(dirname $0)
if [ ! -d "$script_dir/log" ]; then
  mkdir $script_dir/log
fi
if [ ! -d "$script_dir/output" ]; then
  mkdir $script_dir/output
fi
#---------------------
#Validate submissions
#---------------------
#Proteogenomics Subchallenge 2 (8720145)
python $script_dir/docker_challenge.py --acknowledge-receipt --canCancel -u $SYNAPSE_USER -p $SYNAPSE_PASS --send-messages --notifications validate 9608069 >> $script_dir/log/score.log 2>&1
python $script_dir/docker_challenge.py --acknowledge-receipt --canCancel -u $SYNAPSE_USER -p $SYNAPSE_PASS --send-messages --notifications validate 9608082 >> $script_dir/log/score.log 2>&1

#--------------------
#Score submissions
#--------------------
#python $script_dir/docker_challenge.py --canCancel -u $SYNAPSE_USER -p $SYNAPSE_PASS --send-messages --notifications score 8720145 >> $script_dir/log/score.log 2>&1
#python $script_dir/docker_challengeThreaded.py --threads 4 --canCancel -u $SYNAPSE_USER -p $SYNAPSE_PASS --send-messages --notifications score 8720145 >> $script_dir/log/score.log 2>&1
python $script_dir/docker_challengeScheduled.py --timeQuota 14400000 --threads 4 --canCancel -u $SYNAPSE_USER -p $SYNAPSE_PASS --send-messages --notifications score 9608069 >> $script_dir/log/score.log 2>&1
python $script_dir/docker_challengeScheduled.py --timeQuota 14400000 --threads 4 --canCancel -u $SYNAPSE_USER -p $SYNAPSE_PASS --send-messages --notifications score 9608082 >> $script_dir/log/score.log 2>&1

#--------------------
#Stop submissions
#--------------------
#python $script_dir/docker_challenge.py -u $SYNAPSE_USER -p $SYNAPSE_PASS --send-messages --notifications dockerstop 8720145 >> $script_dir/log/score.log 2>&1
