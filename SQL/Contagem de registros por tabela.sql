SELECT 'Artist' AS Tabela, COUNT(*) AS QtdRegistros FROM Artist
UNION ALL
SELECT 'Album', COUNT(*) FROM Album
UNION ALL
SELECT 'Track', COUNT(*) FROM Track
UNION ALL
SELECT 'Genre', COUNT(*) FROM Genre
UNION ALL
SELECT 'MediaType', COUNT(*) FROM MediaType
UNION ALL
SELECT 'Playlist', COUNT(*) FROM Playlist
UNION ALL
SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL
SELECT 'Employee', COUNT(*) FROM Employee
UNION ALL
SELECT 'Invoice', COUNT(*) FROM Invoice
UNION ALL
SELECT 'InvoiceLine', COUNT(*) FROM InvoiceLine;
