import express from 'express';
import colors from 'colors';
import morgan from 'morgan';
import dotenv from 'dotenv';
import connectDB from './src/db/mongoose.js';
import route from './src/routes/userRoute.js'



dotenv.config();
connectDB();



const app= express();
app.use(express.json());
app.use(morgan('dev'));
app.use(route);




const PORT=process.env.PORT||4000;
app.listen(PORT,()=>{
    console.log(`Server is running on ${PORT}`.bgCyan.white);
})