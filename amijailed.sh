#!/bin/bash

########################################################################## 
## last updated 02/26/2021 by Blitmore, use at your own risk.
##
## Built for a Raspi4B, this script checks to see whether althea is reporting
## the validator has been jailed. If not, the red LED is cycled OFF.
## If so, the red LED is turned ON, the related expect script is launched and
## a log entry made.
########################################################################## 


led_OFF="gpio"
led_ON="default-on"
led_state=${led_OFF}
log="/var/log/althea_jailed.log"

## Path to your althea binary
althea="/usr/bin/althea"
validator="cosmosvaloper1....."
unjailme="/home/feb13/bin/unjailme.exp"
## Watch out, this is a bash script, be sure to escape any control chars....
password="PassW0rD"

function  check0 {
    "${althea}" query staking validator "${validator}"|egrep '^jail'|cut -d' ' -f2
}

state=0

## unjailed should be "false"
[[ $(check0) == "false" ]] || state=1;

## log the jailing time
[[ "${state}" -eq 1 ]] && echo "`date`: jailed" >> "${log}"

## maybe set the LED
[[ "${state}" -eq 1 ]] && led_state=${led_ON}

echo "${led_state}" > /sys/class/leds/led1/trigger

################################################# 
## Attempt to unjail me
##
## Invocation:
##  If your interactive, normal invocation is as follows, and your password is "PASSword":
##
##    > althea tx slashing unjail --from validator --fees 5000ualtg --chain-id=althea-testnet1v2
##
##  Replace with :
##
##    > unjailme.exp validator althea-testnet1v2 PASSword
################################################# 

[[ "${state}" -eq 1 ]] && ${unjailme} validator althea-testnet1v2 testnet1


