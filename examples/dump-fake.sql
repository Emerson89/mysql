-- Dump fake para testes - exemplo simples
-- Banco: company_db

DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db;
USE company_db;

-- Tabela de usuários
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email) VALUES
('Alice Santos', 'alice@example.com'),
('Bruno Lima', 'bruno@example.com'),
('Carla Souza', 'carla@example.com'),
('Daniel Oliveira', 'daniel@example.com');

-- Tabela de produtos
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (name, price, stock) VALUES
('Teclado Mecânico', 350.00, 25),
('Mouse Gamer', 199.90, 40),
('Monitor 27"', 1249.99, 15),
('Headset Pro', 499.00, 30);

-- Tabela de pedidos
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO orders (user_id, total) VALUES
(1, 549.90),
(2, 1249.99),
(3, 499.00);

-- Tabela de itens do pedido
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 2, 1, 199.90),
(1, 1, 1, 350.00),
(2, 3, 1, 1249.99),
(3, 4, 1, 499.00);
