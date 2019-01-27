# mysql学习
- Commands
  - mysql --host=host --user=user --password=pwd
  - mysqladmin
  - mysqlcheck
  - mysqldump
    - mysqldump --all-databases --master-data --single-transaction > back.sql
  - mysqlimport
  - mysqlpump
  - mysqlshow
  - mysqlbinlog
  - mysqld
    - --verbose --help
    - --validate-config
    - --log0error-verbosity=3
- SQL
    ```sql
    // privileges
    CREATE USER 'user'@'%' IDENTIFIED BY 'passowrd';
    GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' WITH GRANT OPTION;
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
    SHOW GRANTS FOR 'user'@'%';
    SHOW DATABASES;
    CREATE DATABSE pets;
    USE PETS;
    SHOW TABLES;
    DESCRIEBE cats;
    LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet [LINES TERMINATED BY '\r\n';
    QUIT;
    source filename;
    \. filename;
    SHOW VARIABLES;
    SHOW STATUS;
    ```
- packages
  - mysql-community-sever: mysqld
  - mysql-community-client
  - mysql-community-test
  - mysql-community-bench
  - mysql-workbench-community
  - mysql-router