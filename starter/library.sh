#!/bin/sh
mkdir --parents ~/code/personal && \
mkdir --parents ~/code/repository && \
mkdir --parents ~/code/source && \
mkdir --parents ~/tools/bin && \
#
# git
git config --global user.email "pickjob@126.com"
git config --global user.name "吴胜"
echo "# tools/bin" >> ~/.bashrc && \
echo "export PATH=~/tools/bin:\$PATH" >> ~/.bashrc
#
# vim
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
# ln --symbolic --force `pwd`/vim/vimrc ~/.vimrc && \
# ln --symbolic --force `pwd`/vim/vim-base.vim ~/.vim/base.vim && \
# ln --symbolic --force `pwd`/vim/vim-plug.vim ~/.vim/plug.vim && \
# ln --symbolic --force `pwd`/vim/vim-my.vim ~/.vim/my.vim
#
# python
pip3 install --user requests beautifulsoup4 openpyxl
#
# npm
echo "prefix=~/code/repository/npm" > ~/.npmrc && \
echo "cache=~/code/repository/npm/cache" >> ~/.npmrc && \
echo "registry=http://npmreg.proxy.ustclug.org" >> ~/.npmrc && \
echo "# npm" >> ~/.bashrc && \
echo "export PATH=~/code/repository/npm/bin:\$PATH" >> ~/.bashrc
npm install -g typescript
npm install -g @angular/cli
#
# rust
curl https://sh.rustup.rs rust-init.sh | sh rust-init.sh -y
echo "# rust" >> ~/.bashrc && \
echo "export PATH=~/.cargo/bin:\$PATH" >> ~/.bashrc
rustup component add rls rust-analysis rust-src rustfmt

# "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn/"]

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

