import mongoose from 'mongoose';
import bcrypt from 'bcryptjs';
import validator from 'validator';
import  jwt from 'jsonwebtoken';

const userScema=mongoose.Schema({
    name:{
        type:String,
        required:true,
    },
    email:{
        type:String,
        required:true,
        unique:true,
        validate(value){
            if(!validator.isEmail(value))
            {
                throw console.error("please enter a valid error".bgRed.white);
            }
        }
    },
    password:{
        type:String,
        required:true,
    },
    isAdmin:{
        type:Boolean,
        default:false
    },
    isDoctor:{
        type:Boolean,
        default:false
    },
    notifications:{
        type:Array,
        default:[],
    },
    seenNotifications:{
        type:Array,
        default:[],
    },
    tokens:[{
        token:{
            type:String,
            required:true,
        }
    }]
});
userScema.pre("save",async function(next){
const user=this;
if(user.isModified("password"))
{
    user.password=await bcrypt.hash(user.password,10);
}
next();
});
userScema.methods.generateToken=async function()
{
    const user=this;
    const token=jwt.sign({_id:user._id.toString()},process.env.TOKEN_ID);
    user.tokens=user.tokens.concat({token});
    await user.save();
    return token; 
}
userScema.methods.toJSON= function()
{
    const user=this;
    const userObject=user.toObject();
    delete userObject.password;
    delete userObject.tokens;
    return userObject;
}
const User=mongoose.model("User",userScema);
export default User;