/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER   PROCEDURE [bronze].[load_bronze] AS AS
BEGIN
DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME
	BEGIN TRY
	SET @batch_start_time = GETDATE();
	PRINT'===========================================';
	PRINT 'LOADING BRONZE LAYER';
	PRINT'===========================================';
	SET @start_time=GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'A:\sql fiel\sql-data-warehouse-project-main\datasets\source_crm\cust_info.CSV'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT('>>load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds');
	--==================================================================================--
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'A:\sql fiel\sql-data-warehouse-project-main\datasets\source_crm\prd_info.CSV'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
			PRINT('>>load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds');
	--========================================================================================--
		SET @start_time=GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'A:\sql fiel\sql-data-warehouse-project-main\datasets\source_crm\sales_details.CSV'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT('>>load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds');
		--================================================================================================--
		SET @start_time=GETDATE();
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'A:\sql fiel\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.CSV'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	SET @end_time=GETDATE();
			PRINT('>>load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds');
		--===============================================================================================--
		SET @start_time=GETDATE();
		TRUNCATE TABLE bronze.erp_LOC_A101;
		BULK INSERT bronze.erp_LOC_A101
		FROM 'A:\sql fiel\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.CSV'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
			PRINT('>>load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds');
		--=============================================================================================--
		SET @start_time=GETDATE();
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'A:\sql fiel\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.CSV'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
			PRINT('>>load Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds');
		--=======================================================================================================--
	SET @batch_end_time = GETDATE();
	PRINT'==========================================';
	PRINT 'LOADING BRONZE LAYER IS COMPLETED';
	PRINT 'TOTAL LOAD DURATION : '+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR);
	PRINT'==========================================';

	END TRY
	BEGIN CATCH
	PRINT'==============================================';
	PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER';
	PRINT 'ERROR MESSAGE'+ ERROR_MESSAGE();
	PRINT'ERROR LINE' + CAST(ERROR_LINE() AS NVARCHAR);
	PRINT'ERROR STATE' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT'==============================================';

	END CATCH
END
