DECLARE @DataReferencia DATE;
SELECT @DataReferencia = MAX(InvoiceDate) FROM Invoice;

WITH BaseClientes AS (
    SELECT
        c.CustomerId,
        c.FirstName + ' ' + c.LastName AS NomeCliente,
        c.Country AS Pais,
        c.Email AS Email,
        DATEDIFF(DAY, MAX(i.InvoiceDate), @DataReferencia) AS Recencia,
        COUNT(DISTINCT i.InvoiceId) AS Frequencia,
        SUM(i.InvoiceTotal) AS ValorMonetario,
        ROUND(AVG(i.InvoiceTotal), 2) AS TicketMedioCliente,
        MIN(i.InvoiceDate) AS PrimeiraCompra,
        MAX(i.InvoiceDate) AS UltimaCompra
    FROM Customer c
    INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
    GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Country, c.Email
),
ScoresRFM AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY Recencia DESC) AS Score_R,
        NTILE(4) OVER (ORDER BY Frequencia ASC) AS Score_F,
        NTILE(4) OVER (ORDER BY ValorMonetario ASC) AS Score_M
    FROM BaseClientes
)
SELECT
    CustomerId, NomeCliente, Pais, Email,
    Recencia, Frequencia, ValorMonetario, TicketMedioCliente,
    PrimeiraCompra, UltimaCompra,
    Score_R, Score_F, Score_M,
    CONCAT(Score_R, Score_F, Score_M) AS RFM_Score,
    CASE
        WHEN Score_R = 4 AND Score_F = 4 AND Score_M = 4 THEN 'Campeão'
        WHEN Score_R >= 3 AND Score_F >= 3 THEN 'Cliente Fiel'
        WHEN Score_R = 4 AND Score_F <= 2 THEN 'Novo Cliente'
        WHEN Score_R <= 2 AND Score_F >= 3 THEN 'Em Risco'
        WHEN Score_R = 1 AND Score_F <= 2 THEN 'Perdido'
        ELSE 'Regular'
    END AS SegmentoRFM
FROM ScoresRFM
ORDER BY ValorMonetario DESC;
