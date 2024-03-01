/* format can be extended to other tables */

INSERT INTO product (product_name, coffea, varietal, origin, roasting, dcafprocess) 
SELECT PRODUCT, 
       MAX(COFFEA) AS coffea, 
       MAX(VARIETAL) AS varietal, 
       MAX(ORIGIN) AS origin, 
       MAX(ROASTING) AS roasting, 
       MAX(DECAF) AS decaf 
       FROM fsdb.catalogue 
GROUP BY product;

INSERT INTO REFERENCE (product, barcode, format, packaging, retail_price, cur_stock, min_stock, max_stock) 
SELECT 
  PRODUCT, 
  DISTINCT BARCODE,
  FORMAT,
  PACKAGING, 
  RETAIL_PRICE,
  to_number(CUR_STOCK), 
  to_number(MIN_STOCK), 
  to_number(MAX_STOCK)
       FROM fsdb.catalogue 
       WHERE NOT (
       BARCODE IS NULL OR
       FORMAT IS NULL OR
       PACKAGING IS NULL OR
       RETAIL_PRICE IS NULL);

INSERT INTO SUPPLIER (name, prov_taxid, prov_bankacc, prov_address, prov_country, prov_person, prov_email, prov_mobile, cost_price)
SELECT DISTINCT SUPPLIER,
       PROV_TAXID, 
       PROV_BANKACC, 
       PROV_ADDRESS, 
       PROV_COUNTRY, 
       PROV_PERSON, 
       PROV_EMAIL, 
       PROV_MOBILE, 
       COST_PRICE 
       from fsdb.catalogue 
       WHERE SUPPLIER IS NOT NULL;

INSERT INTO customerOrder (id, client_email, client_mobile, orderdate, ordertime, product, barcode, prodtype, packaging, town, quantity)
       SELECT row_number(),
       CLIENT_EMAIL,
       CLIENT_MOBILE,
       ORDERDATE,
       ORDERTIME,
       PRODUCT,
       BARCODE,
       PRODTYPE,
       PACKAGING,
       TOWN,
       QUANTITY,
       from fsdb.trolley,
       WHERE ORDERDATE IS NOT NULL and ORDERTIME IS NOT NULL;

INSERT INTO billing (id, payment_type, payment_date, payment_time, customer_order, credit_card, address)
       SELECT row_number(),
       PAYMENT_TYPE,
       PAYMENT_DATE from fsdb.trolley
       customerOrder.id
       CARD_NUMBER from fsdb.trolley,
       address.id;

INSERT INTO address (id, WAYTYPE, WAYNAME, GATE, BLOCK, STAIRW, FLOOR, DOOR, ZIP, TOWN, COUNTRY)
SELECT row_number(),
       BILL_WAYTYPE,
       BILL_WAYNAME,
       BILL_GATE,
       BILL_BLOCK,
       BILL_STAIRW, 
       BILL_FLOOR,
       BILL_DOOR,
       BILL_ZIP,
       BILL_TOWN,
       BILL_COUNTRY
       FROM fsdb.trolley;
