import jwt from 'jsonwebtoken';
import User from '../models/userModel.js'
const authMiddle=async(req,res,next)=>{
try {
    const token=req.header("Authorization").replace("Bearer ", "");
    const decoded=jwt.verify(token, process.env.TOKEN_ID);
    const user=await User.findOne({_id:decoded._id,"tokens.token":token});
    if(!user)
    {
        res.status(400).send({success:true,message:"Authorization failed"});
    }
    req.token=token;
    req.user=user;
    next();
} catch (error) {
    res.status(400).send({success:false,message:error.toString()});
}
}
export default authMiddle;