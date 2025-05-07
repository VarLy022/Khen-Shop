const express = require('express');
const router = express.Router();
const crypto = require('crypto');

// In-memory storage for OTPs (for development/testing ONLY - use a database like Redis in production)
const otpStorage = {};
const OTP_EXPIRATION_TIME = 300; // seconds (5 minutes)

// Replace with your actual SMS gateway integration (e.g., Twilio, Nexmo)
const sendSMS = (phoneNumber, otp) => {
    console.log(`Sending OTP "${otp}" to ${phoneNumber}`);
    // In a real application, you would use an SMS gateway API here
    return Promise.resolve({ success: true, message: 'SMS sent (simulated)' });
};

// Function to generate a random OTP
const generateOTP = (length = 6) => {
    return crypto.randomBytes(Math.ceil(length / 2)).toString('hex').slice(0, length);
};

// Route to send OTP
router.post('/send-otp', async (req, res) => {
    const { phone } = req.body;

    if (!phone) {
        return res.status(400).json({ success: false, message: 'ເບີໂທລະສັບແມ່ນຕ້ອງການ' });
    }

    const otp = generateOTP();
    const expirationTime = Date.now() + OTP_EXPIRATION_TIME * 1000;

    // Store the OTP in memory (INSECURE FOR PRODUCTION)
    otpStorage[phone] = { otp, expirationTime };

    try {
        const smsResult = await sendSMS(phone, otp);
        if (smsResult.success) {
            res.json({ success: true, message: 'ລະຫັດ OTP ໄດ້ຖືກສົ່ງໄປຫາເບີໂທລະສັບຂອງທ່ານແລ້ວ' });
        } else {
            res.status(500).json({ success: false, message: `ເກີດຂໍ້ຜິດພາດໃນການສົ່ງ SMS: ${smsResult.message}` });
        }
    } catch (error) {
        console.error('Error sending SMS:', error);
        res.status(500).json({ success: false, message: 'ເກີດຂໍ້ຜິດພາດໃນການສົ່ງ SMS' });
    }
});

// Route to verify OTP
router.post('/verify-otp', (req, res) => {
    const { phone, otp } = req.body;

    if (!phone || !otp) {
        return res.status(400).json({ success: false, message: 'ເບີໂທລະສັບ ແລະ ລະຫັດ OTP ແມ່ນຕ້ອງການ' });
    }

    const storedOTPData = otpStorage[phone];

    if (!storedOTPData) {
        return res.status(404).json({ success: false, message: 'ບໍ່ພົບ OTP ສຳລັບເບີໂທລະສັບນີ້' });
    }

    const { otp: storedOTP, expirationTime } = storedOTPData;
    const currentTime = Date.now();

    if (currentTime > expirationTime) {
        delete otpStorage[phone]; // Remove expired OTP
        return res.status(400).json({ success: false, message: 'ລະຫັດ OTP ໝົດອາຍຸແລ້ວ' });
    }

    if (otp === storedOTP) {
        delete otpStorage[phone]; // OTP verified, remove from storage
        res.json({ success: true, message: 'ຢືນຢັນລະຫັດ OTP ສຳເລັດແລ້ວ' });
    } else {
        res.status(400).json({ success: false, message: 'ລະຫັດ OTP ບໍ່ຖືກຕ້ອງ' });
    }
});

module.exports = router;
