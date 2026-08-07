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
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Período de dados disponível (range de datas)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de valores nulos/ausentes em campos críticos
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de duplicidade de faturas
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Estatísticas descritivas — Valor das faturas (Total)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Distribuição de faturas por faixa de valor (histograma simplificado)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Quantidade de países distintos e concentração de vendas
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de faixas sem gênero ou sem preço (qualidade do catálogo)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

*  Quantidade de faixas por gênero (visão geral do catálogo)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Preço médio, mínimo e máximo por gênero (checar consistência de preços)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Clientes sem nenhuma compra (potencial churn desde o início)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Verificação de integridade — InvoiceLine sem Invoice correspondente
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Consistência entre Total da fatura e soma dos itens (InvoiceLine)
<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

### Queries Principais

* Vendas Gerais: essa query junta faturas, itens vendidos e gêneros musicais, agrupando tudo por ano, mês, país e gênero. Para cada combinação, calcula quanto de receita foi gerado, o valor médio das compras, quantas faturas e clientes existiram, e qual o peso daquele grupo dentro da receita total da loja. O resultado mostra a evolução das vendas no tempo e onde/o quê está gerando mais dinheiro.

<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Clientes & RFM: Primeiro calculamos, para cada cliente, há quanto tempo comprou pela última vez, quantas vezes comprou e quanto gastou no total. Depois, dividimos os clientes em quatro grupos para cada uma dessas três métricas, dando uma nota de 1 a 4. Juntando as três notas, classificamos cada cliente em categorias como "Campeão", "Fiel", "Em Risco" ou "Perdido", facilitando ações de marketing e retenção direcionadas.

<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Catálogo/Produto: Essa query analisa o catálogo de produtos (faixas, álbuns, artistas e gêneros), calculando receita, quantidade vendida e preço médio de cada item. Também mostra o percentual que cada faixa representa dentro do seu gênero e cria um ranking das faixas mais vendidas por gênero, ajudando a identificar quais produtos realmente sustentam cada categoria musical.

<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub

* Performance Gerencial: Essa query avalia o desempenho de cada funcionário com base nos clientes que ele atende. Calcula quantos clientes estão na carteira, quanto de receita esses clientes geraram, o ticket médio e a receita média por cliente. Também cria um ranking geral entre os funcionários, apoiando decisões de gestão como bonificação e redistribuição de carteira.

<a href="" target="_blank">Clique aqui</a> e acesse o script SQL no GitHub


#### Dashboard Vendas Gerais

<image src = "">

#### Dashboard Clientes & RFM

<image src = "">

#### Dashboard Catalogo/Produtos

<image src = "">

#### DAshboard Performance Gerencial

<image src = "">

