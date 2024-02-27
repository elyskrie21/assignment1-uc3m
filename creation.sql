CREATE TABLE product (
  id LONG,
  name CHAR(50),
  coffea CHAR(20),
  varietal CHAR(30),
  origin CHAR(15),
  roasting CHAR(10) /* include the different options "natural", "high-roast", "mixture" */
  dcafprocess CHAR(12),
  format VARCHAR2(20),
  packaging VARCHAR2(15),
  CONSTRAINT pk_product PRIMARY KEY(id)
);

CREATE TABLE reference (
  id LONG,
  product_id LONG,
  barcode VARCHAR2(15),
  retail_price CHAR(14),
  cur_stock CHAR(5),
  min_stock CHAR(5) DEFAULT 5,
  max_stock CHAR(5) DEFAULT 15,
  CONSTRAINT pk_ref PRIMARY KEY(id),
  CONSTRAINT valid_cur_stock CHECK (cur_stock >= 0),
  CONSTRAINT valid_min_stock CHECK (min_stock >= 0),
  CONSTRAINT valid_max_stock CHECK (max_stock >= 0),
  CONSTRAINT valid_max_min CHECK (min_stock <= max_stock),
  CONSTRAINT fk_product FOREIGN KEY(product_id) REFERENCES TO product(id)
);

CREATE TABLE replacementOrder (
  id LONG,
  orderdate CHAR(14),
  ordertime CHAR(14),
  status CHAR(30),
  supplier_id LONG,
  reference_id LONG,
  quantity CHAR(2),
  total_payment CHAR(14), /* product of quantity and price from supplier? */
  deliveryinfo_id LONG,
  CONSTRAINT pk_reporder PRIMARY KEY(id),
  CONSTRAINT fk_supplier FOREIGN KEY(supplier_id) REFERENCES TO supplier(id),
  CONSTRAINT fk_ref FOREIGN KEY(reference_id) REFERENCES TO reference(id),
  CONSTRAINT fk_delivinfo FOREIGN KEY(deliveryinfo_id) REFERENCES TO deliveryinfo(id)
);

CREATE TABLE customerOrder (
  id LONG,
  client_id LONG,
  orderdate CHAR(14),
  ordertime CHAR(14),
  address_id LONG,
  CONSTRAINT pk_custorder PRIMARY KEY(id),
  CONSTRAINT fk_client_id FOREIGN KEY(client_id) REFERENCES TO client(id),
  CONSTRAINT fk_address_id FOREIGN KEY(address_id) REFERENCES TO address(id)
);

CREATE TABLE deliveryInfo (
  id LONG,
  dliv_date CHAR(14),
  dliv_time CHAR(14),
  CONSTRAINT pk_deliveryinfo PRIMARY KEY(id)
);

CREATE TABLE delivery (
  id LONG,
  item_id LONG,
  address_id LONG,
  deliveryinfo_id LONG,
  CONSTRAINT pk_delivery PRIMARY KEY(id)
);

CREATE TABLE supplier (
  id LONG,
  name CHAR(35) UNIQUE,
  prov_taxid CHAR(10) UNIQUE,
  prov_bankacc CHAR(30) UNIQUE,
  prov_address CHAR(120) UNIQUE,
  prov_country CHAR(45) UNIQUE,
  prov_person CHAR(45) UNIQUE,
  prov_email CHAR(60) UNIQUE,
  prov_mobile CHAR(9) UNIQUE,
  cost_price CHAR(12),
  CONSTRAINT pk_supplier PRIMARY KEY(id)
);
  
CREATE TABLE billing (
  id LONG,
  customerorder_id LONG,
  creditcard_id LONG OPTION,
  payment_type CHAR(15),
  payment_date CHAR(14),
  payment_time CHAR(14),
  CONSTRAINT pk_billing PRIMARY KEY(id),
  CONSTRAINT fk_customer_id FOREIGN KEY(customerorder_id) REFERENCES TO customerOrder(id),
  CONSTRAINT fk_creditcard_id FOREIGN KEY(creditcard_id) REFERENCES TO creditCard(id)
);

CREATE TABLE address (
  id LONG,
  waytype CHAR(10),
  wayname CHAR(30),
  gate CHAR(3) OPTION,
  block CHAR(1) OPTION,
  stairw CHAR(2) OPTION,
  floor CHAR(7) OPTION,
  door CHAR(2) OPTION,
  zip CHAR(5),
  town CHAR(45),
  country CHAR(45),
  CONSTRAINT pk_address PRIMARY KEY(id)
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
  
