INSERT INTO PRODUCT (name, coffea, varietal, origin, roasting, dcafprocess, format, packaging)
SELECT PRODUCT, COFFEA, VARIETAL, ORIGIN, ROASTING, DECAF, FORMAT, PACKAGING from fsdb.catalogue;

INSERT INTO SUPPLIER (name, prov_taxid, prov_bankacc, prov_address, prov_country, prov_person, prov_email, prov_mobile, cost_price)
SELECT SUPPLIER, PROV_TAXID, PROV_BANKACC, PROV_ADDRESS, PROV_COUNTRY, PROV_PERSON, PROV_EMAIL, PROV_MOBILE, COST_PRICE from fsdb.catalogue;
