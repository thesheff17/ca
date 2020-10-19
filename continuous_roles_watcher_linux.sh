#!/bin/bash

while true; do


inotifywait -e attrib,modify,create,delete  -r ~/git/ca/roles && time ansible-playbook dev.yml -i inventory
done
