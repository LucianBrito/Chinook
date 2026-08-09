
SELECT
    MIN(InvoiceDate) AS PrimeiraData,
    MAX(InvoiceDate) AS UltimaData,
    COUNT(DISTINCT DATEPART(YEAR, InvoiceDate)) AS QtdAnos
FROM Invoice;