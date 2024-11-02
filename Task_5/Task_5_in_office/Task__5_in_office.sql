/*
Создайте таблицу с именем «». со
столбцами OrderStatusID, OrderID (INT), Status 
(VARCHAR)
*/
USE task_2;
DROP TABLE order_status;
CREATE TABLE order_status(
order_status_id INT AUTO_INCREMENT PRIMARY KEY, 
order_id INT, 
status VARCHAR(100)
); 


/*
Вставьте образец данных в таблицу «OrderStatus». 
Поле для OrderID 101 со статусом 'Shipped'.
*/

INSERT INTO task_2.order_status
(order_id, status)
VALUES(101, 'Shipped');


/*
Обновите параметр Status' 
идентификатора заказа 101 на 'Delivered'.
*/

UPDATE order_status SET status ='Delivered'
WHERE order_id =101;

/*
Создайте представление с именем
«DeliveredOrders». которое отображает OrderID 
и OrderDate для заказов со статусом 
*/

UPDATE order_status 
SET status = 'Delivered'
WHERE order_status_id =2;

CREATE VIEW delivered_orders AS 
SELECT 
`order_id`,
orderdate,
status
FROM orders o
JOIN order_status os ON o.orderid = os.order_id
WHERE status = 'Delivered'

SELECT * FROM delivered_orders do; 

DROP VIEW delivered_orders; 

/*
 Создайте процедуру с именем
«UpdateOrderStatus». который принимает
OrderID и Status в качестве параметров
и обновляет статус в 'OrderStatus'.
 */


CALL task_2.sp_update_status(10252, 'Delivered')


/*
 Создайте таблицу с именем «EmployeeRoles». 
со столбцами EmployeeRoleID, EmployeeID 
(INT), Role (VARCHAR).
 */

USE task_2;
DROP TABLE IF EXISTS  employee_roles;
CREATE TABLE employee_roles(
employee_role_id INT PRIMARY KEY, 
employee_id INT, 
role VARCHAR(100)
); 


/*
 Вставьте образец данных в поле
'EmployeeRoles' таблица для идентификатора
сотрудника 1 с должностью 'Manager'.
 */

INSERT INTO employee_roles (employee_id, `role`)
VALUES
(1,'Manager'),
(1,'Manager'),
(1,'Manager'),
(1,'Manager'),
(1,'Manager');


INSERT INTO employee_roles
SET
	employee_id =2,
	`role` = 'Manager';


/*
 Создайте представление с именем
«EmployeeRolesView». который отображает
идентификатор сотрудника, фамилию и роль
для сотрудников с должностью.
 */

CREATE VIEW EmployeeRolesView AS
SELECT e.EmployeeID, e.LastName, er.Role
FROM Employees e
JOIN employee_roles er ON e.employeeID = er.employee_id


/*
 Создайте представление с именем
«HighValueOrdersView». который отображает
OrderID, CustomerID и OrderDate для заказов, общая
стоимость которых превышает 500 долларов США.
 */

CREATE VIEW HighValueOrdersView AS
SELECT o.OrderID, o.CustomerID, o.OrderDate
FROM Orders o
JOIN order_details od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE (od.Quantity * p.Price) > 500




