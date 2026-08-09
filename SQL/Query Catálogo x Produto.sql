SELECT
    g.Name AS Genero,
    ar.Name AS Artista,
    al.Title AS Album,
    t.Name AS Faixa,
    mt.Name AS TipoMidia,
    SUM(il.UnitPrice * il.Quantity) AS ReceitaTotal,
    AVG(t.UnitPrice) AS PrecoMedioCatalogo,
    SUM(il.Quantity) AS QtdVendida,
    COUNT(DISTINCT il.InvoiceId) AS QtdFaturasComEsseItem,
    ROUND(SUM(il.Quantity) * 100.0 / SUM(SUM(il.Quantity)) OVER (PARTITION BY g.Name), 2) AS PercentualDentroDoGenero,
    RANK() OVER (PARTITION BY g.Name ORDER BY SUM(il.UnitPrice * il.Quantity) DESC) AS RankingNoGenero
FROM InvoiceLine il
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Album al ON t.AlbumId = al.AlbumId
INNER JOIN Artist ar ON al.ArtistId = ar.ArtistId
LEFT JOIN Genre g ON t.GenreId = g.GenreId
LEFT JOIN MediaType mt ON t.MediaTypeId = mt.MediaTypeId
GROUP BY g.Name, ar.Name, al.Title, t.Name, mt.Name, t.UnitPrice
ORDER BY Genero, ReceitaTotal DESC;
