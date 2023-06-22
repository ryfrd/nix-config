#!/usr/bin/env python

from os import environ, popen
import random

def kernel():
    with open('/proc/version', 'r') as r:
        content = r.read()
        content = content.split()
        return content[2]

def os():
    with open('/etc/os-release', 'r') as r:
        content = r.read()
        content = content.split('PRETTY_NAME="')
        content = content[1].split('"')
        os_name = content[0]
        return os_name

def shell():
    sh = environ['SHELL']
    sh = sh.split('/bin/')
    return sh[-1]
    
def user():
    return environ['USER']

def host():
    with open('/etc/hostname', 'r') as r:
        return r.read().strip()

def uptime():
    with open('/proc/uptime', 'r') as r:
        up = round(float(r.read().split()[0]))
        # seconds
        if up < 60:
            return f'{up}s'
        # minutes
        elif up < (60 * 60):
            secs = up % 60
            mins = up // 60
            return f'{mins}m {secs}s'
        # hours
        elif up < (60 * 60 * 24):
            mins = (up % (60 * 60)) // 60
            hours = up // (60 * 60)
            return f'{hours}h {mins}m'
        # days
        else:
            hours = (up % (60 * 60 * 24)) // (60 * 60)
            days = up // (60 * 60 * 24)
            return f'{days}d {hours}h'

def memory():
    with open('/proc/meminfo', 'r') as r:
        content = r.read()

        mem_total = content.split('MemTotal:')
        mem_total = mem_total[1]
        mem_total = mem_total.split()
        mem_total = mem_total[0]
        mem_total = round(int(mem_total) / 1024)
        
        mem_used = content.split('Active:')
        mem_used = mem_used[1]
        mem_used = mem_used.split()
        mem_used = mem_used[0]
        mem_used = round(int(mem_used) / 1024)

        return f'{mem_used}M / {mem_total}M'

def cpu():
    with open('/proc/cpuinfo', 'r') as r:
        content = r.read()

        model_name = content.split('model name	: ')
        model_name = model_name[1]
        model_name = model_name.split('\n')
        model_name = model_name[0]

        return model_name

def pkgs():
    system_pkgs = popen('nix-store -qR /run/current-system/sw | wc -l').read().strip()
    user_pkgs = popen('nix-store -qR /home/james/.nix-profile | wc -l').read().strip()
    return f'{system_pkgs} (system) {user_pkgs} (user)'

print_dict = {
    'os': os(),
    'kernel': kernel(),
    'uptime': uptime(),
    'shell': shell(),
    'memory': memory(),
    'pkgs': pkgs()
}

def esc(code):
    return f'\033[{code}m'

sep = ' | '

def print_nice():
    print(f'{esc("0;1")}{user()}@{host()}{esc("0")}')
    for item in print_dict:
        print(f'{esc("0;1;31")}{item}{esc("0;1;32")}{sep}{esc("0")}{print_dict[item]}')

print_nice()
