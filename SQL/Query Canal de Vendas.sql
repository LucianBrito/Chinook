SELECT
    YEAR(i.InvoiceDate) AS Ano,
    FORMAT(i.InvoiceDate, 'yyyy-MM') AS AnoMes,
    i.BillingCountry AS Pais,
    g.Name AS Genero,
    SUM(il.UnitPrice * il.Quantity) AS ReceitaTotal,
    ROUND(SUM(il.UnitPrice * il.Quantity) / COUNT(DISTINCT i.InvoiceId), 2) AS TicketMedio,
    COUNT(DISTINCT i.InvoiceId) AS QtdFaturas,
    SUM(il.Quantity) AS QtdFaixasVendidas,
    COUNT(DISTINCT i.CustomerId) AS QtdClientesAtivos,
    ROUND(SUM(il.UnitPrice * il.Quantity) * 100.0 / SUM(SUM(il.UnitPrice * il.Quantity)) OVER (), 2) AS PercentualDaReceitaTotal
FROM Invoice i
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY
    YEAR(i.InvoiceDate),
    FORMAT(i.InvoiceDate, 'yyyy-MM'),
    i.BillingCountry,
    g.Name
ORDER BY Ano DESC, ReceitaTotal DESC;
