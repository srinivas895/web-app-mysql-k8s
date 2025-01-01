
-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS flaskapp;

-- Use the created database
USE flaskapp;

-- Create the users table if it doesn't exist
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Optional: Insert some sample users (remove or adjust as needed)
INSERT INTO users (username, email, password)
VALUES
    ('John Doe', 'john.doe@example.com', 'securepassword123'),
    ('Jane Smith', 'jane.smith@example.com', 'mypassword456');
