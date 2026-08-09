SELECT 
    SUM(CASE WHEN GenreId IS NULL THEN 1 ELSE 0 END) AS SemGenero,
    SUM(CASE WHEN UnitPrice IS NULL OR UnitPrice = 0 THEN 1 ELSE 0 END) AS SemPreco,
    SUM(CASE WHEN Composer IS NULL OR Composer = '' THEN 1 ELSE 0 END) AS SemCompositor
FROM Track;
