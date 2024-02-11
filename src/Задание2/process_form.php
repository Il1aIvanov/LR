<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$comment = $_POST['comment'];
$fullName = $_POST['fullName'];
$address = $_POST['address'];
$email = $_POST['email'];
$phone = $_POST['phone'];

if ( empty($fullName) || empty($phone)) {
    echo "Пожалуйста, заполните все обязательные поля";
} else if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo "Пожалуйста, введите корректный адрес электронной почты";
} else if (!preg_match("/^\+\d\(\d{3}\)\d{3}-\d{2}-\d{2}$/", $phone)) {
    echo "Пожалуйста, введите корректный номер телефона:";
} else {
    $emailParts = explode('@', $email);
    $domain = $emailParts[1];
 
    if ($domain === 'gmail.com') {
        echo "Регистрация с почтовым адресом gmail.com невозможна";
    } else {
        $host = 'host_name';
        $dbname = 'database_name';
        $username = 'your_username';
        $password = 'your_password';
        
        $dsn = "pgsql:host=$host;dbname=$dbname";
        $pdo = new PDO($dsn, $username, $password);
        try {
            $stmt = $pdo->prepare('INSERT INTO persons (personComment, fullName, address, email, phone) VALUES (:personComment, :fullName, :address, :email, :phone)');
            $success = $stmt->execute(['personComment' => $comment, 'fullName' => $fullName, 'address' => $address, 'email' => $email, 'phone' => $phone]);
        
            if ($success) {
                echo "Форма успешно отправлена! Мы свяжемся с вами в ближайшее время.";
            } else {
                echo "Ошибка при добавлении записи в базу данных: " . implode(", ", $stmt->errorInfo());
            }
        } catch (PDOException $e) {
            echo "Ошибка подключения к базе данных: " . $e->getMessage();
        }
    }
}