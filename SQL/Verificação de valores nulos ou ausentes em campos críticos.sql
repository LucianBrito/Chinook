SELECT 
    SUM(CASE WHEN InvoiceTotal IS NULL THEN 1 ELSE 0 END) AS Total_Nulos,
    SUM(CASE WHEN CustomerId IS NULL THEN 1 ELSE 0 END) AS CustomerId_Nulos,
    SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS InvoiceDate_Nulos,
    SUM(CASE WHEN BillingCountry IS NULL OR BillingCountry = '' THEN 1 ELSE 0 END) AS Pais_Nulos
FROM Invoice;
