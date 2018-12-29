#!/usr/bin/python3

import requests
from bs4 import BeautifulSoup
import os
import subprocess

githubUser = ''
sourceDir = '/mnt/c/personal'
baseUrl = 'https://github.com'
repositories = []

def checkPages(githubRepository, repositories):
    url = baseUrl + '/' + githubRepository + '?tab=repositories'
    r = requests.get(url)
    soup = BeautifulSoup(r.text, 'html.parser')
    for a in soup.select('#user-repositories-list  ul li  a[itemprop="name codeRepository"]'):
        repositories.append(a['href'])
    for a in soup.select('#org-repositories  ul li  a[itemprop="name codeRepository"]'):
        repositories.append(a['href'])
    for nxPage in soup.select('a.next_page'):
        checkPages(baseUrl+nxPage['href'])

checkPages(githubUser, repositories)
print('总计: ', len(repositories))
sourceDir += '/' + githubUser + '/'

if not os.path.exists(sourceDir):
    os.makedirs(sourceDir)
for repo in repositories:
    u = baseUrl + repo + '.git'
    print('github repository url: ', url)
    subprocess.call(['git', 'clone', 'u'], shell=True, cwd=sourceDir)

