USE BikeStores_Datamart
GO

--Select para Productos:
SELECT DISTINCT
	bpp.product_name,
	bpc.category_name,
	bpb.brand_name,
	bpp.list_price
FROM BikeStores.production.products bpp JOIN BikeStores.production.categories bpc
ON bpp.category_id = bpc.category_id JOIN BikeStores.production.brands bpb
ON bpp.brand_id = bpb.brand_id
-----------------------------------------------------------------------
--Select para Clientes:
SELECT DISTINCT
	CONCAT(first_name, ' ', last_name) as 'nombre',
	state
FROM BikeStores.sales.customers
-----------------------------------------------------------------------
--Select para Empleados:
SELECT DISTINCT
	CONCAT(first_name, ' ', last_name) as 'nombre',
	active
FROM BikeStores.sales.staffs
-----------------------------------------------------------------------
--Select para Tiendas:
SELECT DISTINCT
	store_name,
	city,
	state
FROM BikeStores.sales.stores
-----------------------------------------------------------------------
--Select para Tiempo:
SELECT DISTINCT
	CONVERT (date,order_date) as fecha_envio,
	CONVERT (int, DATEPART(year, order_date)) as anio,
	CONVERT(int, DATEPART(QUARTER,order_date)) as trimestre,
	CONVERT(varchar, DATEPART(MONTH, order_date)) as mes,
	CONVERT(int, DATEPART(DAY,order_date)) as dia
FROM BikeStores.sales.orders
-----------------------------------------------------------------------
--Select para Pedidos:
--bdp: BikeStores_Datamart_Productos
--bdc: BikeStores_Datamart_Clientes.
--bde: BikeStores_Datamart_Empleados.
--bdta: BikeStores_Datamart_Tienda.
--bdt: BikeStores_Datamart_Tiempo
--bpo: BikeStores_sales_orders.
--bss: BikeStores_sales_Staffs.
--bsst: BikeStores_sales_Stores.
SELECT DISTINCT
	bdp.id_producto,
	bdc.id_cliente,
	bde.id_empleado,
	bdta.id_tienda,
	bdt.id_tiempo,
	((bsoi.list_price * bsoi.quantity) - bsoi.discount*(bsoi.list_price * bsoi.quantity)) as precio_total
FROM BikeStores.production.products bpp JOIN BikeStores.sales.order_items bsoi
ON bpp.product_id = bsoi.product_id JOIN BikeStores.sales.orders bso
ON bsoi.order_id = bso.order_id JOIN BikeStores.sales.customers bsc
ON bso.customer_id = bsc.customer_id JOIN BikeStores.sales.staffs bss
ON bso.staff_id = bss.staff_id JOIN BikeStores.sales.stores bsst
--Se meten los campos que queremos al Datamart
ON bso.store_id = bsst.store_id JOIN BikeStores_Datamart.dbo.Productos bdp
ON bdp.nombre = bpp.product_name JOIN BikeStores_Datamart.dbo.Clientes bdc
ON bdc.nombre = CONCAT(bsc.first_name, ' ', bsc.last_name) JOIN BikeStores_Datamart.dbo.Empleados bde
ON bde.nombre = CONCAT(bss.first_name, ' ', bss.last_name) JOIN BikeStores_Datamart.dbo.Tiendas bdta
ON bdta.nombre = bsst.store_name JOIN BikeStores_Datamart.dbo.Tiempo bdt
ON bdt.fecha_envio = bso.order_date
order by id_producto
-----------------------------------------------------------------------

select * from Pedidos