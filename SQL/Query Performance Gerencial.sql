SELECT
    e.EmployeeId,
    e.FirstName + ' ' + e.LastName AS NomeFuncionario,
    e.Title AS Cargo,
    mgr.FirstName + ' ' + mgr.LastName AS NomeGestor,
    COUNT(DISTINCT c.CustomerId) AS QtdClientesNaCarteira,
    SUM(i.InvoiceTotal) AS ReceitaGerada,
    ROUND(AVG(i.InvoiceTotal), 2) AS TicketMedioCarteira,
    COUNT(DISTINCT i.InvoiceId) AS QtdFaturasGeradas,
    ROUND(SUM(i.InvoiceTotal) / COUNT(DISTINCT c.CustomerId), 2) AS ReceitaPorCliente,
    RANK() OVER (ORDER BY SUM(i.Total) DESC) AS RankingReceita
FROM Employee e
LEFT JOIN Employee mgr ON e.ReportsTo = mgr.EmployeeId
LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title, mgr.FirstName, mgr.LastName
ORDER BY ReceitaGerada DESC;
