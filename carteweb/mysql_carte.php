<?php
const MYSQL_HOST = 'localhost';
const MYSQL_PORT = 3306;
const MYSQL_NAME = 'My_map';
const MYSQL_USER = 'root';
const MYSQL_PASSWORD = '';
try {
    $db = new PDO(
        sprintf(
            'mysql:host=%s;dbname=%s;port=%s;charset=utf8',
            MYSQL_HOST,
            MYSQL_NAME,
            MYSQL_PORT
        ),
        MYSQL_USER,
        MYSQL_PASSWORD,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (Exception $exception) {
    die('Erreur : ' . $exception->getMessage());
}
?>