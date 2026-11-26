<?php

header("Content-Type: application/json; charset=utf-8");

require_once __DIR__ . '/mysql_carte.php';

try {

    $map_id = isset($_GET["map_id"]) ? intval($_GET["map_id"]) : 1;

    $sql = "
        SELECT
            p.poi_id,
            p.name,
            p.description,
            p.position_X,
            p.position_Y,
            t.name AS type_name,
            t.color AS type_color,
            z.name AS zone_name

        FROM Points_of_Interest p

        JOIN POI_Types t
            ON p.poi_type_id = t.poi_type_id

        JOIN Map_Zones z
            ON p.zone_id = z.zone_id

        WHERE p.map_id = :map_id
    ";

    $stmt = $db->prepare($sql);

    $stmt->execute([
        ':map_id' => $map_id
    ]);

    $pois = $stmt->fetchAll();

    echo json_encode($pois, JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {

    http_response_code(500);

    echo json_encode([
        "error" => "Erreur lors de la récupération des POI"
    ]);
}