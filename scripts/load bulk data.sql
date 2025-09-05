CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

DECLARE @start_time datetime, @end_time datetime;

BEGIN TRY
	print '=====================================';
	PRINT 'Loading bronze layer';
	print '=====================================';
	Print 'Loading CRM Tables';

	SET @start_time = GETDATE();

	Truncate Table bronze.crm_cust_info;
	BULK Insert bronze.crm_cust_info
	from 'B:\s_shubham\SQLWarehouseproject\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with (
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	SET @end_time = GETDATE();
	print 'Load Duration: ' + cast(DATEDIFF(second,@start_time,@end_time) as nvarchar) + ' seconds';
	Truncate Table bronze.crm_prd_info;
	BULK Insert bronze.crm_prd_info
	from 'B:\s_shubham\SQLWarehouseproject\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with (
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Truncate Table bronze.crm_sales_details;
	BULK Insert bronze.crm_sales_details
	from 'B:\s_shubham\SQLWarehouseproject\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with (
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	Print '-------------------------------------';
	Print 'Loading CRM Tables';

	Truncate Table bronze.erp_cust_az12;
	BULK Insert bronze.erp_cust_az12
	from 'B:\s_shubham\SQLWarehouseproject\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with (
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Truncate Table bronze.erp_loc_a101;
	BULK Insert bronze.erp_loc_a101
	from 'B:\s_shubham\SQLWarehouseproject\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with (
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);

	Truncate Table bronze.erp_px_cat_g1v2;
	BULK Insert bronze.erp_px_cat_g1v2
	from 'B:\s_shubham\SQLWarehouseproject\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with (
		Firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	Print 'Load Complete';
	END TRY
	BEGIN CATCH
		PRINT '==========================';
		PRINT 'ERROR Occured during tloading Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE(); 
		PRINT 'Error Number' + CAST (ERROR_NUMBER() AS Nvarchar);
		PRINT 'Error State' + CAST (ERROR_STATE() AS Nvarchar);
		PRINT '==========================';

	END CATCH
END