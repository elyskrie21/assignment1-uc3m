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

INSERT INTO SUPPLIER (supplier_name, prov_taxid, prov_bankacc, prov_address, prov_country, prov_person, prov_email, prov_mobile, cost_price)
SELECT SUPPLIER, PROV_TAXID, PROV_BANKACC, PROV_ADDRESS, PROV_COUNTRY, PROV_PERSON, PROV_EMAIL, PROV_MOBILE, COST_PRICE from fsdb.catalogue;

INSERT INTO creditCard (card_company, card_number, card_holder, card_expiration) SELECT CARD_COMPANY, CARD_NUMBER, CARD_HOLDER, CARD_EXPIRATN from fsdb.trolley;
