import  mongoose from "mongoose";
import colors from "colors";


const connectDB=()=>{
try {
    mongoose.connect(process.env.DB_LINK)
    console.log(`connect successfull on ${process.env.DB_LINK} and host id ${mongoose.connection.host}`.bgGreen.white); 
} catch (error) {
    console.log(`error from mongodb connectin file ${error}`.bgRed.white);
}
}
export default connectDB;