#/usr/bin/env bash
sudo iptables --insert INPUT --protocol tcp --dport 8080 --jump ACCEPT --verbose
sudo service jenkins start
