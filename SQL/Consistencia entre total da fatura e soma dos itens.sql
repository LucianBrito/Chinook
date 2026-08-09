SELECT 
    i.InvoiceId,
    i.InvoiceTotal AS TotalFatura,
    SUM(il.UnitPrice * il.Quantity) AS TotalCalculado,
    ROUND(i.InvoiceTotal - SUM(il.UnitPrice * il.Quantity), 2) AS Diferenca
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId, i.InvoiceTotal
HAVING ABS(i.InvoiceTotal - SUM(il.UnitPrice * il.Quantity)) > 0.01;
