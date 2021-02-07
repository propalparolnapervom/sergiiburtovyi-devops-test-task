CREATE DATABASE ${DB_NAME};

use ${DB_NAME};

create table ${DB_TABLE_NAME}(
    id int NOT NULL AUTO_INCREMENT,
    message text,
    PRIMARY KEY (id)
);

CREATE USER '${DB_USER_NAME}' IDENTIFIED WITH mysql_native_password BY '${DB_USER_PWD}';

GRANT ALL ON ${DB_NAME}.* TO '${DB_USER_NAME}';