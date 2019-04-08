#!/bin/sh
mkdir --parents ~/code/personal && \
mkdir --parents ~/code/repository && \
mkdir --parents ~/code/source && \
mkdir --parents ~/tools/bin && \
#
# git
git config --global user.email "pickjob@126.com"
git config --global user.name "吴胜"
#
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
#
# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
ln --symbolic --force `pwd`/vim/vimrc ~/.vimrc && \
ln --symbolic --force `pwd`/vim/vim-base.vim ~/.vim/base.vim && \
ln --symbolic --force `pwd`/vim/vim-plug.vim ~/.vim/plug.vim && \
ln --symbolic --force `pwd`/vim/vim-my.vim ~/.vim/my.vim && \
ln --symbolic --force `pwd`/vim/coc-settings.json ~/.vim/coc-settings.json
#
# python
pip3 install --user requests beautifulsoup4 openpyxl pylint
#
# npm
npm install -g typescript
npm install -g @angular/cli
#
# yarn
curl -o- -L https://yarnpkg.com/install.sh | bash
#
# rust
curl https://sh.rustup.rs rust-init.sh | sh rust-init.sh -y
rustup component add rls rust-analysis rust-src rustfmt

# docker image pull pickjob/pause:3.1
# docker tag pickjob/pause:3.1 k8s.gcr.io/pause:3.1
# docker image pull pickjob/k8s-dns-kube-dns-amd64:1.14.7
# docker tag pickjob/k8s-dns-kube-dns-amd64:1.14.7 gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.7
# docker image pull pickjob/k8s-dns-dnsmasq-nanny-amd64:1.14.7
# docker tag pickjob/k8s-dns-dnsmasq-nanny-amd64:1.14.7 gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.7
# docker image pull pickjob/k8s-dns-sidecar-amd64:1.14.7
# docker tag pickjob/k8s-dns-sidecar-amd64:1.14.7 gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.7
# docker image pull pickjob/heapster-influxdb-amd64:v1.3.3
# docker tag pickjob/heapster-influxdb-amd64:v1.3.3 k8s.gcr.io/heapster-influxdb-amd64:v1.3.3
# docker image pull pickjob/heapster-grafana-amd64:v4.4.3
# docker tag pickjob/heapster-grafana-amd64:v4.4.3 k8s.gcr.io/heapster-grafana-amd64:v4.4.3
# docker image pull pickjob/kubernetes-dashboard-amd64:v1.8.3
# docker tag pickjob/kubernetes-dashboard-amd64:v1.8.3 k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3
# docker image pull pickjob/heapster-amd64:v1.5.2
# docker tag pickjob/heapster-amd64:v1.5.2 k8s.gcr.io/heapster-amd64:v1.5.2

