<?php
include 'condb.php';

$action = $_POST['action'] ?? null;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $action) {
    switch($action) {

        // 🧩 เพิ่มพนักงานใหม่
        case 'add':
            $firstname = $_POST['firstname'];
            $lastname = $_POST['lastname'];
            $username = $_POST['username'];
            $password = password_hash($_POST['password'], PASSWORD_DEFAULT); // เข้ารหัสรหัสผ่าน

            // อัพโหลดไฟล์รูป
            $filename = null;
            if (isset($_FILES['image']) && $_FILES['image']['error'] === 0) {
                $targetDir = "uploads/";
                if (!is_dir($targetDir)) {
                    mkdir($targetDir, 0777, true);
                }
                $filename = time() . '_' . basename($_FILES['image']['name']);
                $targetFile = $targetDir . $filename;
                move_uploaded_file($_FILES['image']['tmp_name'], $targetFile);
            }

            $sql = "INSERT INTO employees (firstname, lastname, username, password, image)
                    VALUES (:firstname, :lastname, :username, :password, :image)";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':firstname', $firstname);
            $stmt->bindParam(':lastname', $lastname);
            $stmt->bindParam(':username', $username);
            $stmt->bindParam(':password', $password);
            $stmt->bindParam(':image', $filename);

            if ($stmt->execute()) {
                echo json_encode(["message" => "เพิ่มพนักงานสำเร็จ"]);
            } else {
                echo json_encode(["error" => "เพิ่มพนักงานล้มเหลว"]);
            }
            break;

        // 🧩 แก้ไขข้อมูลพนักงาน
        case 'update':
            $employee_id = $_POST['employee_id'];
            $firstname = $_POST['firstname'];
            $lastname = $_POST['lastname'];
            $username = $_POST['username'];
            $password = !empty($_POST['password']) ? password_hash($_POST['password'], PASSWORD_DEFAULT) : null;

            // ตรวจสอบว่ามีการอัพโหลดรูปใหม่หรือไม่
            if (isset($_FILES['image']) && $_FILES['image']['error'] === 0) {
                $targetDir = "uploads/";
                if (!is_dir($targetDir)) {
                    mkdir($targetDir, 0777, true);
                }
                $filename = time() . '_' . basename($_FILES['image']['name']);
                $targetFile = $targetDir . $filename;
                move_uploaded_file($_FILES['image']['tmp_name'], $targetFile);
                $imageSQL = ", image = :image";
            } else {
                $imageSQL = "";
            }

            // ถ้ามีการเปลี่ยนรหัสผ่าน ให้เพิ่มใน SQL
            $passwordSQL = $password ? ", password = :password" : "";

            $sql = "UPDATE employees SET 
                        firstname = :firstname,
                        lastname = :lastname,
                        username = :username
                        $passwordSQL
                        $imageSQL
                    WHERE employee_id = :employee_id";
            $stmt = $conn->prepare($sql);

            $stmt->bindParam(':firstname', $firstname);
            $stmt->bindParam(':lastname', $lastname);
            $stmt->bindParam(':username', $username);
            $stmt->bindParam(':employee_id', $employee_id);

            if ($password) $stmt->bindParam(':password', $password);
            if (isset($filename)) $stmt->bindParam(':image', $filename);

            if ($stmt->execute()) {
                echo json_encode(["message" => "แก้ไขข้อมูลพนักงานสำเร็จ"]);
            } else {
                echo json_encode(["error" => "แก้ไขข้อมูลพนักงานล้มเหลว"]);
            }
            break;

        // 🧩 ลบพนักงาน
        case 'delete':
            $employee_id = $_POST['employee_id'];
            $stmt = $conn->prepare("DELETE FROM employees WHERE employee_id = :employee_id");
            $stmt->bindParam(':employee_id', $employee_id);
            if ($stmt->execute()) {
                echo json_encode(["message" => "ลบพนักงานสำเร็จ"]);
            } else {
                echo json_encode(["error" => "ลบพนักงานล้มเหลว"]);
            }
            break;

        default:
            echo json_encode(["error" => "Action ไม่ถูกต้อง"]);
            break;
    }

} else {
    // 🧩 ดึงข้อมูลพนักงานทั้งหมด
    $stmt = $conn->prepare("SELECT employee_id, firstname, lastname, username, image FROM employees ORDER BY employee_id DESC");
    if ($stmt->execute()) {
        $employees = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(["success" => true, "data" => $employees]);
    } else {
        echo json_encode(["success" => false, "data" => []]);
    }
}
?>
