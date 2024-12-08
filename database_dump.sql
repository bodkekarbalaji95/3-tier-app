CREATE DATABASE cmpe273;

USE cmpe273;

-- Creating table: files
CREATE TABLE files (
    filename VARCHAR(255) NOT NULL,
    filepath VARCHAR(500) NOT NULL PRIMARY KEY,
    fileparent VARCHAR(500) NULL,
    isfile CHAR(1) NULL,
    starred CHAR(1) NULL,
    owner VARCHAR(255) NULL,
    sharedcount INT NULL
);

-- Creating table: groupmembers
CREATE TABLE groupmembers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    groupId INT NULL,
    email VARCHAR(200) NULL
);

CREATE INDEX groupmembers_groups_groupId_fk ON groupmembers (groupId);
CREATE INDEX groupmembers_users_email_fk ON groupmembers (email);

-- Creating table: groups
CREATE TABLE groups (
    groupId INT AUTO_INCREMENT PRIMARY KEY,
    groupname VARCHAR(200) NULL,
    membercount INT NULL,
    owner VARCHAR(200) NULL
);

CREATE INDEX groups_users_email_fk ON groups (owner);

-- Adding foreign key constraints to groupmembers
ALTER TABLE groupmembers
    ADD CONSTRAINT groupmembers_groups_groupId_fk FOREIGN KEY (groupId) REFERENCES groups (groupId);

-- Creating table: members
CREATE TABLE members (
    memberId INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(200) NULL,
    lastname VARCHAR(200) NULL,
    email VARCHAR(200) NULL
);

-- Creating table: userfiles
CREATE TABLE userfiles (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    filepath VARCHAR(500) NULL,
    email VARCHAR(500) NULL,
    CONSTRAINT userfiles_ibfk_1 FOREIGN KEY (filepath) REFERENCES files (filepath)
);

CREATE INDEX email ON userfiles (email);
CREATE INDEX filepath ON userfiles (filepath);

-- Creating table: userlog
CREATE TABLE userlog (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    filename VARCHAR(255) NULL,
    filepath VARCHAR(500) NULL,
    isfile CHAR(1) NULL,
    email VARCHAR(500) NULL,
    action VARCHAR(100) NULL,
    actiontime DATETIME NULL
);

CREATE INDEX email ON userlog (email);

-- Creating table: users
CREATE TABLE users (
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NULL,
    email VARCHAR(500) NOT NULL PRIMARY KEY,
    password VARCHAR(255) NULL,
    contact VARCHAR(255) NULL,
    interests VARCHAR(255) NULL,
    lastlogin DATETIME NULL
);

-- Adding foreign key constraints to groupmembers
ALTER TABLE groupmembers
    ADD CONSTRAINT groupmembers_users_email_fk FOREIGN KEY (email) REFERENCES users (email);

-- Adding foreign key constraints to groups
ALTER TABLE groups
    ADD CONSTRAINT groups_users_email_fk FOREIGN KEY (owner) REFERENCES users (email);

-- Adding foreign key constraints to userfiles
ALTER TABLE userfiles
    ADD CONSTRAINT userfiles_ibfk_2 FOREIGN KEY (email) REFERENCES users (email);

-- Adding foreign key constraints to userlog
ALTER TABLE userlog
    ADD CONSTRAINT userlog_ibfk_1 FOREIGN KEY (email) REFERENCES users (email);
