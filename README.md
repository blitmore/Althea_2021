# Althea_2021
2021 Althea testnet activities

the unjail attempt will not function without the "expect" utility, 
so install it. For Debian based:

> sudo apt-get install expect


amijailed.sh is meant to be run via cron, maybe every 5 mins:
 */5 * * * *  /home/ubuntu/bin/amijailed.sh 

If you want the LED stuff to work, you must run from root's cron or take measures.



cp amijailed.sh and unjailme.exp to /home/<your user>/bin/, make sure they can be found, 
mark executable, 'chmod +x ...' .

make sure to fill in variables in amijailed.sh

