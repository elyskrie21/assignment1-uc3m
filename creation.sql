CREATE TABLE product (
  id VARCHAR2(100),
  name VARCHAR2(100),
  coffea VARCHAR2(100),
  varietal VARCHAR2(100),
  origin VARCHAR2(100),
  roasting VARCHAR2(100) /* include the different options "natural", "high-roast", "mixture" */
  dcafprocess VARCHAR2(100),
  format VARCHAR2(100),
  packaging VARCHAR2(100),
  CONSTRAINT pk_product PRIMARY KEY(id)
);



CREATE TABLE comment (
  id LONG,
  RegisteredClientID LONG,
  post_date CHAR(100),
  post_time CHAR(100),
  title CHAR(100),
  text CHAR(100),
  score CHAR(100),
  likes CHAR(100) DEFAULT '0',
  endorsed CHAR(12),
  CONSTRAINT pk_product PRIMARY KEY(id),
  FOREIGN KEY (RegisteredClientID) REFERENCES RegisteredClient(ID),
  ); 
  
