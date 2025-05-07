const express = require('express');
const db = require('../db'); // Import the database connection
const router = express.Router();

// 1. Show all shoes
router.get('/', (req, res) => {
  db.query('SELECT * FROM Shoes', (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    res.json(results);
  });
});

// ✅ Search shoes by ID, name, or brand
router.get('/:id', (req, res) => {
  const shoeId = req.params.id;
  const sql = `
    SELECT * FROM Shoes 
    WHERE 
      shoe_id LIKE ? OR 
      name LIKE ? OR 
      brand LIKE ?
  `;
  const searchValue = `%${shoeId}%`;

  db.query(sql, [searchValue, searchValue, searchValue], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    if (results.length === 0) {
      return res.status(404).json({ error: 'Shoe not found' });
    }
    res.json(results);
  });
});


// 3. Add a new shoe
router.post('/', (req, res) => {
  const { name, brand, price, stock, size, color, description, image_url } = req.body;
  const query = 'INSERT INTO Shoes (name, brand, price, stock, size, color, description, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
  db.query(query, [name, brand, price, stock, size, color, description, image_url], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    res.status(201).json({ message: 'Shoe added successfully', shoeId: results.insertId });
  });
});

// 4. Edit an existing shoe
router.put('/:id', (req, res) => {
  const shoeId = req.params.id;
  const { name, brand, price, stock, size, color, description, image_url } = req.body;
  const query = 'UPDATE Shoes SET name = ?, brand = ?, price = ?, stock = ?, size = ?, color = ?, description = ?, image_url = ? WHERE shoe_id = ?';
  db.query(query, [name, brand, price, stock, size, color, description, image_url, shoeId], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ error: 'Shoe not found' });
    }
    res.json({ message: 'Shoe updated successfully' });
  });
});

// 5. Delete a shoe
router.delete('/:id', (req, res) => {
  const shoeId = req.params.id;
  db.query('DELETE FROM Shoes WHERE shoe_id = ?', [shoeId], (err, results) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ error: 'Shoe not found' });
    }
    res.json({ message: 'Shoe deleted successfully' });
  });
});

module.exports = router;
