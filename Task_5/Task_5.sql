/*
Задания:
1. Создайте хранимую процедуру с именем «GetEmployeeOrders». 
который принимает идентификатор сотрудника в качестве
параметра и возвращает все заказы, обработанные этим
сотрудником.
Пропишите запрос, который создаст требуемую процедуру.
2. Создайте таблицу EmployeeRoles, как на уроке и удалите ее.
Напишите запрос, который удалит нужную таблицу.
3. Удалите все заказы со статусом 'Delivered' из таблицы OrderStatus, 
которую создавали на семинаре
Напишите запрос, который удалит нужные строки в таблице.
*/


/*
Задание 1:
Создайте хранимую процедуру с именем «GetEmployeeOrders». 
который принимает идентификатор сотрудника в качестве
параметра и возвращает все заказы, обработанные этим
сотрудником.
Пропишите запрос, который создаст требуемую процедуру.
*/

DELIMITER $$
	
CREATE PROCEDURE IF NOT EXISTS GetEmployeeOrders (_employee_id INT)
BEGIN
	SELECT 
		e.employeeid,
		concat(e.LastName,' ',e.FirstName) AS Emloyee,
		o.OrderID 
	FROM employees e
	JOIN orders o ON o.EmployeeID = e.EmployeeID
	WHERE o.EmployeeID = _employee_id
	ORDER BY o.OrderID; 
END;
$$
DELIMITER ;

CALL task_2.GetEmployeeOrders(2)

/*
Ответ:
employeeid|Emloyee      |OrderID|
----------+-------------+-------+
         2|Fuller Andrew|  10265|
         2|Fuller Andrew|  10277|
         2|Fuller Andrew|  10280|
         2|Fuller Andrew|  10295|
         2|Fuller Andrew|  10300|
         2|Fuller Andrew|  10307|
         2|Fuller Andrew|  10312|
         2|Fuller Andrew|  10313|
         2|Fuller Andrew|  10327|
         2|Fuller Andrew|  10339|
         2|Fuller Andrew|  10345|
         2|Fuller Andrew|  10368|
         2|Fuller Andrew|  10379|
         2|Fuller Andrew|  10388|
         2|Fuller Andrew|  10392|
         2|Fuller Andrew|  10398|
         2|Fuller Andrew|  10404|
         2|Fuller Andrew|  10407|
         2|Fuller Andrew|  10414|
         2|Fuller Andrew|  10422|
 */

/*
Задание 2:
Создайте таблицу EmployeeRoles с колонками EmployeeRoleID (INT), EmployeeID 
(INT), Role (VARCHAR), как на уроке и удалите ее.
Напишите запрос, который удалит нужную таблицу.
*/

USE task_2;

CREATE TABLE  IF NOT EXISTS  EmployeeRoles(
EmployeeRoleID INT PRIMARY KEY, 
EmployeeID INT, 
Role VARCHAR(100)
); 

DROP TABLE IF EXISTS  EmployeeRoles;

/*
Задание 3:
 Удалите все заказы со статусом 'Delivered' из таблицы OrderStatus, 
которую создавали на семинаре
Напишите запрос, который удалит нужные строки в таблице.
 */

SELECT * FROM orderstatus o 

/*
order_status_id|order_id|status   |
---------------+--------+---------+
              1|   10250|Delivered|
              2|   10251|Shipped  |
              3|   10252|Delivered|
 */

DELETE FROM OrderStatus  WHERE status = 'Delivered'


SELECT * FROM orderstatus o 

/*
Ответ:

order_status_id|order_id|status |
---------------+--------+-------+
              2|   10251|Shipped|
 */
