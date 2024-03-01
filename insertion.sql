INSERT INTO product (product_name, coffea, varietal, origin, roasting, dcafprocess) 
SELECT PRODUCT, 
       MAX(COFFEA) AS coffea, 
       MAX(VARIETAL) AS varietal, 
       MAX(ORIGIN) AS origin, 
       MAX(ROASTING) AS roasting, 
       MAX(DECAF) AS decaf 
       FROM fsdb.catalogue 
GROUP BY product;

-- successful insertion
INSERT INTO address (WAYTYPE, WAYNAME, GATE, BLOCK, STAIRW, FLOOR, DOOR, ZIP, TOWN, COUNTRY)
SELECT BILL_WAYTYPE,
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

INSERT INTO DeliveryInfo (DLIV_DATE, DLIV_TIME)
SELECT DLIV_DATE,
       DLIV_TIME 
       FROM fsdb.trolley
       WHERE NOT (
              DLIV_DATE IS NULL OR
              DLIV_TIME IS NULL
       ); 

INSERT INTO Voucher (discount, date)
SELECT DISCOUNT FROM fsdb.trolley;



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

-- successful insertion

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

-- insertion into credit cards and deleted duplicates
