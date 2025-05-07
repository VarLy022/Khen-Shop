const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const shoesRoutes = require('./routes/shoes'); // Import shoes routes
const usersRoutes = require('./routes/users'); // Import users routes
const otpRoutes = require('./routes/otp');

const app = express();
const port = 3000;

// use cors
app.use(cors());
// app.use(cors({
//   origin: ['http://localhost:1234', 'http://172.0.0.1:3000']
// }));
// Middleware to parse JSON data
app.use(bodyParser.json());

// Routes
app.use('/shoes', shoesRoutes); // Shoes routes
app.use('/users', usersRoutes); // Users routes
app.use('/otp', otpRoutes);

app.listen(port, () => {
  console.log(`✅ Server running on http://localhost:${port}`);
});
