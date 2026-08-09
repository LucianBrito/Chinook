SELECT 
    g.Name AS Genero,
    COUNT(t.TrackId) AS QtdFaixas
FROM Track t
LEFT JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY QtdFaixas DESC;
