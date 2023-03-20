

Select
	ord.order_id,
	Concat(cus.First_name, ' ' , cus.last_name) as Customers,
	cus.City,
	cus.state,
	ord.order_date,
	Sum(ite.quantity) as total_units,
	Sum(ite.list_price * ite.quantity) as renevue,
	pro.product_name,
	cat.Category_name,
	sto.store_name,
	CONCAT ( sta.first_name, ' ', sta.last_name) as sales_rep
	From sales.orders ord
	Join sales.customers cus
	On ord.customer_id = cus.customer_id
	Join Sales.order_items ite
	on ite.order_id=ord.order_id
	Join production.products pro
	on ite.product_id = pro.product_id
	Join production.categories cat
	on pro.category_id=cat.category_id
	Join sales.stores sto 
	on Ord.store_id = sto.store_id
	Join sales.staffs sta
	on ord.staff_id = sta.staff_id
	Group by
	ord.order_id,
	Concat(cus.First_name, ' ' , cus.last_name),
cus.city,
cus.state,
ord.order_date,
pro.product_name,
cat.Category_name,
sto.store_name,		
CONCAT ( sta.first_name, ' ', sta.last_name)




