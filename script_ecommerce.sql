
-- Nome do BD: BD_Ecommerce
-- Usuário: root
-- Senha: 1234

DROP TABLE Pedidos_Produtos;
DROP TABLE Pedidos;
DROP TABLE Produtos;
DROP TABLE Clientes;


CREATE TABLE Produtos(
    ID int NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    Nome varchar(255) NOT NULL,
    Preco double,
    Categoria varchar(20),
    descricao varchar(2048),
    --descricao text,

    PRIMARY KEY (ID)
);
--Produtos
INSERT INTO PRODUTOS (Nome, Preco, categoria, descricao) VALUES('Iphone 6', 2000.0,'Celulares','O iPhone 6 e um celular inteligente, tem um otima  transmissao e recepcao, para que a qualidade da chamada seja sempre melhor. Ele tem conexoes, cargas, recargas e transferÃªncias muito rapidas. Voce pode usar ele praticamente em qualquer lugar, e se conectar a redes de diversos paises.');
INSERT INTO PRODUTOS (Nome, Preco, categoria, descricao) VALUES('Galaxy S5', 1900.0,'Celulares','Com o moderno sistema operacional Android 4.4, o Smartphone Galaxy S5 Mini com 2 Chips e um aparelho que proporciona conexao, entretenimento e praticidade ao seu dia a dia.');
INSERT INTO PRODUTOS (Nome, Preco, categoria, descricao) VALUES('Lumia 930', 1800.0,'Celulares','Conheca o smartphone Nokia Lumia 930, uma excelente opcao com uma configuracao potente, veloz e feita para quem precisa de um aparelho confiavel, robusto e repleto de excelentes recursos.');
INSERT INTO PRODUTOS (Nome, Preco, categoria, descricao) VALUES('FIFA 14 - PS3', 99.0,'Games','FIFA 14 e o mais novo game de futebol da popular serie para PS3, Xbox 360 e PC. A versao 2014 traz avancos significativos na jogabilidade e ganha edicao para Android, iOS e Windows Phone.');
INSERT INTO PRODUTOS (Nome, Preco, categoria, descricao) VALUES('Assassins Creed 3 X360 ', 99.0,'Games','Edicao da serie ambientada na Revolucao Americana no final do seculo 18, que introduz um novo heroi, Ratohnhake: Ton, um nativo americano descendente de ingleses.');
INSERT INTO PRODUTOS (Nome, Preco, categoria, descricao) VALUES('Box - Gelo e Fogo', 129.0,'Livros','As Cronicas de Gelo e Fogo - Todo o reino de Westeros ao alcance das mãos. A serie As cronicas de gelo e fogo dispensa apresentações. São mais de 30 milhares de livros vendidos ao redor do mundo e cerca de 2 milhões no Brasil.');
INSERT INTO PRODUTOS (Nome, Preco, categoria, descricao) VALUES('Livro 1 - Crespusculo', 29.0,'Livros','Quando Isabella Swan se muda para a melancolica cidade de forks e conhece o misterioso e atraente Edward Cullen, sua vida da uma guinada emocionante e apavorante.');


CREATE TABLE Clientes(
    Login varchar(10) UNIQUE NOT NULL,
    Senha varchar(15),
    Nome varchar(255) NOT NULL,
    CPF varchar(12) NOT NULL,
    Endereco varchar(255),
    cidade varchar(255),

    PRIMARY KEY (CPF)
);
--Clientes
INSERT INTO CLIENTES (Login, Senha, Nome, CPF, Endereco, cidade) VALUES('fulano', '1234', 'Guerrero', '11122233345', 'Rua Alameda dos Tupiniquins, 101', 'Sao Paulo');
INSERT INTO CLIENTES (Login, Senha, Nome, CPF, Endereco, cidade) VALUES('fulano2', '1234', 'Ralf', '35241256895', 'Av. Paulista, 1200', 'Sao Paulo');
INSERT INTO CLIENTES (Login, Senha, Nome, CPF, Endereco, cidade) VALUES('fulano3', '1234', 'Angel Romero', '358745985455', 'Rua sergipe, 305', 'Sao Paulo');
INSERT INTO CLIENTES (Login, Senha, Nome, CPF, Endereco, cidade) VALUES('fulano4', '1234', 'Uendel', '65789545235', 'Av. Angelica, 2008', 'Sao Paulo');
INSERT INTO CLIENTES (Login, Senha, Nome, CPF, Endereco, cidade) VALUES('fulano5', '1234', 'Cassio', '35741245698', 'Av. Antonio Abrahao Caran, 30', 'Belo Horizonte');
INSERT INTO CLIENTES (Login, Senha, Nome, CPF, Endereco, cidade) VALUES('fulano6', '1234', 'Ferrugem', '12587458963', 'Av. Cristiano Machado, 47', 'Belo Horizonte');
INSERT INTO CLIENTES (Login, Senha, Nome, CPF, Endereco, cidade) VALUES('fulano7', '1234', 'Fagner', '35214523658', 'Rua Hamilton, 420', 'Belo Horizonte');

CREATE TABLE Pedidos (
    NumPedido int NOT NULL,
    ClienteCPF varchar(12) NOT NULL,
    Endereco varchar(255),
    Pago boolean DEFAULT false,
    Data date,
    ValorTotal double,      --Poderia ser feito um trigger para pegar a soma automaticamente
    FormaPagamento varchar(20),

    PRIMARY KEY (NumPedido),
    FOREIGN KEY (ClienteCPF) REFERENCES Clientes(CPF)
);
--Pedidos
INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento) VALUES (101,'11122233345','Rua Alameda dos Tupiniquins, 101', 2000.0, 'Boleto');
INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento) VALUES (102,'35241256895','Av. Paulista, 1200', 315.0, 'Boleto');
INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento) VALUES (103,'358745985455','Rua Sergipe, 305', 0.0, 'Boleto');
INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento) VALUES (104,'65789545235','Av. Angelica, 2008', 0.0, 'Boleto');
INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento) VALUES (105,'35741245698','Av. Antônio Abrahão Caran, 30', 0.0, 'Boleto');
INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento) VALUES (106,'12587458963','Av. Cristiano Machado, 47', 0.0, 'Boleto');
INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento) VALUES (107,'35214523658','Rua Hamilton, 420', 0.0, 'Boleto');

CREATE TABLE Pedidos_Produtos (
    IDPedido int NOT NULL,
    IDProduto int NOT NULL,
    Quantidade int,
    Valor double,
    
    PRIMARY KEY (IDPedido, IDProduto),
    FOREIGN KEY (IDPedido) REFERENCES Pedidos(NumPedido), 
    FOREIGN KEY (IDProduto) REFERENCES Produtos(ID) 
);
--Pedidos_Produtos
INSERT INTO Pedidos_Produtos (IDPedido, IDProduto, Quantidade, Valor) VALUES (101, 1, 1, 2000.0);
INSERT INTO Pedidos_Produtos (IDPedido, IDProduto, Quantidade, Valor) VALUES (102, 4, 2, 186.0);
INSERT INTO Pedidos_Produtos (IDPedido, IDProduto, Quantidade, Valor) VALUES (102, 6, 1, 129.0);



