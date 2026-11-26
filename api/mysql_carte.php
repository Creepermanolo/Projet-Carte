<?php
const HOST = 'localhost';
const PORT = 3306;
const NAME = 'My_map';
const USER = 'root';
const PASSWORD = '';
try {
    $db = new PDO(
        sprintf(
            'mysql:host=%s;dbname=%s;port=%s;charset=utf8',
            HOST,
            NAME,
            PORT
        ),

        USER,
        PASSWORD,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );


    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

} catch (Exception $exception) {
    http_response_code(500);
    header('Content-Type: application/json');
    echo json_encode(["error" => "Erreur de connexion"]);
    exit;
}
?>