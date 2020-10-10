#!/bin/bash

while true; do

inotiywait -e modify,create,delete -r ~/git/ca/roles &&
    time ansible-playbook dev.yml -i inventory

done
