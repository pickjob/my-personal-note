# 清理
mvn clean
# 编译
mvn compile package -Dmaven.test.skip=true
# 安装
mvn install
# 依赖树
mvn dependency:tree
