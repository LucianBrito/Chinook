SELECT 
    CASE 
        WHEN InvoiceTotal < 5 THEN '0-5'
        WHEN InvoiceTotal < 10 THEN '5-10'
        WHEN InvoiceTotal < 15 THEN '10-15'
        WHEN InvoiceTotal < 20 THEN '15-20'
        ELSE '20+'
    END AS FaixaValor,
    COUNT(*) AS QtdFaturas,
    MIN(InvoiceTotal) AS MinValor
FROM Invoice
GROUP BY 
    CASE 
        WHEN InvoiceTotal < 5 THEN '0-5'
        WHEN InvoiceTotal < 10 THEN '5-10'
        WHEN InvoiceTotal < 15 THEN '10-15'
        WHEN InvoiceTotal < 20 THEN '15-20'
        ELSE '20+'
    END
ORDER BY MinValor;