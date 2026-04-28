

USE DataWarehouse
----------------- CHECKING DATA QUALITY FOR TABLE bronze.crm_cust_info ------------------------------

-- Check for NULLs or Duplicates in the Primary Key
SELECT
	cst_id,
	COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL


-- Check for unwanted Spaces
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname ! = TRIM(cst_firstname)

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname ! = TRIM(cst_lastname)

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr ! = TRIM(cst_gndr)

SELECT cst_key
FROM bronze.crm_cust_info
WHERE cst_key ! = TRIM(cst_key)


SELECT cst_material_status
FROM bronze.crm_cust_info
WHERE cst_material_status ! = TRIM(cst_material_status)




-- Check for data consistency and standardization
SELECT
	DISTINCT cst_gndr
FROM bronze.crm_cust_info

SELECT
	DISTINCT cst_material_status
FROM bronze.crm_cust_info





----------------- CHECKING DATA QUALITY FOR TABLE bronze.crm_prd_info ------------------------------


-- Check for duplicates or Null in the primary key prd_id
SELECT
	prd_key,
	COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_key
HAVING COUNT(*) > 1 AND prd_key IS NULL


-- Check for unwanted spaces
SELECT
	prd_key
FROM bronze.crm_prd_info
WHERE prd_key != TRIM(prd_key)

SELECT
	prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULLs or Negative numbers
SELECT
prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0


-- Check for Invalid Date Orders
SELECT
*
FROM bronze.crm_prd_info
WHERE prd_start_dt > prd_end_dt



----------------- CHECKING DATA QUALITY FOR TABLE bronze.crm_sales_details ------------------------------

-- Check for null or duplicates in the primary key
SELECT
count(*)
FROM bronze.crm_sales_details
GROUP BY  sls_ord_num
HAVING count(*) > 1 OR sls_ord_num IS NULL


-- Check that the links between the tables works well , (sales_details.prd_key -> prd_info.prd_key)
--                                                      (sales_details.cust_id -> cust_info.cst_id)
SELECT
*
FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN (select cst_id   from silver.crm_cust_info)
OR    sls_prd_key NOT IN (select prd_key  from silver.crm_prd_info)


-- Check the quality of the dates (sls_order_dt < sls_ship_dt < sls_due_dt AND dates are not zero AND len(date) = 8) 
-- and check for outliers (20500101 , 1900101)
SELECT
CASE 
WHEN LEN(sls_order_dt) != 8 OR sls_order_dt <= 0 THEN NULL
ELSE sls_order_dt
END AS sls_order_dt,
sls_ship_dt,
sls_due_dt

FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 OR sls_ship_dt <= 0 OR sls_due_dt = 0 OR sls_order_dt > sls_ship_dt
 OR   sls_order_dt > sls_due_dt OR LEN(sls_order_dt) != 8  OR LEN(sls_ship_dt) != 8
 OR LEN(sls_due_dt) != 8
 OR sls_order_dt > 20500101 OR sls_order_dt < 1900101



 -- sales is negative , zero , NULL 
 -- price is null and negative
 -- quantity is fine 
 -- Check validty of business logic (sale = quantity * price)
 SELECT DISTINCT
	sls_sales,

	CASE 
	WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity *  ABS(sls_price) THEN sls_quantity *  ABS(sls_price)
	ELSE  sls_sales
	END sls_sales,

	sls_quantity,

	CASE
		WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales / NULLIF(sls_quantity,0)
		ELSE  sls_price
	END sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity *  sls_price

----------------- CHECKING DATA QUALITY FOR TABLE bronze.erp_cust_az12 ------------------------------
-- Check for duplicates OR NULL values in the primary key
SELECT
CID,
COUNT(CID)
FROM bronze.erp_cust_az12
GROUP BY CID
HAVING COUNT(CID) >1 OR CID IS NULL


-- Check for missing or wrong values
SELECT DISTINCT
GEN
FROM bronze.erp_cust_az12

-- Check for invalid dates
SELECT *
FROM bronze.erp_cust_az12
WHERE BDATE > '2026-01-01' OR BDATE < '1900-01-01'
