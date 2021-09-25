repository=~/repository

# maven
export MAVEN_HOME=${repository}/maven

# gradle
export GRADLE_HOME=${repository}/gradle

# rust
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RUSTUP_HOME=${repository}/rustup
export CARGO_HOME=${repository}/cargo
export PATH=~${repository}/cargo/bin:$PATH

# python
export PYTHONUSERBASE=${repository}/python
export PATH=${repository}/python/bin/:$PATH

# golang
export GOPATH=${repository}/golang
export PATH=${repository}/golang/bin/:$PATH

# npm
export PATH=${repository}/npm/bin/:$PATH
