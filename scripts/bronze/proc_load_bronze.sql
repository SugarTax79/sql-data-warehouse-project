/*
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  - Truncates the bronze tables before loading data.
  - Uses the 'Bulk Insert' command to load data from CSV files to bronze tables.

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage example:
  EXEC bronze.load_bronze;
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze as 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_loading DATETIME, @end_time_loading DATETIME;
	BEGIN TRY
		SET @start_time_loading = GETDATE();
		PRINT '======================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================';

		PRINT '----------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------';

		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: bronze.crm_cust_info';
			TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'>>Loading Table: bronze.crm_cust_info';
		BULK INSERT [DataWarehouse].[bronze].[crm_cust_info]
		FROM 'C:\Users\Leo.Lee\OneDrive - Sumitomo Heavy Industries, Ltd\Documents\Projects\03_Study\SQL Study\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + ' seconds';

		PRINT''
		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>>Loading Table: bronze.crm_prd_info';
		BULK INSERT [DataWarehouse].[bronze].[crm_prd_info]
		FROM 'C:\Users\Leo.Lee\OneDrive - Sumitomo Heavy Industries, Ltd\Documents\Projects\03_Study\SQL Study\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + ' seconds';

		PRINT''
		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT'>>Loading Table: bronze.crm_sales_details';
		BULK INSERT [DataWarehouse].[bronze].[crm_sales_details]
		FROM 'C:\Users\Leo.Lee\OneDrive - Sumitomo Heavy Industries, Ltd\Documents\Projects\03_Study\SQL Study\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + ' seconds';

		PRINT''
		PRINT '----------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------';

		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>>Loading Table: bronze.erp_cust_az12';
		BULK INSERT [DataWarehouse].[bronze].[erp_cust_az12]
		FROM 'C:\Users\Leo.Lee\OneDrive - Sumitomo Heavy Industries, Ltd\Documents\Projects\03_Study\SQL Study\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + ' seconds';

		PRINT''
		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT'>>Loading Table: bronze.erp_loc_a101';
		BULK INSERT [DataWarehouse].[bronze].[erp_loc_a101]
		FROM 'C:\Users\Leo.Lee\OneDrive - Sumitomo Heavy Industries, Ltd\Documents\Projects\03_Study\SQL Study\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + ' seconds';

		PRINT''
		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT'>>Loading Table: erp_px_cat_g1v2';
		BULK INSERT [DataWarehouse].[bronze].[erp_px_cat_g1v2]
		FROM 'C:\Users\Leo.Lee\OneDrive - Sumitomo Heavy Industries, Ltd\Documents\Projects\03_Study\SQL Study\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR) + ' seconds';
	END TRY

	BEGIN CATCH
		PRINT '========================================================';
		PRINT 'Error occured during loading bronze layer'
		PRINT 'Error message' + ERROR_MESSAGE();
		PRINT 'Error message' + CAST (ERROR_NUMBER() as NVARCHAR);
		PRINT 'Error message' + CAST (ERROR_STATE() as NVARCHAR);
		PRINT '========================================================';
	END CATCH
	SET @end_time_loading = GETDATE();
	PRINT '>> Bronze Layer Loading Duration: ' + CAST(DATEDIFF(second, @start_time_loading, @end_time_loading) as NVARCHAR) + ' seconds';

END
