#!/bin/bash
fswatch roles/ | (while read; do time ansible-playbook dev.yml -i inventory; done)
