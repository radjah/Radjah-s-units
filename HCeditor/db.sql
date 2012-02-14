CREATE TABLE cstruct (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,cid integer NOT NULL,corder integer NOT NULL,sid integer NOT NULL);
CREATE TABLE cycle (
  cid    integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  cname  varchar(128) NOT NULL
);
CREATE TABLE sstruct (pid integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,sid integer NOT NULL,clevel integer NOT NULL,ptime integer NOT NULL);
CREATE TABLE stages (
  sid    integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
  sname  varchar(128) NOT NULL
);
CREATE INDEX cindex ON sstruct(sid);
CREATE INDEX sindex ON cstruct(sid);
