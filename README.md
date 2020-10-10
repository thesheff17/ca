## ca - chromebook and ansible

This will quickly bootstrap a chromebook running linux with ansible.

```
git clone https://github.com/thesheff17/ca.git && cd ca && time sudo ./ansible_client.sh thesheff17yt 192.168.1.203
```

Now see if ansible is working correctly
```
ansible -m ping -i inventory dev
192.168.1.247 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

Now lets run the entire playbook:

```
ansible-playbook dev.yml -i inventory

PLAY RECAP *******************************************************************************************************
192.168.1.247              : ok=22   changed=11   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

I run this so much you can just do: `./run.sh`

More details:
I will break everything into ansible roles as much as possible.  
You can run individual playbooks with a single command:
```
ansible-playbook dev.yml -i inventory --tags "precheck"
```
I will try to make each playbook isolated as possible. 
