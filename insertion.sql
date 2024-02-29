INSERT INTO product (product_name, coffea, varietal, origin, roasting, dcafprocess, format, packaging)
SELECT PRODUCT, 
       MAX(COFFEA) AS coffea, 
       MAX(VARIETAL) AS varietal, 
       MAX(ORIGIN) AS origin, 
       MAX(ROASTING) AS roasting, 
       MAX(DECAF) AS dcafprocess, 
       FORMAT, 
       PACKAGING 
FROM fsdb.catalogue 
GROUP BY product, format, packaging;

-- successful insertion

INSERT INTO REFERENCE (barcode, product_name, format, packaging, retail_price, cur_stock, min_stock, max_stock) 
SELECT 
  BARCODE, 
  PRODUCT,
  FORMAT,
  PACKAGING, 
  RETAIL_PRICE,
  MAX(to_number(CUR_STOCK)), 
  MAX(to_number(MIN_STOCK)), 
  MAX(to_number(MAX_STOCK))
FROM fsdb.catalogue 
GROUP BY BARCODE, PRODUCT, FORMAT, PACKAGING, RETAIL_PRICE;

-- successful insertion

INSERT INTO SUPPLIER (supplier_name, product_name, format, packaging, prov_taxid, prov_bankacc, prov_address, prov_country, prov_person, prov_email, prov_mobile, cost_price)
SELECT SUPPLIER,
       PRODUCT,
       FORMAT,
       PACKAGING,
       max(PROV_TAXID), 
       max(PROV_BANKACC), 
       max(PROV_ADDRESS), 
       max(PROV_COUNTRY), 
       max(PROV_PERSON), 
       max(PROV_EMAIL), 
       max(PROV_MOBILE), 
       COST_PRICE 
from fsdb.catalogue
GROUP BY SUPPLIER, PRODUCT, FORMAT, PACKAGING, COST_PRICE;

-- SQL no terminado corectamente

INSERT INTO client (client_email, client_mobile, client_name, client_surn1, client_surn2, card_number)
SELECT CLIENT_EMAIL, COALESCE(CLIENT_MOBILE, 'N/A'), max(CLIENT_NAME), max(CLIENT_SURN1), max(CLIENT_SURN2), max(CARD_NUMBER) FROM fsdb.trolley
GROUP BY client_email, client_mobile;

-- SQL no terminado corectamente

INSERT INTO address (waytype, wayname, gate, block, stairw, floor, door, zip, town, country)
       SELECT DLIV_WAYTYPE,
DLIV_WAYNAME,
DLIV_GATE,
DLIV_BLOCK,
DLIV_STAIRW,
DLIV_FLOOR,
DLIV_DOOR,
DLIV_ZIP,
DLIV_TOWN,
DLIV_COUNTRY
       from fsdb.trolley;

-- successful, 58743 rows

INSERT INTO address (waytype, wayname, gate, block, stairw, floor, door, zip, town, country, client_email, client_mobile)
       SELECT BILL_WAYTYPE,
BILL_WAYNAME,
BILL_GATE,
BILL_BLOCK,
BILL_STAIRW,
BILL_FLOOR,
BILL_DOOR,
BILL_ZIP,
BILL_TOWN,
BILL_COUNTRY,
       CLIENT_EMAIL,
       CLIENT_MOBILE
       from fsdb.trolley;

-- successful, 58743 rows
-- maybe need to delete duplicate rows from address?


INSERT INTO creditCard (card_company, card_number, card_holder, card_expiration) SELECT CARD_COMPANY, CARD_NUMBER, CARD_HOLDER, CARD_EXPIRATN from fsdb.trolley;
