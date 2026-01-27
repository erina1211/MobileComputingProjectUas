<?php
// ================== DB ==================
require_once "../config/cors.php";
require_once "../config/database.php";

// ================== INPUT ==================
$data = json_decode(file_get_contents("php://input"), true);

$id          = $data['id'] ?? null;
$name        = $data['name'] ?? '';
$price       = $data['price'] ?? 0;
$description = $data['description'] ?? '';

if (!$id) {
    echo json_encode(['success' => false, 'message' => 'ID required']);
    exit;
}

// ================== QUERY ==================
$query = "UPDATE menus SET name=?, price=?, description=? WHERE id=?";
$stmt  = $conn->prepare($query);
$stmt->bind_param("sisi", $name, $price, $description, $id);

$success = $stmt->execute();

echo json_encode([
    'success' => $success
]);
