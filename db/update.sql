CREATE DATABASE VBDataSource;
USE VBDataSource;

CREATE TABLE authors (
  ID         BIGINT(20) NOT NULL AUTO_INCREMENT,
  firstName  VARCHAR(255) NOT NULL,
  lastName   VARCHAR(255) NOT NULL,
  speciality VARCHAR(255) NOT NULL,
  PRIMARY KEY pk (ID)
)
  CHARACTER SET UTF8,
  ENGINE = InnoDB;


CREATE TABLE topics (
  ID        BIGINT(20) NOT NULL AUTO_INCREMENT,
  topicName VARCHAR(255) NOT NULL,
  author    BIGINT(20) NOT NULL,
  PRIMARY KEY pk (ID),
  CONSTRAINT fk_author FOREIGN KEY (author) REFERENCES authors (ID)
)
  CHARACTER SET UTF8,
  ENGINE = InnoDB;

CREATE TABLE articles (
  ID          BIGINT(20) NOT NULL AUTO_INCREMENT,
  articleName VARCHAR(255) NOT NULL,
  content     TEXT         NOT NULL,
  author      BIGINT(20) NOT NULL,
  topic       BIGINT(20) NOT NULL,
  PRIMARY KEY pk (ID),
  CONSTRAINT fk_topic_a FOREIGN KEY (topic) REFERENCES topics (ID),
  CONSTRAINT fk_author_a FOREIGN KEY (author) REFERENCES authors (ID)
)
  CHARACTER SET UTF8,
  ENGINE = InnoDB;
