#!/usr/bin/env python
#
# removeprojects.py: remove projects on demand to the local manifest
# Copyright (C) 2015 The PAC-ROM Project
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

from __future__ import print_function

import os
import sys
import json
import re
from xml.etree import ElementTree

try:
  # For python3
  import urllib.request
except ImportError:
  # For python2
  import imp
  import urllib2
  urllib = imp.new_module('urllib')
  urllib.request = urllib2

target = sys.argv[1];

try:
    def_file = target[target.index("_") + 1:]
    def_file = def_file + ".removes"
except:
    def_file = target

def exists_in_tree(lm, repository):
    for child in lm.getchildren():
        if child.attrib['name'].endswith(repository):
            return True
    return False

# in-place prettyprint formatter
def indent(elem, level=0):
    i = "\n" + level*"  "
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + "  "
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
        for elem in elem:
            indent(elem, level+1)
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i

def name_in_manifest(projectname):
    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for localpath in lm.findall("remove-project"):
        if localpath.get("name") == projectname:
            return 1

    return None

def add_to_manifest(repositories):
    if not os.path.exists(".repo/local_manifests/"):
        os.makedirs(".repo/local_manifests/")

    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for repository in repositories:
        repo_name = repository['name']
        if exists_in_tree(lm, repo_name):
            print('%s already exists' % repo_name)
            continue

        print('Adding remove-project: %s' % (repo_name))
        project = ElementTree.Element("remove-project", attrib = { "name": repo_name })

        if 'branch' in repository:
            project.set('revision',repository['branch'])

        lm.insert(0,project)

    indent(lm, 0)
    raw_xml = ElementTree.tostring(lm)
    raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

    f = open('.repo/local_manifests/roomservice.xml', 'w')
    f.write(raw_xml)
    f.close()

def process_removes(def_file):
    print('Looking for remove projects entries')
    projects_path = 'vendor/pac/extras/addremove/' + def_file

    if os.path.exists(projects_path):
        projects_file = open(projects_path, 'r')
        projects = json.loads(projects_file.read())
        fetch_list = []

        for project in projects:
            repo_name = project['name']
            print('  Check for %s in local_manifest' % repo_name)
            if not name_in_manifest(repo_name):
                fetch_list.append(project)
            else:
                print('  %s already in local_manifest' % repo_name)

        projects_file.close()

        if len(fetch_list) > 0:
            print('Adding remove-project entries to local_manifest')
            add_to_manifest(fetch_list)
    else:
        print('remove projects definition file not found, bailing out.')

process_removes(def_file)
