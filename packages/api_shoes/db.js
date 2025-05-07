const mysql = require('mysql2');

// สร้าง connection กับฐานข้อมูล MySQL
const db = mysql.createConnection({
  host: '172.20.10.2',       // IP ของเครื่องที่รัน MySQL
  user: 'Anousa',            // ชื่อผู้ใช้
  password: '12345',         // รหัสผ่าน
  database: 'db_shoes_shop', // ชื่อฐานข้อมูล
  port: 3306                 // พอร์ต MySQL ปกติ
});

// เชื่อมต่อกับฐานข้อมูล
db.connect((err) => {
  if (err) {
    console.error("❌ ບໍ່ສາມາດເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້:", err.message);
    return;
  }
  console.log("✅ ເຊື່ອມຕໍ່ຖານຂໍ້ມູນໄດ້ແລ້ວ...");
});

module.exports = db;
