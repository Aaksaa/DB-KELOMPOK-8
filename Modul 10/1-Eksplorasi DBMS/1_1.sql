SELECT VERSION();
-- mysql> SELECT VERSION();
-- +-----------+
-- | VERSION() |
-- +-----------+
-- | 8.4.3     |
-- +-----------+
-- 1 row in set (0.00 sec)


SELECT @@version_comment;
-- mysql> SELECT @@version_comment;
-- +------------------------------+
-- | @@version_comment            |
-- +------------------------------+
-- | MySQL Community Server - GPL |
-- +------------------------------+
-- 1 row in set (0.00 sec)


SHOW ENGINES;
-- mysql> SHOW ENGINES;
-- +--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
-- | Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
-- +--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
-- | MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
-- | MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
-- | CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
-- | FEDERATED          | NO      | Federated MySQL storage engine                                 | NULL         | NULL | NULL       |
-- | PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
-- | MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
-- | InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
-- | ndbinfo            | NO      | MySQL Cluster system information storage engine                | NULL         | NULL | NULL       |
-- | BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
-- | ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
-- | ndbcluster         | NO      | Clustered, fault-tolerant tables                               | NULL         | NULL | NULL       |
-- +--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
-- 11 rows in set (0.01 sec)


SHOW DATABASES;
-- mysql> SHOW DATABASES;
-- +-----------------------+
-- | Database              |
-- +-----------------------+
-- | classicmodels         |
-- | db_keuangan           |
-- | information_schema    |
-- | mysql                 |
-- | performance_schema    |
-- | praktikum_modul10     |
-- | sdg_transport_db      |
-- | sdg_transport_db_test |
-- | sys                   |
-- | test                  |
-- | test_2                |
-- +-----------------------+
-- 11 rows in set (0.02 sec)