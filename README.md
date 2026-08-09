# 📊 Análise de Chinook

![SQL Server](https://img.shields.io/badge/SQL%20Server-2019-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=power-bi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-FFB900?style=for-the-badge&logo=power-bi&logoColor=black)
![Star Schema](https://img.shields.io/badge/Modelagem-Star%20Schema-6C5CE7?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Concluído-27AE60?style=for-the-badge)

### Conhecendo o Banco de Dados e as Tabelas que serão usadas

VISÃO GERAL

* Domínio de Negócio: Loja digital de mídia (venda de músicas, álbuns e faixas de áudio), similar a uma plataforma tipo iTunes/Apple Music.

Objetivo: Armazenar e gerenciar informações sobre catálogo musical (artistas, álbuns, faixas), clientes, funcionários, faturamento e playlists, permitindo análises de vendas, comportamento de clientes e performance de produtos/funcionários.

* Total de Tabelas: 11 tabelas principais

* Modelo de Dados: Relacional normalizado (3FN), podendo ser remodelado em esquema estrela para fins analíticos (fato: InvoiceLine/Invoice; dimensões: Customer, Employee, Track, Album, Artist, Genre, MediaType).

#### DICIONÁRIO DE TABELAS

* dbo.Artist Descrição: Armazena os artistas/bandas cadastrados no catálogo.
ArtistId (INT, PK): Identificador único do artista
Name (NVARCHAR): Nome do artista ou banda

* dbo.Album Descrição: Armazena os álbuns musicais, vinculados a um artista.
AlbumId (INT, PK): Identificador único do álbum
Title (NVARCHAR): Título do álbum
ArtistId (INT, FK): Referência ao artista (Artist)

* dbo.Track Descrição: Armazena as faixas musicais individuais disponíveis para venda.
TrackId (INT, PK): Identificador único da faixa
Name (NVARCHAR): Nome da faixa
AlbumId (INT, FK): Referência ao álbum (Album)
MediaTypeId (INT, FK): Referência ao tipo de mídia (MediaType)
GenreId (INT, FK): Referência ao gênero (Genre)
Composer (NVARCHAR): Nome do(s) compositor(es)
Milliseconds (INT): Duração da faixa em milissegundos
Bytes (INT): Tamanho do arquivo digital em bytes
UnitPrice (DECIMAL): Preço unitário de venda

* dbo.Genre Descrição: Categorias/gêneros musicais.
GenreId (INT, PK): Identificador único do gênero
Name (NVARCHAR): Nome do gênero (Rock, Jazz, Pop, etc.)

* dbo.MediaType Descrição: Formatos de arquivo de mídia disponíveis.
MediaTypeId (INT, PK): Identificador único
Name (NVARCHAR): Formato (MPEG, AAC audio, Protected AAC, etc.)

* dbo.Playlist Descrição: Listas de reprodução criadas com conjuntos de faixas.
PlaylistId (INT, PK): Identificador único da playlist
Name (NVARCHAR): Nome da playlist

* dbo.PlaylistTrack Descrição: Tabela associativa (N:N) entre playlists e faixas.
PlaylistId (INT, FK): Referência à playlist
TrackId (INT, FK): Referência à faixa

* dbo.Customer Descrição: Cadastro dos clientes da loja.
CustomerId (INT, PK): Identificador único do cliente
FirstName (NVARCHAR): Primeiro nome
LastName (NVARCHAR): Sobrenome
Company (NVARCHAR): Empresa do cliente (se aplicável)
Address (NVARCHAR): Endereço
City (NVARCHAR): Cidade
State (NVARCHAR): Estado
Country (NVARCHAR): País
PostalCode (NVARCHAR): CEP
Phone (NVARCHAR): Telefone
Fax (NVARCHAR): Fax
Email (NVARCHAR): E-mail
SupportRepId (INT, FK): Funcionário responsável pelo atendimento (Employee)

* dbo.Employee Descrição: Cadastro dos funcionários da empresa, com hierarquia organizacional.
EmployeeId (INT, PK): Identificador único do funcionário
LastName (NVARCHAR): Sobrenome
FirstName (NVARCHAR): Primeiro nome
Title (NVARCHAR): Cargo/função
ReportsTo (INT, FK): Referência ao gestor direto (auto-relacionamento)
BirthDate (DATETIME): Data de nascimento
HireDate (DATETIME): Data de contratação
Address (NVARCHAR): Endereço
City (NVARCHAR): Cidade
State (NVARCHAR): Estado
Country (NVARCHAR): País
PostalCode (NVARCHAR): CEP
Phone (NVARCHAR): Telefone
Fax (NVARCHAR): Fax
Email (NVARCHAR): E-mail

* dbo.Invoice Descrição: Cabeçalho das faturas/vendas realizadas.
InvoiceId (INT, PK): Identificador único da fatura
CustomerId (INT, FK): Referência ao cliente
InvoiceDate (DATETIME): Data em que a venda foi realizada
BillingAddress (NVARCHAR): Endereço de cobrança
BillingCity (NVARCHAR): Cidade de cobrança
BillingState (NVARCHAR): Estado de cobrança
BillingCountry (NVARCHAR): País de cobrança
BillingPostalCode (NVARCHAR): CEP de cobrança
Total (DECIMAL): Valor total da fatura

* dbo.InvoiceLine Descrição: Itens detalhados de cada fatura (nível de item vendido — tabela fato principal, granularidade mais fina).
InvoiceLineId (INT, PK): Identificador único do item
InvoiceId (INT, FK): Referência à fatura (Invoice)
TrackId (INT, FK): Referência à faixa vendida (Track)
UnitPrice (DECIMAL): Preço unitário no momento da venda
Quantity (INT): Quantidade vendida

#### OBSERVAÇÕES PARA O PROJETO
* Chave de granularidade analítica: InvoiceLine é o nível mais atômico para métricas de vendas (quantidade e receita).
* Hierarquia organizacional: Employee.ReportsTo cria uma estrutura recursiva de gestão.
* Integridade referencial: Todas as FKs seguem padrão TabelaId e garantem consistência entre catálogo, vendas e clientes.

### Análise Exploratória de Dados (EDA) — Chinook

Vamos entender a estrutura, qualidade e distribuição dos dados.

*  Contagem de registros por tabela
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Contagem%20de%20registros%20por%20tabela.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Período de dados disponível (range de datas)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Periodo%20de%20dados%20disponivel.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de valores nulos/ausentes em campos críticos
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Verifica%C3%A7%C3%A3o%20de%20valores%20nulos%20ou%20ausentes%20em%20campos%20cr%C3%ADticos.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de duplicidade de faturas
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Verifica%C3%A7%C3%A3o%20de%20duplicidade%20de%20fatura.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Estatísticas descritivas — Valor das faturas (Total)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Estatistica%20descritiva.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Distribuição de faturas por faixa de valor (histograma simplificado)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Distribui%C3%A7%C3%A3o%20de%20Faturas%20por%20Faixa%20de%20Valor.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Quantidade de países distintos e concentração de vendas
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Quantidade%20de%20Paises%20distintos%20e%20concentra%C3%A7%C3%A3o%20de%20vendas.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de faixas sem gênero ou sem preço (qualidade do catálogo)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Verifica%C3%A7%C3%A3o%20de%20faixas%20sem%20g%C3%AAnero%20ou%20sem%20pre%C3%A7o.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

*  Quantidade de faixas por gênero (visão geral do catálogo)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Quantidade%20de%20Faixas%20por%20Genero.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Preço médio, mínimo e máximo por gênero (checar consistência de preços)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Pre%C3%A7o%20medio%2C%20minimo%20e%20maximo%20por%20g%C3%AAnero.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Clientes sem nenhuma compra (potencial churn desde o início)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Clientes%20sem%20nenhuma%20compra.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de integridade — InvoiceLine sem Invoice correspondente
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Verifica%C3%A7%C3%A3o%20de%20integridade%20-%20invoiceline%20sem%20invoice.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Consistência entre Total da fatura e soma dos itens (InvoiceLine)
<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Consistencia%20entre%20total%20da%20fatura%20e%20soma%20dos%20itens.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

### Queries Principais

* Vendas Gerais: essa query junta faturas, itens vendidos e gêneros musicais, agrupando tudo por ano, mês, país e gênero. Para cada combinação, calcula quanto de receita foi gerado, o valor médio das compras, quantas faturas e clientes existiram, e qual o peso daquele grupo dentro da receita total da loja. O resultado mostra a evolução das vendas no tempo e onde/o quê está gerando mais dinheiro.

<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Query%20Canal%20de%20Vendas.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Clientes & RFM: Primeiro calculamos, para cada cliente, há quanto tempo comprou pela última vez, quantas vezes comprou e quanto gastou no total. Depois, dividimos os clientes em quatro grupos para cada uma dessas três métricas, dando uma nota de 1 a 4. Juntando as três notas, classificamos cada cliente em categorias como "Campeão", "Fiel", "Em Risco" ou "Perdido", facilitando ações de marketing e retenção direcionadas.

<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Query%20Clientes%20%26%20RFM.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Catálogo/Produto: Essa query analisa o catálogo de produtos (faixas, álbuns, artistas e gêneros), calculando receita, quantidade vendida e preço médio de cada item. Também mostra o percentual que cada faixa representa dentro do seu gênero e cria um ranking das faixas mais vendidas por gênero, ajudando a identificar quais produtos realmente sustentam cada categoria musical.

<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Query%20Cat%C3%A1logo%20x%20Produto.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Performance Gerencial: Essa query avalia o desempenho de cada funcionário com base nos clientes que ele atende. Calcula quantos clientes estão na carteira, quanto de receita esses clientes geraram, o ticket médio e a receita média por cliente. Também cria um ranking geral entre os funcionários, apoiando decisões de gestão como bonificação e redistribuição de carteira.

<a href="https://github.com/LucianBrito/Chinook/blob/main/SQL/Query%20Performance%20Gerencial.sql" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

### Etapa de Transformação de Dados, Power Query ( Dashboard com foco em Vendas Gerais)

Nesta etapa foram avaliadas as sete tabelas originais da base Chinook utilizadas no Dashboard 1, Streaming Dark, com foco em vendas gerais. O objetivo foi remover colunas não utilizadas, ajustar tipos de dados, renomear campos para nomenclatura de negócio e tratar valores nulos.

* Na tabela Invoice foram removidas as colunas de endereço detalhado, como BillingAddress, BillingCity, BillingState e BillingPostalCode, mantendo apenas InvoiceId, CustomerId, InvoiceDate, BillingCountry e Total, este último renomeado para InvoiceTotal. Os tipos de dados de InvoiceDate e Total foram confirmados como Data e Número Decimal respectivamente. A coluna BillingCountry foi verificada quanto a valores nulos, sendo tratada quando necessário.

* Na tabela InvoiceLine foram mantidas todas as colunas relevantes, InvoiceLineId, InvoiceId, TrackId, UnitPrice e Quantity, com os tipos de dados confirmados como Número Decimal para UnitPrice e Número Inteiro para Quantity. Foi identificada a presença de uma coluna adicional de desconto, que precisa ter sua fórmula de cálculo de receita por linha validada antes da criação das medidas.

* Na tabela Customer foram removidas as colunas de contato e endereço, como Company, Address, City, State, PostalCode, Phone, Fax e SupportRepId, mantendo apenas CustomerId, FirstName e LastName, suficientes para a contagem de clientes ativos no dashboard de vendas gerais.

* Na tabela Track foram removidas as colunas MediaTypeId, Composer, Milliseconds e Bytes, mantendo TrackId, Name, AlbumId, GenreId e UnitPrice, necessárias para a ligação entre faixa, álbum e gênero. Foi identificada a existência de registros com GenreId nulo, que precisam ser tratados como categoria não informada.

 * Na tabela Genre foram mantidas as duas colunas originais, sendo a coluna Name renomeada para Genero, visando padronização de nomenclatura nas medidas e visuais.

* Na tabela Album foram mantidas as três colunas originais, sendo a coluna Title renomeada para Album, mantendo AlbumId e ArtistId para a ligação com a tabela Artist.

* Na tabela Artist foram mantidas as duas colunas originais, sendo a coluna Name renomeada para Artista.

### Etapa de Modelagem de Dados

Foi criada uma tabela Calendario independente, gerada via consulta em branco no Power Query, com o intervalo de datas calculado a partir do valor mínimo e máximo da coluna InvoiceDate da tabela Invoice. Essa tabela contém as colunas Data, Ano, MesNumero, MesNome, AnoMes, Trimestre, DiaSemanaNumero, DiaSemanaNome e FimDeSemana, sendo marcada como tabela de datas oficial do modelo, com a coluna Data definida como chave única de data.

* O modelo relacional resultante segue o formato de esquema estrela, com a tabela Invoice funcionando como tabela de fatos central. As tabelas Customer e Calendario se relacionam diretamente com Invoice em cardinalidade um para muitos, sendo Customer e Calendario o lado um, e Invoice o lado muitos. A tabela InvoiceLine se relaciona com Invoice em cardinalidade muitos para um, funcionando como uma segunda tabela de fatos no nível de item vendido. A tabela InvoiceLine também se relaciona com Track em cardinalidade um para muitos, sendo Track o lado um. A tabela Track, por sua vez, se relaciona com Genre e com Album, ambas em cardinalidade um para muitos, sendo Genre e Album o lado um. A tabela Album se relaciona com Artist em cardinalidade um para muitos, sendo Artist o lado um.

* Dois pontos de atenção foram identificados nesta etapa e precisam de ajuste antes do avanço para as medidas DAX. O primeiro é a duplicidade de informação temporal, com as colunas Ano e Nome do Mês presentes tanto na tabela Invoice quanto na tabela Calendario, devendo ser removidas da tabela Invoice para evitar inconsistência de Time Intelligence. O segundo é a necessidade de validação da fórmula da coluna LineTotal na tabela InvoiceLine, para confirmar se o valor de desconto está sendo corretamente subtraído no cálculo de receita por linha.

<image src = "https://github.com/LucianBrito/Chinook/blob/main/Prints/Schema.png">

### Medidas DAX — Dashboard 1 "Vendas Gerais"

Todas as medidas foram organizadas em uma tabela dedicada, #Medidas.

* Receita Total soma o valor final vendido (LineTotal). Qtd Faixas Vendidas soma as quantidades. Qtd Faturas e Qtd Clientes Ativos contam faturas e clientes distintos. Ticket Medio e Receita Media por Cliente dividem a receita total pela quantidade de faturas e de clientes, respectivamente.

* Usando a tabela Calendario, foram criadas medidas de tempo: Receita Mes Anterior e Receita Ano Anterior trazem a receita de períodos comparativos, usadas para calcular Variacao MoM e Variacao YoY em percentual. Receita YTD acumula a receita desde o início do ano, e Receita Acumulada 12 Meses soma os últimos doze meses corridos.

* Top Genero e Top Artista identificam o gênero e artista com maior receita no filtro atual. Ranking Genero e Ranking Artista atribuem posição a cada um com base na receita.

* % Receita do Genero e % Receita do Pais calculam a participação de cada item no total geral, ignorando o filtro do próprio campo.

* Qtd Paises Ativos conta países com vendas registradas, e Receita Pais Top1 traz a receita do país líder em faturamento._

<image src = "https://github.com/LucianBrito/Chinook/blob/main/Prints/Medidas%20Dax%20Criadas.png">
  
#### Dashboard Vendas Gerais

<image src = "https://github.com/LucianBrito/Chinook/blob/main/Prints/Sales%20Overview.png">













#### Dashboard Clientes & RFM

<image src = "">

#### Dashboard Catalogo/Produtos

<image src = "">

#### DAshboard Performance Gerencial

<image src = "">

