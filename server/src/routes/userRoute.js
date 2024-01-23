import express from 'express';
import { loginController, registerController, getUserData, applyDoctor, getallNotification, deleteAllNotification } from '../controllers/userController.js';
import authMiddle from '../middlewares/authMiddleware.js';


const router = express.Router();


router.post("/user/login", loginController);
router.post("/user/register", registerController);
router.get("/user/getUserData", authMiddle, getUserData);
router.post("/user/apply-doctor", authMiddle, applyDoctor);
router.post("/user/get-all-notification", authMiddle, getallNotification);
router.post("/user/delete-all-notification", authMiddle, deleteAllNotification);

export default router;