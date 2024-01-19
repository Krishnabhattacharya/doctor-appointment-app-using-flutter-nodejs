import User from '../models/userModel.js'
import bcrypt from 'bcryptjs';
const loginController=async(req,res)=>{
try {
    const user=await User.findOne({email:req.body.email});
if(!user){
return res.status(200).send({success:false,message:"user not fount"});
}
const pasword= await bcrypt.compare(req.body.password,user.password);
if(!pasword)
{
    return res.status(200).send({success:false,message:"invaild details"});
}
const token=await user.generateToken();
res.status(200).send({success:true,message:"login successful",user,token});
} catch (error) {  
}
}

const registerController=async(req,res)=>{
const user=await new User(req.body);
try {
    await user.save();
    const token = await user.generateToken();
    console.log(token);
    res.status(201).send({success:true,message:"register successful",user,token});
} catch (error) {
    res.status(400).send({success:false,message:`error while signup ${error.message}`})
}
}
const getUserData=async(req,res)=>{
    const user=req.user;
res.send({success:true,user:user});
}
export {loginController,registerController,getUserData};