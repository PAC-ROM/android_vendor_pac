#!/usr/bin/env python
import os
import sys
import urllib2
import json
import re
from xml.etree import ElementTree

target = sys.argv[1];

try:
    def_file = target[target.index("_") + 1:]
    def_file = def_file + ".adds"
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

def is_in_manifest(projectname):
    try:
        lm = ElementTree.parse(".repo/local_manifests/roomservice.xml")
        lm = lm.getroot()
    except:
        lm = ElementTree.Element("manifest")

    for localpath in lm.findall("project"):
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
        repo_target = repository['target_path']

        try:
            repo_remote = repository['remote']
        except:
            repo_remote = "github"

        try:
            repo_revision = repository['revision']
        except:
            repo_revision = "cm-11.0"

        try:
            repo_account = repository['account']
            repo_full = repo_account + '/' + repo_name
        except:
            repo_full = repo_name

        if exists_in_tree(lm, repo_full):
            print '%s already exists' % repo_full
            continue

        print 'Adding project: %s -> %s' % (repo_full, repo_target)
        project = ElementTree.Element("project", attrib = { "path": repo_target,
            "remote": repo_remote, "name": repo_full, "revision": repo_revision })

        if 'branch' in repository:
            project.set('revision',repository['branch'])

        lm.append(project)

    indent(lm, 0)
    raw_xml = ElementTree.tostring(lm)
    raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

    f = open('.repo/local_manifests/roomservice.xml', 'w')
    f.write(raw_xml)
    f.close()

def fetch_extras(def_file):
    print 'Looking for add projects entries'
    projects_path = 'vendor/pac/manifest/' + def_file

    syncable_repos = []

    if os.path.exists(projects_path):
        projects_file = open(projects_path, 'r')
        projects = json.loads(projects_file.read())
        fetch_list = []

        for project in projects:
            try:
                repo_account = project['account']
                repo_full = repo_account + '/' + project['repository']
            except:
                repo_full = project['repository']

            print '  Check for %s in local_manifest' % repo_full
            if not is_in_manifest(repo_full):
                print 'Appending %s to fetch_list and %s to syncable_repos' % (repo_full, project['target_path'])
                fetch_list.append(project)
                syncable_repos.append(project['target_path'])
            else:
                print '  %s already in local_manifest' % repo_full

        projects_file.close()

        if len(fetch_list) > 0:
            print 'Adding projects to local_manifest'
            add_to_manifest(fetch_list)
    else:
        print 'add projects definition file not found, bailing out.'

    if len(syncable_repos) > 0:
        print 'Syncing projects'
        os.system('repo sync %s' % ' '.join(syncable_repos))


fetch_extras(def_file)
