INSERT INTO PRODUCT (name, coffea, varietal, origin, roasting, dcafprocess, format, packaging)
SELECT PRODUCT, COFFEA, VARIETAL, ORIGIN, ROASTING, DECAF, FORMAT, PACKAGING from fsdb.catalogue;
