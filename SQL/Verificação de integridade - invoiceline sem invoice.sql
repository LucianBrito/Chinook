SELECT il.*
FROM InvoiceLine il
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE i.InvoiceId IS NULL;
