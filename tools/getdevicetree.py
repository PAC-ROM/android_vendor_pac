#!/usr/bin/env python
import os
import sys
import urllib2
import json
import re
from xml.etree import ElementTree

device = sys.argv[1];

manufacturer = None

def isNullOrEmpty(value):
    return value is None or len(value) < 0

for dirname, dirnames, filenames in os.walk('./device/'):
    for subdirname in dirnames:
        path = os.path.join(dirname, subdirname)[9:]
        if device in path:
            manufacturer = path[:path.find('/')];

if isNullOrEmpty(manufacturer):
    manufacturer = raw_input('Manufacturer not found, please write your device manufacturer: ')

device_path = 'device/'+manufacturer+'/'+device
repo_full = 'PAC-man/android_' + device_path.replace('/', '_')

def exists_in_tree(lm, repository):
    for child in lm.getchildren():
        if child.attrib['name'].endswith(repository):
            return True
    return False

# in-place prettyprint formatter
def indent(elem, level=0):
    i = '\n' + level*'  '
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + '  '
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
        lm = ElementTree.parse('.repo/local_manifest.xml')
        lm = lm.getroot()
    except:
        lm = ElementTree.Element('manifest')

    for localpath in lm.findall('project'):
        if localpath.get('name') == projectname:
            return 1

    return None

def add_to_manifest(repositories):
    try:
        lm = ElementTree.parse('.repo/local_manifest.xml')
        lm = lm.getroot()
    except:
        lm = ElementTree.Element('manifest')

    for repository in repositories:
        repo_account = "PAC-man"
        repo_name = 'android_'+device_path.replace('/', '_')
        repo_target = device_path
        if exists_in_tree(lm, repo_full):
            print '%s already exists' % repo_full
            continue

        print 'Adding device: %s -> %s' % (repo_full, repo_target)
        project = ElementTree.Element('project', attrib = { 'path': repo_target,
            'remote': 'github', 'name': repo_full, 'revision': 'jellybean' })

        if 'branch' in repository:
            project.set('revision',repository['branch'])

        lm.append(project)

    indent(lm, 0)
    raw_xml = ElementTree.tostring(lm)
    raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

    f = open('.repo/local_manifest.xml', 'w')
    f.write(raw_xml)
    f.close()

def fetch_device(device, manufacturer):
    print 'Looking for device files'

    syncable_repos = []

    if not os.path.exists(device_path):
        fetch_list = []
        print '  Check for %s in local_manifest' % repo_full
        if not is_in_manifest(repo_full):
            fetch_list.append(device_path)
            syncable_repos.append(device_path)
            print 'Adding device to local_manifest'
            add_to_manifest(fetch_list)
        else:
            print '  %s already in local_manifest' % repo_full
    else:
        print 'Device tree found. Skipping step.'

    if len(syncable_repos) > 0:
        print 'Syncing device'
        os.system('repo sync %s' % ' '.join(syncable_repos))


fetch_device(device, manufacturer)
