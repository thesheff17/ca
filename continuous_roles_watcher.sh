#!/bin/bash
fswatch roles/ | (while read; do ansible-playbook dev.yml -i inventory; done)
