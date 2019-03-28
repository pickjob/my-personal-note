#!/usr/bin/python3
# -*- coding: utf-8 -*-
import requests
from bs4 import BeautifulSoup
import os
import subprocess

githubUser = ''
sourceDir = '/home/china/code/source'
baseUrl = 'https://github.com'
repositories = []

def checkPages(githubRepository):
    url = baseUrl + '/' + githubRepository + '?tab=repositories'
    r = requests.get(url)
    soup = BeautifulSoup(r.text, 'html.parser')
    for a in soup.select('#user-repositories-list  ul li  a[itemprop="name codeRepository"]'):
        repositories.append(a['href'])
    for a in soup.select('#org-repositories  ul li  a[itemprop="name codeRepository"]'):
        repositories.append(a['href'])
    for nxPage in soup.select('a.next_page'):
        checkPages(baseUrl+nxPage['href'])

checkPages(githubUser)
print('总计: ', len(repositories))
sourceDir += '/' + githubUser + '/'

if not os.path.exists(sourceDir):
    os.makedirs(sourceDir)
for repo in repositories:
    u = baseUrl + repo + '.git'
    print('github repository url: ', u)
    subprocess.call(['git clone %s' % u], shell=True, cwd=sourceDir)

