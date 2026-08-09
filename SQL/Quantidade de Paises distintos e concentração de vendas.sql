
-- Qtd. de países distintos
SELECT COUNT(DISTINCT BillingCountry) AS QtdPaisesDistintos
FROM Invoice;

-- Top 5 países por receita (T-SQL)
SELECT TOP (5)
    BillingCountry,
    SUM(InvoiceTotal) AS Receita,
    ROUND(SUM(InvoiceTotal) * 100.0 / SUM(SUM(InvoiceTotal)) OVER (), 2) AS PercentualDoTotal
FROM Invoice
GROUP BY BillingCountry
ORDER BY Receita DESC;