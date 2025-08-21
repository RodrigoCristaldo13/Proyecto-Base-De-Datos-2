use FoodInspections
go

/*
	6) Escribir una vista que muestre todos los datos de las licencias vigentes 
	y los días que faltan para el vencimiento de cada una de ellas.
*/

CREATE VIEW V_LicenciasVigentesDiasRestantes as
SELECT L.licNumero, E.estNombre,E.estDireccion,L.licFchEmision,L.licFchVto,L.licStatus, DATEDIFF(DAY,GETDATE(),L.licFchVto) AS Dias_Restantes
FROM Licencias L
INNER JOIN Establecimientos E  ON L.estNumero = E.estNumero
WHERE L.licStatus = 'APR' AND L.licFchVto >= GETDATE();

--Prueba:
select *
from V_LicenciasVigentesDiasRestantes