/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/
-- Check For nulls or Duplicates in Primary Key 
-- Expectation: No Result

SELECT 
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL


-- data transformation and Data Cleansing

SELECT
*
FROM(
SELECT 
*,
--ROW_NUMBER() : assigns a unique number to each row in a result set, based on a defined order
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
--where cst_id = 29466
)t WHERE flag_last != 1

-- Check for unwanted Spaces 
--TRIM() : removes the leading and traling spaces from a string  
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Data Standarisation And Consistency 

SELECT DISTINCT cst_gndr
From silver.crm_cust_info

SELECT * FROM silver.crm_cust_info

--***************************************************************************

-- Check For nulls or Duplicates in Primary Key (for prd_info)
-- Expectation: No Result

SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted Spaces 
--TRIM() : removes the leading and traling spaces from a string  

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check For nulls or mines cost in prd_cost

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 or prd_cost IS NULL 

-- Data Standarisation And Consistency 

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

SELECT * FROM silver.crm_prd_info

-- Check for invalid date orders:

SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

/*
	+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	 Table erp_...
	+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

--Identity out_of_range Dates	
SELECT DISTINCT bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR  bdate > GETDATE()

SELECT DISTINCT gen
FROM bronze.erp_cust_az12

SELECT * 
FROM silver.erp_cust_az12

-- Data Standarisation And Consistency 

SELECT DISTINCT CNTRY
FROM bronze.erp_loc_a101

-- Check for unwanted Spaces

SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat)

-- Data Standarisation And Consistency 
SELECT DISTINCT cat
FROM bronze.erp_px_cat_g1v2

SELECT * FROM bronze.erp_px_cat_g1v2
