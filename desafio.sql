CREATE DATABASE IF NOT EXISTS bibioteca_db DEFAULT CHARACTER SET utf8mb4;

USE biblioteca_db;

-- CRIAÇÃO DA TABELA SESSAO
CREATE TABLE IF NOT EXISTS sessao (
    id_sessao int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(100) NOT NULL,
    descricao text
) ENGINE = innoDB;

-- CRIAÇÃO DA TABELA LIVRO
CREATE TABLE IF NOT EXISTS livro (
    id_livro Int AUTO_INCREMENT PRIMARY KEY,
    titulo varchar(100) NOT NULL,
    ano_publicao int,
    autor varchar(150) NOT NULL,
    id_sessao int NOT NULL,
    isbn varchar(20) UNIQUE,
    CONSTRAINT fk_livro_sessao FOREIGN KEY (id_sessao) REFERENCES sessao (id_sessao)
) ENGINE = innoDB;

-- CRIAÇÃO DA TABELA USUARIO (leitores / membros da bibliotecaa)
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(100) NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    telefone varchar(20),
    data_cadastro DATE NOT NULL DEFAULT(CURRENT_DATE)
) ENGINE = innoDB;

-- CRIAÇÃO DA TABELA EXEMPLAR (copia fisicas de cada livro)
CREATE TABLE IF NOT EXISTS exemplar (
    id_exemplar int AUTO_INCREMENT PRIMARY KEY,
    id_livro int NOT NULL,
    codigo_tombo varchar(30) UNIQUE NOT NULL,
    STATUS ENUM(
        'disponivel',
        'emprestado',
        'reservado',
        'manutencao'
    ) NOT NULL DEFAULT 'disponivel',
    CONSTRAINT fk_exemplar_livro FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
) ENGINE = innoDB;

-- CRIAÇÃO DA TABELA EMPRESTIMO
CREATE TABLE IF NOT EXISTS emprestimo (
    id_emprestimo int AUTO_INCREMENT PRIMARY KEY,
    id_exemplar int NOT NULL,
    id_usuario int NOT NULL,
    data_emprestimo DATE NOT NULL DEFAULT(CURRENT_DATE),
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao DATE,
    CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (id_exemplar) REFERENCES exemplar (id_exemplar),
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
) ENGINE = innoDB;

-- CRIAÇÃO DA TABELA GENERO
CREATE TABLE IF NOT EXISTS genero (
    id_genero int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(80) UNIQUE NOT NULL,
    descricao text
) ENGINE = innoDB;

-- CRIAÇÃO DA TABLEA CATIGORIA
CREATE TABLE IF NOT EXISTS categoria (
    id_categoria int AUTO_INCREMENT PRIMARY KEY,
    nome varchar(80) UNIQUE NOT NULL,
    descricao text
) ENGINE = innoDB;

-- CRIAÇAO DA TABELA LIGACAO (CATIGORIA <---> GENERO N:N)
CREATE TABLE IF NOT EXISTS livro_categoria (
    id_livro int NOT NULL,
    id_categoria int NOT NULL,
    PRIMARY KEY (id_livro, id_categoria),
    CONSTRAINT fk_livrocategoria_livro FOREIGN KEY (id_livro) REFERENCES livro (id_livro) ON DELETE CASCADE,
    CONSTRAINT fk_livrocategoria_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria) ON DELETE CASCADE
) ENGINE = innoDB;

-- TABELA DE LIGAÇÃO: LIVRO <-> CATIGORIA (N:N)
CREATE TABLE IF NOT EXISTS livro_genero (
    id_livro INT NOT NULL,
    id_genero INT NOT NULL,
    PRIMARY KEY (id_livro, id_genero),
    CONSTRAINT fk_livrogenero_livro FOREIGN KEY (id_livro) REFERENCES livro (id_livro) ON DELETE CASCADE,
    CONSTRAINT fk_livrogenero_genero FOREIGN KEY (id_genero) REFERENCES genero (id_genero) ON DELETE CASCADE
) ENGINE = InnoDB;