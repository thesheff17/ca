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

You can also limit to just the vim role.  Many times I come to a computer
that is not controlled by ansible.  This leads to problems but you should be
able to run the vim role against this box to get it into a dev box. Here is a
small sample of what is required to get the vim role to run correctly already
already existing boxes. Tested on ubuntu 20.04 64 bit Oct 26 2020:
```
sudo apt install net-tools tmux vim golang rustc npm nodejs openjdk-14-jdk cmake build-essential ctags git python3-dev python3-pip inotify-tools
sudo pip3 install ansible
# test connection
ansible -m ping -i inventory dev
# run vim playbook
ansible-playbook dev.yml -i inventory --tags "vim"
```

### notes about making the remote instances
* this won't work on a virtual devices. We expect access to the processors virtualization technology.
  if you think you have this and it is not enabled please check the bios.

```
# this should say more then 0
grep --color vmx /proc/cpuinfo | wc -l
8
```
* make sure if it is a laptop to disable power management features.  Including closing the lid.
* make sure ssh is running and installed.  `sudo apt-get install ssh && sudo systemctl enable ssh`
* make sure you have a user called youtube and you have your public key in `.ssh/authorized_keys`
* manage images with https://clonezilla.org/ You basically can image machines < 10 minutes.

### support scripts
```
continuous_roles_watcher_mac.sh   - automatically watch the role directory on mac.
continuous_roles_watcher_linux.sh - automatically watch the role directory on linux.
run.sh                            - run the entire playbook once.
```

If you keep having vim spew temp files into the directories being watched you can fix this by adding
this to your `.vimrc`
```
set swapfile
set dir=/tmp
