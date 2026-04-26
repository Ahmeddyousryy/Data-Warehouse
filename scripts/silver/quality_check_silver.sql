

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

select * from bronze.crm_sales_details
