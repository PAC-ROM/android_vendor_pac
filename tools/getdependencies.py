#!/usr/bin/env python
import os
import sys
import urllib2
import json
import re
from xml.etree import ElementTree

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
        lm = ElementTree.parse(".repo/local_manifest.xml")
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
    try:
        lm = ElementTree.parse(".repo/local_manifest.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for repository in repositories:
        repo_account = repository['account']
        repo_name = repository['repository']
        repo_target = repository['target_path']
        repo_full = repo_account + '/' + repo_name
        repo_revision = repository['revision']
        if exists_in_tree(lm, repo_full):
            print '%s already exists' % repo_full
            continue

        print 'Adding dependency: %s -> %s' % (repo_full, repo_target)
        project = ElementTree.Element("project", attrib = { "path": repo_target,
            "remote": "github", "name": repo_full, "revision": repo_revision })

        if 'branch' in repository:
            project.set('revision',repository['branch'])

        lm.append(project)

    indent(lm, 0)
    raw_xml = ElementTree.tostring(lm)
    raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

    f = open('.repo/local_manifest.xml', 'w')
    f.write(raw_xml)
    f.close()

def fetch_dependencies(device):
#    print 'Looking for PAC product dependencies'
    dependencies_path = 'vendor/pac/dependencies/' + device + '.dependencies'

    syncable_repos = []

    if os.path.exists(dependencies_path):
        dependencies_file = open(dependencies_path, 'r')
        dependencies = json.loads(dependencies_file.read())
        fetch_list = []

        for dependency in dependencies:
            repo_full = dependency['account'] + "/" + dependency['repository']
            print '  Check for %s in local_manifest' % repo_full
            if not is_in_manifest(repo_full):
                fetch_list.append(dependency)
                syncable_repos.append(dependency['target_path'])
            else:
                print '    %s already in local_manifest' % repo_full

        dependencies_file.close()

        if len(fetch_list) > 0:
            print 'Adding dependencies to local_manifest'
            add_to_manifest(fetch_list)
#    else:
#        print 'dependencies definition file not found, bailing out.'

    if len(syncable_repos) > 0:
        print 'Syncing dependencies'
        os.system('repo sync %s' % ' '.join(syncable_repos))


fetch_dependencies(device)
