#!/usr/bin/env python
import os
import time
import subprocess

filename_format = '%Y-%m-%d'

file_extension = '.md'

# date format to place within files
# subheading for each entry
entry_string='### %H:%M'

# date format to place at top of journal files as heading
title_string='# %A %d %B, %Y'

# file extension
file_extension = '.md'

# directory to store journal files
journal_dir=os.path.expanduser('~/notes/journal')

def whats_the_time(format):
    return time.strftime(format, time.localtime(time.time()))

def make_filename():
    return whats_the_time(filename_format) + file_extension

def new_file_required():
    if os.path.exists(os.path.join(journal_dir,make_filename())):
        return False
    else:
        return True

def create_file():
    path = os.path.join(journal_dir,make_filename())
    with open(path, 'w') as f:
        f.write(whats_the_time(title_string))
                
def write_date():
    path = os.path.join(journal_dir,make_filename())
    with open(path, 'a') as f:
        f.write('\n' + whats_the_time(entry_string))
            
def open_editor():
    editor = [
        'emacs',
        os.path.join(journal_dir, make_filename())
    ]
    process = subprocess.Popen(editor, stdout=subprocess.PIPE)

def main():
    if new_file_required():
        create_file()
        write_date()
        open_editor()
        exit()
    else:
        write_date()
        open_editor()
        exit()

main()
