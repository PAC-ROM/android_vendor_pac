#!/usr/bin/env python
#
# getdependencies.py: add the necessary dependencies to the local manifest
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

if len(sys.argv) > 2:
    os.system('rm -f .repo/local_manifests/roomservice.xml')

device = sys.argv[1];

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

def is_in_manifest(projectname):
    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for localpath in lm.findall("project"):
        if localpath.get("name") == projectname:
            return 1

    try:
        lm = ElementTree.parse(".repo/local_manifests/device.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for localpath in lm.findall("project"):
        if localpath.get("name") == projectname:
            return 1

    try:
        mm = ElementTree.parse(".repo/manifest.xml")
        mm = mm.getroot()
    except:
        mm = ElementTree.Element("manifest")

    for localpath in mm.findall("project"):
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
        repo_name = repository['repository']
        try:
            repo_account = repository['account']
            repo_full = repo_account + '/' + repo_name
        except:
            repo_full = repo_name
        repo_target = repository['target_path']
        repo_revision = repository['revision']
        if exists_in_tree(lm, repo_full):
            print('%s already exists' % repo_full)
            continue
        try:
            repo_remote = repository['remote']
        except:
            repo_remote = "github"

        print('Adding dependency: %s -> %s' % (repo_full, repo_target))
        project = ElementTree.Element("project", attrib = { "path": repo_target,
            "remote": repo_remote, "name": repo_full, "revision": repo_revision })

        if 'branch' in repository:
            project.set('revision',repository['branch'])

        lm.append(project)

    indent(lm, 0)
    raw_xml = ElementTree.tostring(lm).decode('utf-8')
    raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

    f = open('.repo/local_manifests/roomservice.xml', 'w')
    f.write(raw_xml)
    f.close()

def fetch_dependencies(device):
#    print('Looking for PAC product dependencies')
    dependencies_path = 'vendor/pac/dependencies/' + device + '.dependencies'

    syncable_repos = []

    if os.path.exists(dependencies_path):
        dependencies_file = open(dependencies_path, 'r')
        dependencies = json.loads(dependencies_file.read())
        fetch_list = []

        for dependency in dependencies:
            try:
                repo_account = dependency['account']
                repo_full = repo_account + "/" + dependency['repository']
            except:
                repo_full = dependency['repository']
            print('  Check for %s in local_manifest' % repo_full)
            if not is_in_manifest(repo_full):
                fetch_list.append(dependency)
                syncable_repos.append(dependency['target_path'])
            else:
                print('    %s already in local_manifest' % repo_full)

        dependencies_file.close()

        if len(fetch_list) > 0:
            print('Adding dependencies to local_manifest')
            add_to_manifest(fetch_list)
#    else:
#        print('dependencies definition file not found, bailing out.')

    if len(syncable_repos) > 0:
        print('Syncing dependencies')
        os.system('repo sync %s' % ' '.join(syncable_repos))


fetch_dependencies(device)
