FROM mysql:5.7.22

COPY ./configs/mysql.cnf /etc/mysql/conf.d/mysql.cnf
COPY ./configs/mysqldump.cnf /etc/mysql/conf.d/mysqldump.cnf
COPY ./configs/optimize.cnf /etc/mysql/conf.d/optimize.cnf