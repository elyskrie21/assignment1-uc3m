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
  dliv_time CHAR(14)
);

CREATE TABLE delivery (
  id LONG,
  item_id LONG,
  address_id LONG,
  deliveryinfo_id LONG
);


