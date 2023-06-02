#!/usr/bin/env python 
import os
import random

sep = '.'

def fetch_kernel():
    with open('/proc/version', 'r') as r:
        content = r.read()
        content = content.split()
        return content[2]

def fetch_os():
    with open('/etc/os-release', 'r') as r:
        content = r.read()
        content = content.split('PRETTY_NAME="')
        content = content[1].split('"')
        os_name = content[0].lower()
        return os_name

def fetch_shell():
    sh = os.environ['SHELL']
    sh = sh.split('/bin/')
    return sh[-1]
    

def fetch_term():
    return os.environ['TERM']

def fetch_editor():
    return os.environ['EDITOR']

def fetch_user():
    return os.environ['USER']

def fetch_host():
    with open('/etc/hostname', 'r') as r:
        return r.read().strip()

print_dict = {
        'user': fetch_user(),
        'host': fetch_host(),
        'kernel': fetch_kernel(),
        'os': fetch_os(),
        'shell': fetch_shell(),
        }

def find_max_width():
    widths = []
    for item in print_dict:
        width = item + '  ' + print_dict[item]
        width = len(width)
        widths.append(width)
    return max(widths)

def print_nice():
    for item in print_dict:
        width = item + '  ' + print_dict[item]
        width = len(width)
        max_width = find_max_width()
        diff = max_width - width

        if diff != 0:
            print(item,sep*(diff + 1), print_dict[item])
        else:
            print(item,sep,print_dict[item])

print_nice()
