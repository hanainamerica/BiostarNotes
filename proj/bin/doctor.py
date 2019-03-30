#!/usr/bin/env python
#
# Licensed under the Biostar Handbook license.
#
from __future__ import print_function, unicode_literals

import os
import re
import subprocess
import sys
from os.path import expanduser
from sys import platform

PY3 = True if (sys.version_info > (3, 0)) else False

def exists():
    return True

def regexp_check(pattern, text):
    return re.search(pattern, text, re.MULTILINE)


def more_recent(pattern, text):
    version = text.strip()
    return version >= pattern


# A list of tools to check.
TOOLS = [
    # Name, pattern, required, match_func
    ('bwa', '', True, regexp_check),
    ('datamash --version', '', True, regexp_check),
    ('fastqc --version', '', True, regexp_check),
    ('hisat2', '', True, regexp_check),
    ('seqret --version', '', True, regexp_check),
    ('subread-align', '', True, regexp_check),
    ('featureCounts', '', True, regexp_check),
    ('efetch -version', '', True, exists),
    ('esearch -version', '', True, exists),
    ('samtools --version', '1.3', True, more_recent),
    ('fastq-dump -version', '2.8.0', True, more_recent),
    ('global-align.sh', '', False, regexp_check),
    ('local-align.sh', '', False, regexp_check),
]

def bash_check():
    bashrc = expanduser("~/.bashrc")
    bashprofile = expanduser("~/.bash_profile")

def path_check():
    errors = 0
    # The PATH variable
    paths = os.environ.get('PATH').split(':')
    bindir = expanduser("~/bin")

    #
    # We need ~/bin to be in the PATH
    #
    if bindir not in paths:
        errors += 1
        print("# The ~/bin folder is not in your PATH!")

    return errors


def tool_check(tools):
    errors = 0
    print("# Checking {} symptoms...".format(len(tools)))
    for cmd, pattern, required, callback in tools:
        args = cmd.split()
        try:
            proc = subprocess.Popen(args, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
            stdout, stderr = proc.communicate()
        except OSError as exc:
            if required:
                word = cmd.split()[0]
                print("# ERROR! Missing program: {}".format(word))
                errors += 1
            else:
                print("# Optional program not found: {}".format(cmd))
            continue

        stdout = stdout.decode('utf-8')
        stderr = stderr.decode('utf-8')

        output = stdout + stderr

        if pattern:
            if not callback(pattern, output):
                print("# Version {} mismatch for: {}".format(pattern, cmd))
                errors += 1
                continue

    return errors

FIXME = """
#
# How to delete your environment and reinstall everything.
#

source deactivate
conda update conda -y
conda remove --name bioinfo --all -y
conda create --name bioinfo python=3.6 -y 
curl http://data.biostarhandbook.com/install/conda.txt | xargs conda install -y

#
# How to install Entrez Direct from source.
#

mkdir -p ~/src
curl ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.zip > ~/src/edirect.zip
unzip -o ~/src/edirect.zip  -d ~/src
echo 'export PATH=~/src/edirect:$PATH' >> ~/.bash_profile
source  ~/.bash_profile

"""


def fixme():
    print (FIXME)

def health_check():

    errors = 0
    errors += path_check()
    errors += tool_check(tools=TOOLS)

    if errors:
        if errors == 1:
            print("# Your system shows 1 error!")
        else:
            print("# Your system shows {} errors.".format(errors))
        print("# See also: doctor.py --fixme")
    else:
        print("# You are doing well!")

if __name__ == '__main__':
    if '--fixme' in sys.argv:
        fixme()
    else:
        print("# Doctor! Doctor! Give me the news.")
        health_check()
