CREATE DATABASE VBDataSource;
USE VBDataSource;

CREATE TABLE authors (
  ID         varchar(255) NOT NULL,
  firstName  VARCHAR(255) NOT NULL,
  lastName   VARCHAR(255) NOT NULL,
  speciality VARCHAR(255) NOT NULL,
  PRIMARY KEY pk (ID)
)
  CHARACTER SET UTF8,
  ENGINE = InnoDB;


CREATE TABLE topics (
  ID        varchar(255) NOT NULL,
  topicName VARCHAR(255) NOT NULL,
  author    VARCHAR(255) NOT NULL,
  PRIMARY KEY pk (ID),
  CONSTRAINT fk_author FOREIGN KEY (author) REFERENCES authors (ID)
)
  CHARACTER SET UTF8,
  ENGINE = InnoDB;

CREATE TABLE articles (
  ID          varchar(255) NOT NULL,
  articleName VARCHAR(255) NOT NULL,
  content     TEXT         NOT NULL,
  author      VARCHAR(255) NOT NULL,
  topic       VARCHAR(255) NOT NULL,
  PRIMARY KEY pk (ID),
  CONSTRAINT fk_topic_a FOREIGN KEY (topic) REFERENCES topics (ID),
  CONSTRAINT fk_author_a FOREIGN KEY (author) REFERENCES authors (ID)
)
  CHARACTER SET UTF8,
  ENGINE = InnoDB;