CREATE DATABASE biblioteca_db;
use biblioteca_db;
-- 1. Tabela de Autores
CREATE TABLE autores (
    id_autor int PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nacionalidade VARCHAR(50)
);

-- 2. Tabela de Categorias / Gêneros
CREATE TABLE categorias (
    id_categoria int PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

-- 3. Tabela de Editoras
CREATE TABLE editoras (
    id_editora int PRIMARY KEY,
    nome VARCHAR(150) NOT NULL UNIQUE,
    cidade VARCHAR(100)
);

-- 4. Tabela de Livros (Metadados da Obra)
CREATE TABLE livros (
    id_livro int PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    ano_publicacao INT,
    id_categoria INT NOT NULL,
    id_editora INT NOT NULL,
    CONSTRAINT fk_livro_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    CONSTRAINT fk_livro_editora FOREIGN KEY (id_editora) REFERENCES editoras(id_editora)
);

-- 5. Tabela Associativa: Livro <-> Autor (Relacionamento N:N)
CREATE TABLE livro_autor (
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_livro, id_autor),
    CONSTRAINT fk_la_livro FOREIGN KEY (id_livro) REFERENCES livros(id_livro) ON DELETE CASCADE,
    CONSTRAINT fk_la_autor FOREIGN KEY (id_autor) REFERENCES autores(id_autor) ON DELETE CASCADE
);

-- 6. Tabela de Exemplares Físicos
CREATE TABLE exemplares (
    id_exemplar int PRIMARY KEY,
    id_livro INT NOT NULL,
    codigo_patrimonio VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'DISPONIVEL' 
        CHECK (status IN ('DISPONIVEL', 'EMPRESTADO', 'EM_MANUTENCAO', 'PERDIDO')),
    CONSTRAINT fk_exemplar_livro FOREIGN KEY (id_livro) REFERENCES livros(id_livro) ON DELETE CASCADE
);

-- 7. Tabela de Usuários / Leitores
CREATE TABLE usuarios (
    id_usuario int PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL DEFAULT CURRENT_DATE
);

-- 8. Tabela de Empréstimos
CREATE TABLE emprestimos (
    id_emprestimo int PRIMARY KEY,
    id_exemplar INT NOT NULL,
    id_usuario INT NOT NULL,
    data_emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao_real DATE,
    valor_multa DECIMAL(10, 2) DEFAULT 0.00,
    status VARCHAR(20) NOT NULL DEFAULT 'ATIVO' 
        CHECK (status IN ('ATIVO', 'CONCLUIDO', 'ATRASADO')),
    CONSTRAINT fk_emprestimo_exemplar FOREIGN KEY (id_exemplar) REFERENCES exemplares(id_exemplar),
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);