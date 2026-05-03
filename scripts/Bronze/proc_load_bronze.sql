
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	BEGIN TRY 
		PRINT '===================================================';
		PRINT 'BUILD BRONZE LAYER';
		PRINT '===================================================';

		PRINT '-------------------------------------------------------';
		PRINT 'LOAD CRM TABLES';
		PRINT '-------------------------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Lenovo Thinkpad L13\OneDrive\Bureau\PDF IGA\DataWarehouse Project1\dataset\source_crm\cust_info.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',' ,
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -------------------------';


		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Lenovo Thinkpad L13\OneDrive\Bureau\PDF IGA\DataWarehouse Project1\dataset\source_crm\prd_info.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',' ,
				TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -------------------------';


		PRINT '-------------------------------------------------------';
		PRINT 'LOAD ERP TABLES';
		PRINT '-------------------------------------------------------';

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Lenovo Thinkpad L13\OneDrive\Bureau\PDF IGA\DataWarehouse Project1\dataset\source_erp\LOC_A101.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',' ,
				TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -------------------------';


		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Lenovo Thinkpad L13\OneDrive\Bureau\PDF IGA\DataWarehouse Project1\dataset\source_erp\CUST_AZ12.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',' ,
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -------------------------';


		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Lenovo Thinkpad L13\OneDrive\Bureau\PDF IGA\DataWarehouse Project1\dataset\source_erp\PX_CAT_G1V2.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',' ,
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -------------------------';


	END TRY 
	BEGIN CATCH
		PRINT '===================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER ';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_MESSAGE() AS NVARCHAR);
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER ';
		PRINT '===================================================';
	END CATCH

END

