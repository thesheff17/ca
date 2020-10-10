#!/bin/bash

while true; do

inotifywait -e modify -r ~/git/ca/roles &&
    time ansible-playbook dev.yml -i inventory

done
