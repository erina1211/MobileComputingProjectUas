<?php
// ================== DB ==================
require_once "../config/database.php";
require_once "../config/cors.php";

// ================== INPUT ==================
$data = json_decode(file_get_contents("php://input"), true);
$id   = $data['id'] ?? null;

if (!$id) {
    echo json_encode(['success' => false, 'message' => 'ID required']);
    exit;
}

// ================== QUERY ==================
$query = "DELETE FROM menus WHERE id=?";
$stmt  = $conn->prepare($query);
$stmt->bind_param("i", $id);

$success = $stmt->execute();

echo json_encode([
    'success' => $success
]);
