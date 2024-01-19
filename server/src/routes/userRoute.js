import express from 'express';
import { loginController, registerController,getUserData} from '../controllers/userController.js';
import authMiddle from '../middlewares/authMiddleware.js';

const router=express.Router();


router.post("/user/login",loginController);
router.post("/user/register",registerController);
router.get("/user/getUserData",authMiddle,getUserData);

export default router;