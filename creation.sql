CREATE TABLE product (
  product_name CHAR(50),
  coffea CHAR(20),
  varietal CHAR(30),
  origin CHAR(15),
  roasting CHAR(10),
  dcafprocess CHAR(12),
  format CHAR(20),
  packaging CHAR(15),
  CONSTRAINT pk_product PRIMARY KEY(product_name, packaging, format)
 );

-- successful creation

CREATE TABLE reference (
  barcode CHAR(15),
  product_name CHAR(50),
  format CHAR(20),
  packaging CHAR(15),
  retail_price CHAR(14),
  cur_stock NUMBER,
  min_stock NUMBER DEFAULT 5,
  max_stock NUMBER DEFAULT 15,
  CONSTRAINT pk_ref PRIMARY KEY(barcode, packaging, retail_price),
  CONSTRAINT valid_cur_stock CHECK (cur_stock >= 0),
  CONSTRAINT valid_min_stock CHECK (min_stock >= 0),
  CONSTRAINT valid_max_stock CHECK (max_stock >= 0),
  CONSTRAINT valid_max_min CHECK (min_stock <= max_stock),
  CONSTRAINT fk_ref FOREIGN KEY(product_name, format, packaging) REFERENCES product(product_name, format, packaging)
);

-- successful creation

CREATE TABLE supplier (
  supplier_name CHAR(35),
  product_name CHAR(50),
  format CHAR(20),
  packaging CHAR(15),
  prov_taxid CHAR(10),
  prov_bankacc CHAR(30),
  prov_address CHAR(120),
  prov_country CHAR(45),
  prov_person CHAR(90),
  prov_email CHAR(60),
  prov_mobile CHAR(9),
  cost_price CHAR(12),
  CONSTRAINT fk_supplier FOREIGN KEY(product_name, format, packaging) REFERENCES product(product_name, format, packaging)
);

  -- successful creation

CREATE TABLE deliveryInfo (
  dliv_date CHAR(14),
  dliv_time CHAR(14),
  CONSTRAINT pk_deliveryinfo PRIMARY KEY(id)
 );

CREATE TABLE replacementOrder (
  orderdate CHAR(14),
  ordertime CHAR(14),
  status CHAR(30),
  supplier_id NUMBER,
  reference_id NUMBER,
  quantity CHAR(2),
  total_payment CHAR(14),
  deliveryinfo_id NUMBER,
  CONSTRAINT pk_reporder PRIMARY KEY(id),
  CONSTRAINT fk_supplier FOREIGN KEY(supplier_id) REFERENCES supplier(id),
  CONSTRAINT fk_ref FOREIGN KEY(reference_id) REFERENCES reference(id),
  CONSTRAINT fk_delivinfo FOREIGN KEY(deliveryinfo_id) REFERENCES deliveryinfo(id)
);


CREATE TABLE client (
  client_email CHAR(60) NULL,
  client_mobile CHAR(9) NULL,
  client_name CHAR(35) NULL,
  client_surn1 CHAR(30) NULL,
  client_surn2 CHAR(30) NULL,
  card_number CHAR(20) NULL,
  CONSTRAINT pk_client PRIMARY KEY(client_email, client_mobile),
  CONSTRAINT fk_client FOREIGN KEY(card_number) REFERENCES creditCard(card_number)
);

-- successful creation

CREATE TABLE registeredClient (
  client_email CHAR(60),
  client_mobile CHAR(9),
  username CHAR(30),
  reg_date CHAR(14),
  reg_time CHAR(14),
  user_passw CHAR(15),
  contact_preference CHAR(30)
  CONSTRAINT pk_regclient PRIMARY KEY(client_email, client_mobile)
);


CREATE TABLE address (
  waytype CHAR(10) NOT NULL,
  wayname CHAR(30) NOT NULL,
  gate CHAR(3) NULL,
  block CHAR(1) NULL,
  stairw CHAR(2) NULL,
  floor CHAR(7) NULL,
  door CHAR(2) NULL,
  zip CHAR(5) NOT NULL,
  town CHAR(45) NOT NULL,
  country CHAR(45) NOT NULL,
  client_email CHAR(60) NULL,
  client_mobile CHAR(9) NULL
);

-- successful creation

CREATE TABLE customerOrder (
  client_email CHAR(60),
  client_mobile CHAR(9),
  orderdate CHAR(14),
  ordertime CHAR(14),
  product CHAR(50),
  barcode CHAR(15),
  prodtype CHAR(20),
  packaging CHAR(15),
  town CHAR(45),
  quantity CHAR(2)
  CONSTRAINT fk_productinfo FOREIGN KEY(product, barcode, prodtype, packaging) 
  REFERENCES orderedProdInfo(product, barcode, prodtype, packaging)
 );

CREATE TABLE orderedProdInfo (
  product CHAR(50),
  barcode CHAR(15),
  prodtype CHAR(20),
  packaging CHAR(15),
  coffea CHAR(20),
  varietal CHAR(30),
  origin CHAR(15),
  roasting CHAR(10),
  dcafprocess CHAR(12),
  base_price CHAR(10)
  CONSTRAINT pk_ordered PRIMARY KEY(product, barcode, prodtype, packaging)
);

-- CREATE TABLE delivery (
--   item_id NUMBER,
--   address_id NUMBER,
--   deliveryinfo_id NUMBER,
--   CONSTRAINT pk_delivery PRIMARY KEY(id)
-- );


CREATE TABLE creditCard (
  card_company CHAR(15),
  card_number CHAR(20),
  card_holder CHAR(30),
  card_expiration CHAR(7),
  CONSTRAINT pk_creditcard PRIMARY KEY(card_number)
);

-- successful creation

CREATE TABLE billing (
  payment_type CHAR(15),
  payment_date CHAR(14), -- payment_date and payment_time correspond with order_date and order_time
  payment_time CHAR(14),
  client_email CHAR(60),
  client_mobile CHAR(9),
  town CHAR(45),
  card_number CHAR(20),
  CONSTRAINT pk_billing PRIMARY KEY(payment_date, payment_time),
  CONSTRAINT fk_client FOREIGN KEY(payment_date, payment_time) REFERENCES customerOrder(orderdate, ordertime),
);


CREATE TABLE comments (
  RegisteredClientID NUMBER,
  post_date CHAR(100),
  post_time CHAR(100),
  title CHAR(100),
  text CHAR(100),
  score CHAR(100),
  likes CHAR(100) DEFAULT '0',
  endorsed CHAR(12),
  CONSTRAINT pk_comment PRIMARY KEY(id),
  FOREIGN KEY (RegisteredClientID) REFERENCES RegisteredClient(ID)
);

-- CREATE TABLE voucher (
--   discount CHAR(3),
--   voucher_date CHAR(14),
--   CONSTRAINT pk_voucher PRIMARY KEY(id)
-- );

CREATE TABLE item (
  customerorder_id NUMBER,
  reference_id NUMBER,
  quantity NUMBER,
  base_price NUMBER,
  total_price GENERATED ALWAYS AS (quantity * base_price) VIRTUAL,
  CONSTRAINT pk_item PRIMARY KEY(id),
  CONSTRAINT fk_reference_id FOREIGN KEY(reference_id) REFERENCES reference(id)
);
