SELECT 
    MIN(InvoiceTotal) AS Minimo,
    MAX(InvoiceTotal) AS Maximo,
    AVG(InvoiceTotal) AS Media,
    SUM(InvoiceTotal) AS Soma,
    COUNT(*) AS Qtd
FROM Invoice;
