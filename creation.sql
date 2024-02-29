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

-- add this foreign key constraint using ALTER TABLE

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
  cost_price CHAR(12)
  CONSTRAINT fk_supplier
);

  -- CONSTRAINT pk_supplier PRIMARY KEY(supplier_name)

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
  client_email CHAR(60),
  client_mobile CHAR(9),
  CONSTRAINT pk_client PRIMARY KEY(id)
);


CREATE TABLE address (
  waytype CHAR(10),
  wayname CHAR(30),
  gate CHAR(3) NULL,
  block CHAR(1) NULL,
  stairw CHAR(2) NULL,
  floor CHAR(7) NULL,
  door CHAR(2) NULL,
  zip CHAR(5),
  town CHAR(45),
  country CHAR(45)
);

CREATE TABLE customerOrder (
  client_id NUMBER,
  orderdate CHAR(14),
  ordertime CHAR(14),
  address_id NUMBER,
  CONSTRAINT pk_custorder PRIMARY KEY(id),
  CONSTRAINT fk_client_id FOREIGN KEY(client_id) REFERENCES client(id),
  CONSTRAINT fk_address_id FOREIGN KEY(address_id) REFERENCES address(id)
 );

CREATE TABLE delivery (
  item_id NUMBER,
  address_id NUMBER,
  deliveryinfo_id NUMBER,
  CONSTRAINT pk_delivery PRIMARY KEY(id)
);


CREATE TABLE creditCard (
  card_company CHAR(15),
  card_number CHAR(20),
  card_holder CHAR(30),
  card_expiration CHAR(7),
  CONSTRAINT pk_creditcard PRIMARY KEY(card_number)
);


CREATE TABLE billing (
  customerorder_id NUMBER,
  creditcard_id NUMBER,
  payment_type CHAR(15),
  payment_date CHAR(14),
  payment_time CHAR(14),
  CONSTRAINT pk_billing PRIMARY KEY(id),
  CONSTRAINT fk_customer_id FOREIGN KEY(customerorder_id) REFERENCES customerOrder(id),
  CONSTRAINT fk_creditcard_id FOREIGN KEY(creditcard_id) REFERENCES creditCard(id)
);

CREATE TABLE registeredClient (
  client_id NUMBER,
  address_id NUMBER,
  creditcard_id NUMBER,
  username CHAR(30),
  reg_date CHAR(14),
  reg_time CHAR(14),
  user_passw CHAR(15),
  client_name CHAR(35),
  client_surn1 CHAR(30),
  client_surn2 CHAR(30),
  contact_preference CHAR(30),
  voucher_id NUMBER,
  CONSTRAINT pk_regclient PRIMARY KEY(id)
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

CREATE TABLE voucher (
  discount CHAR(3),
  voucher_date CHAR(14),
  CONSTRAINT pk_voucher PRIMARY KEY(id)
);

CREATE TABLE item (
  customerorder_id NUMBER,
  reference_id NUMBER,
  quantity NUMBER,
  base_price NUMBER,
  total_price GENERATED ALWAYS AS (quantity * base_price) VIRTUAL,
  CONSTRAINT pk_item PRIMARY KEY(id),
  CONSTRAINT fk_reference_id FOREIGN KEY(reference_id) REFERENCES reference(id)
);
