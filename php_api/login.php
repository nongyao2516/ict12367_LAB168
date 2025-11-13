<?php
include 'condb.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['username']) || !isset($data['password'])) {
    echo json_encode([
        "success" => false,
        "message" => "Invalid input data."
    ]);
    exit;
}

$username = trim($data['username']);
$password = trim($data['password']);

try {

    // ดึงข้อมูล user ตาม username เพียงอย่างเดียว
    $stmt = $conn->prepare("SELECT employee_id, username, password, status FROM employees WHERE username=? LIMIT 1");
    $stmt->execute([$username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password'])) {

        echo json_encode([
            "success" => true,
            "message" => "Login successful",
            "user" => [
                "id" => $user['employee_id'],
                "username" => $user['username'],
                "status" => $user['status'],
               
            ]
        ]);

    } else {
        echo json_encode([
            "success" => false,
            "message" => "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"
        ]);
    }

} catch (PDOException $e) {
    echo json_encode([
        "success" => false,
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
