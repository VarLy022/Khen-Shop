const express = require('express');
const router = express.Router();
const db = require('../db'); // เชื่อมต่อฐานข้อมูล

// // ✅ Register user
// router.post('/register', (req, res) => {
//   const { name, email, password, phone } = req.body;
//   const sql = 'INSERT INTO Users (name, email, password, phone) VALUES (?, ?, ?, ?)';
//   db.query(sql, [name, email, password, phone], (err, result) => {
//     if (err) return res.status(500).json({ success: false, message: 'Error registering user' });
//     res.json({ success: true, message: 'User registered successfully' });
//   });
// });

// ✅ Register user
router.post('/register', (req, res) => {
  let { name, email, password, phone, role, user_image } = req.body;

  if (!role) {
    role = 'customer';
  }

  // First, check if the email or phone number already exists
  const checkSql = 'SELECT user_id, email, phone, user_image FROM Users WHERE email = ? OR phone = ?';
  db.query(checkSql, [email, phone], (checkErr, checkResult) => {
    if (checkErr) {
      return res.status(500).json({ success: false, message: 'Error checking for existing user' });
    }

    if (checkResult.length > 0) {
      // Email or phone number already exists
      let message = '';
      if (checkResult[0].email === email) {
        // message = 'Email address is already registered';
        message = 'ອີເມວນີ້ໄດ້ຖືກລົງທະບຽນແລ້ວ';
      } else if (checkResult[0].phone === phone) {
        // message = 'Phone number is already registered';
        message = 'ເບີໂທລະສັບນີ້ໄດ້ຖືກລົງທະບຽນແລ້ວ';
      } else {
        message = 'Email or phone number is already registered'; //should not happen, but for safety
      }
      return res.status(400).json({ success: false, message: message });
    }

    // If email and phone number are not already registered, proceed with insertion
    const insertSql = 'INSERT INTO Users (name, email, password, phone, role, user_image) VALUES (?, ?, ?, ?, ?, ?)';
    db.query(insertSql, [name, email, password, phone, role, user_image], (insertErr, insertResult) => {
      if (insertErr) {
        return res.status(500).json({ success: false, message: 'Error registering user' });
      }
      res.json({ success: true, message: 'User registered successfully' });
    });
  });
});

// ✅ Login user
router.post('/login', (req, res) => {
  const { email, password } = req.body;

  // First, check if the email exists
  const checkEmailSql = 'SELECT * FROM Users WHERE email = ?';
  db.query(checkEmailSql, [email], (emailErr, emailResults) => {
    if (emailErr) {
      return res.status(500).json({ success: false, message: 'Error during email check' });
    }

    if (emailResults.length === 0) {
      // Email not found
      return res.status(404).json({ success: false, message: 'ອີເມວບໍ່ພົບໃນລະບົບ' });
    }

    // Email found, now check the password
    const user = emailResults[0];
    if (user.password === password) { // In a real application, compare hashed passwords!
      res.json({
        success: true,
        message: 'ເຂົ້າສູ່ລະບົບສຳເລັດ',
        user: {
          id: user.user_id,
          name: user.name,
          email: user.email,
          role: user.role,
          image: user.user_image
        }
      });
    } else {
      // Incorrect password
      res.status(401).json({ success: false, message: 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ' });
    }
  });
});

// ✅ Show all users
router.get('/', (req, res) => {
  db.query('SELECT*FROM Users', (err, results) => {
    if (err) return res.status(500).json({ success: false, message: 'Error fetching users' });
    res.json(results);
  });
});

// ✅ Get one user by ID
router.get('/:id', (req, res) => {
  const id = req.params.id;
  db.query('SELECT user_id, name, email, password, phone, role, user_image FROM Users WHERE user_id = ?', [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ success: false, message: 'User not found' });
    }
    res.json(results[0]);
  });
});

// ✅ Update user
router.put('/:id', (req, res) => {
  const id = req.params.id;
  const { name, email, password, phone, role, user_image } = req.body;

  const sqlGet = 'SELECT * FROM Users WHERE user_id = ?';
  db.query(sqlGet, [id], (err, result) => {
    if (err) return res.status(500).json({ success: false, message: 'Error retrieving user' });
    if (result.length === 0) return res.status(404).json({ success: false, message: 'User not found' });

    const oldImage = result[0].user_image;

    // console.log("PUT user_id:", id);
    // console.log('Received Data:', req.body); // ✅ ตรวจดูว่าค่ามาครบ


    const sqlUpdate = `
      UPDATE Users SET name = ?, email = ?, password = ?, phone = ?, role = ?, user_image = ?
      WHERE user_id = ?
    `;
    db.query(
      sqlUpdate,
      [name, email, password, phone, role, user_image ?? oldImage, id],
      (err, result) => {
        if (err) return res.status(500).json({ success: false, message: 'Error updating user' });
        res.json({ success: true, message: 'User updated successfully' });
      }
    );
  });
});



// ✅ Delete user
router.delete('/:id', (req, res) => {
  const id = req.params.id;
  db.query('DELETE FROM Users WHERE user_id = ?', [id], (err, result) => {
    if (err) return res.status(500).json({ success: false, message: 'Error deleting user' });
    res.json({ success: true, message: 'User deleted successfully' });
  });
});

module.exports = router;
