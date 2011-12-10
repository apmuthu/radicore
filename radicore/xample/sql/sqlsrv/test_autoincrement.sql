use [xample];

CREATE TABLE test_autoincrement (
  id int IDENTITY(1,1) NOT NULL,
  field1 nvarchar(40) default NULL,
  field2 nvarchar(255) default NULL,
  PRIMARY KEY (id)
);
