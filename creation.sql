CREATE TABLE product (
  product_name CHAR(50),
  coffea CHAR(20),
  varietal CHAR(30),
  origin CHAR(15),
  roasting CHAR(10),
  decaf CHAR(12),
  CONSTRAINT pk_product PRIMARY KEY(product_name)
 );

CREATE TABLE reference (
  product CHAR(50),
  barcode CHAR(15),
  format CHAR(20),
  packaging CHAR(15),
  retail_price CHAR(14),
  cur_stock NUMBER,
  min_stock NUMBER DEFAULT 5,
  max_stock NUMBER DEFAULT 15,
  CONSTRAINT pk_ref PRIMARY KEY(barcode, packaging, format, retail_price),
  CONSTRAINT valid_cur_stock CHECK (cur_stock >= 0),
  CONSTRAINT valid_min_stock CHECK (min_stock >= 0),
  CONSTRAINT valid_max_stock CHECK (max_stock >= 0),
  CONSTRAINT valid_max_min CHECK (min_stock <= max_stock),
  CONSTRAINT fk_ref FOREIGN KEY(product) REFERENCES product(product_name)
);

CREATE TABLE supplier (
  name CHAR(35),
  prov_taxid CHAR(10) NULL,
  prov_bankacc CHAR(30) NULL,
  prov_address CHAR(120) NULL,
  prov_country CHAR(45) NULL,
  prov_person CHAR(90) NULL,
  prov_email CHAR(60) NULL,
  prov_mobile CHAR(9) NULL,
  cost_price CHAR(12) NULL
  CONSTRAINT pk_supp PRIMARY KEY(name)
);

CREATE TABLE replacementOrder (
  orderdate CHAR(14),
  ordertime CHAR(14),
  status CHAR(20),
  supplier CHAR(35),
  reference CHAR(15),
  total_payment CHAR(15),
  quantity CHAR(2),
  deliveryinfo CHAR(14)
);

ALTER TABLE replacementOrder ADD CONSTRAINT pk_repl PRIMARY KEY(orderdate, ordertime);
ALTER TABLE replacementOrder ADD CONSTRAINT fk_supp FOREIGN KEY(supplier) REFERENCES supplier(name);
ALTER TABLE replacementOrder ADD CONSTRAINT fk_deliv FOREIGN KEY(deliveryinfo) REFERENCES deliveryInfo(DLIV_DATE);

-- ADD   status CHAR(30), column
-- ADD   total_payment CHAR(14),

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
  quantity CHAR(2),
  CONSTRAINT fk_productinfo FOREIGN KEY(product, barcode, prodtype, packaging),
  CONSTRAINT pk_order PRIMARY KEY (orderdate, ordertime),
  REFERENCES orderedProdInfo(product, barcode, prodtype, packaging)
 );

CREATE TABLE address (
  id NUMBER,
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
  CONSTRAINT pk_address PRIMARY KEY(id)
);

CREATE TABLE deliveryInfo (
  id NUMBER,
  delivery_date DATE,
  delivery_time DATE,
  CONSTRAINT pk_deliveryinfo PRIMARY KEY(id)
);

CREATE TABLE delivery (
  id NUMBER,
  item_id NUMBER,
  address_id NUMBER,
  deliveryinfo_id NUMBER,
  CONSTRAINT pk_delivery PRIMARY KEY(id),
  CONSTRAINT fk_item FOREIGN KEY(item_id) REFERENCES item(id),
  CONSTRAINT fk_address FOREIGN KEY(address_id) REFERENCES address(id),
  CONSTRAINT fk_delivery FOREIGN KEY(deliveryinfo_id) REFERENCES deliveryInfo(id)
 );

CREATE TABLE billing (
  id NUMBER,
  payment_type CHAR(15),
  payment_date DATE,
  payment_time DATE,
  customer_order NUMBER,
  credit_card NUMBER,
  address NUMBER,
  CONSTRAINT pk_billing PRIMARY KEY(id),
  CONSTRAINT fk_cust FOREIGN KEY(customer_order) REFERENCES customerOrder(id),
  CONSTRAINT fk_card FOREIGN KEY(credit_card) REFERENCES creditCard(card_number),
  CONSTRAINT fk_add FOREIGN KEY(address) REFERENCES address(id)
);

CREATE TABLE creditCard (
  card_number NUMBER,
  card_company CHAR(15),
  card_holder CHAR(30),
  card_expiration CHAR(7),
  CONSTRAINT pk_credit PRIMARY KEY(card_number)
);

CREATE TABLE item (
  id NUMBER,
  customerOrder NUMBER,
  reference NUMBER,
  quantity NUMBER,
  base_price NUMBER,
  total_price NUMBER,
  CONSTRAINT pk_item PRIMARY KEY(id),
  CONSTRAINT fk_cust FOREIGN KEY(customerOrder) REFERENCES customerOrder(id),
  CONSTRAINT fk_barcode FOREIGN KEY(reference) REFERENCES reference(barcode)
);

CREATE TABLE client (
  client_email CHAR(60),
  client_mobile CHAR(9)
);

CREATE TABLE registeredClient (
  client_email CHAR(60),
  client_mobile CHAR(9),
  username CHAR(30),
  reg_date DATE,
  reg_time DATE,
  user_passw CHAR(15),
  client_name CHAR(35),
  client_surn1 CHAR(30),
  client_surn2 CHAR(30),
  client_email CHAR(60),
  contact_preference CHAR(30) DEFAULT 'SMS',
  voucher_id NUMBER,
  CONSTRAINT fk_reg FOREIGN KEY(client_email, client_mobile) REFERENCES client(client_email, client_mobile)
);

CREATE TABLE registeredClientAddress (
  id NUMBER,
  registeredClient NUMBER
  address NUMBER,
  CONSTRAINT pk_regisAdd PRIMARY KEY(id),
  CONSTRAINT fk_reg FOREIGN KEY(registeredClient) REFERENCES registeredClient(id),
  CONSTRAINT fk_address FOREIGN KEY(address) REFERENCES address(id)
);

CREATE TABLE voucher (
  voucher_id NUMBER,
  discount NUMBER,
  date DATE
  CONSTRAINT pk_voucher PRIMARY KEY(id)
);

CREATE TABLE comments (
  id NUMBER PRIMARY KEY,
  RegisteredClientID NUMBER,
  post_date CHAR(100),
  post_time CHAR(100),
  title CHAR(100),
  text CHAR(100),
  score CHAR(100),
  likes CHAR(100) DEFAULT '0',
  endorsed CHAR(12) 
);
