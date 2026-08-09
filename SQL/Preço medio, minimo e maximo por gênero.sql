SELECT 
    g.Name AS Genero,
    MIN(t.UnitPrice) AS PrecoMin,
    MAX(t.UnitPrice) AS PrecoMax,
    AVG(t.UnitPrice) AS PrecoMedio
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY PrecoMedio DESC;
