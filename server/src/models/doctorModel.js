import mongoose from 'mongoose';
const doctorSchema =new mongoose.Schema({
name:{
    type:String,
    required:true,
},
userId:{
    type:String,
},
phone:{
    type:String,
    required:true,
},
email:{
    type:String,
    required:true,
},
address:{
    type:String,
    required:true,
},
status:{
    type:String,default:"pending",
},
specialization:{
    type:String,
    required:true,
},
exprience:{
    type:String,
    required:true,
},
fees:{
    type:Number,
    required:true,
},
timming:{
    type:Object,
    required:true,
}
},{timestamps: true,}
)
const Doctor=mongoose.model("doctor",doctorSchema);
export default Doctor;