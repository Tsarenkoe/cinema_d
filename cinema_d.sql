CREATE DATABASE IF NOT EXISTS cinema_db;
USE cinema_db;

CREATE TABLE IF NOT EXISTS movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    duration_minutes INT,
    age_rating VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS halls (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT
);

CREATE TABLE IF NOT EXISTS sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    hall_id INT,
    session_date DATE,
    session_time TIME,
    ticket_price DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT,
    seat_number INT,
    buyer_name VARCHAR(255),
    purchase_date DATE
)

INSERT INTO movies (title, genre, duration_minutes, age_rating) VALUES
('Початок', 'Action', 148, '16+'),
('Інтерстеллар', 'Sci-Fi', 169, '12+'),
('Темний лицар', 'Action', 152, '16+'),
('Рататуй', 'Animation', 111, '0+'),
('Джентльмени', 'Comedy', 113, '18+');

INSERT INTO halls (name, capacity) VALUES
('IMAX Головний', 120),
('Синій зал', 45),
('VIP Камерний', 20);

INSERT INTO sessions (movie_id, hall_id, session_date, session_time, ticket_price) VALUES
(1, 1, '2026-06-01', '14:00:00', 180.00),
(1, 2, '2026-06-01', '19:30:00', 140.00),
(2, 1, '2026-06-01', '17:00:00', 200.00),
(3, 1, '2026-06-02', '21:00:00', 190.00),
(4, 2, '2026-06-02', '11:00:00', 100.00),
(5, 3, '2026-06-02', '18:00:00', 300.00),
(2, 2, '2026-06-03', '15:00:00', 130.00),
(4, 3, '2026-06-03', '12:00:00', 220.00);

INSERT INTO tickets (session_id, seat_number, buyer_name, purchase_date) VALUES
(1, 12, 'Олександр', '2026-05-28'),
(1, 13, 'Марія', '2026-05-28'),
(1, 14, 'Дмитро', '2026-05-29'),
(2, 5, 'Анна', '2026-05-29'),
(3, 40, 'Олена', '2026-05-27'),
(3, 41, 'Ігор', '2026-05-27'),
(3, 42, 'Владислав', '2026-05-28'),
(4, 22, 'Максим', '2026-05-29'),
(4, 23, 'Тетяна', '2026-05-29'),
(5, 7, 'Артем', '2026-05-25'),
(5, 8, 'Юлія', '2026-05-26'),
(6, 1, 'Віталій', '2026-05-29'),
(6, 2, 'Оксана', '2026-05-29'),
(7, 10, 'Сергій', '2026-05-28'),
(7, 11, 'Наталія', '2026-05-28');

-- 4. SQL-ЗАПИТИ

-- • Вивести всі фільми.
SELECT * FROM movies;

-- • Вивести всі фільми жанру Action.
SELECT * FROM movies WHERE genre = 'Action';

-- • Вивести фільми, тривалість яких більша за 120 хвилин.
SELECT * FROM movies WHERE duration_minutes > 120;

-- • Вивести всі зали, місткість яких більша за 50 місць.
SELECT * FROM halls WHERE capacity > 50;

-- • Вивести всі сеанси на конкретну дату.
SELECT * FROM sessions WHERE session_date = '2026-06-01';

-- • Вивести список сеансів разом із назвою фільму та назвою залу.
SELECT s.id, m.title, h.name, s.session_date, s.session_time 
FROM sessions s
JOIN movies m ON s.movie_id = m.id
JOIN halls h ON s.hall_id = h.id;

-- • Вивести всі квитки разом із назвою фільму, датою та часом сеансу.
SELECT t.id, m.title, s.session_date, s.session_time, t.seat_number, t.buyer_name
FROM tickets t
JOIN sessions s ON t.session_id = s.id
JOIN movies m ON s.movie_id = m.id;

-- • Порахувати кількість проданих квитків для кожного сеансу.
SELECT session_id, COUNT(id) AS tickets_sold FROM tickets GROUP BY session_id;

-- • Вивести фільми, на які було продано хоча б один квиток.
SELECT DISTINCT m.title FROM movies m
JOIN sessions s ON m.id = s.movie_id
JOIN tickets t ON s.id = t.session_id;

-- • Порахувати загальну суму продажів по кожному фільму.
SELECT m.title, SUM(s.ticket_price) AS total_sales
FROM movies m
JOIN sessions s ON m.id = s.movie_id
JOIN tickets t ON s.id = t.session_id
GROUP BY m.title;
