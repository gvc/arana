# Araña!!

![Araña!!](http://dl.dropbox.com/u/10232797/108-arana_1_350.jpg)

Web crawler to look for news page on El País

database schema:
  CREATE TABLE links (
    id INTEGER NOT NULL, 
    title VARCHAR(1000), 
    target VARCHAR(1000), 
    PRIMARY KEY(id)
  );
  
  CREATE TABLE words (
    id INTEGER NOT NULL, 
    term VARCHAR(255), 
    count INTEGER, 
    PRIMARY KEY(id)
  );
  