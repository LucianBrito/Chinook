SELECT InvoiceId, COUNT(*) AS Ocorrencias
FROM Invoice
GROUP BY InvoiceId
HAVING COUNT(*) > 1;
