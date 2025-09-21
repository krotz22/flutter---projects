const mongoose= require('mongoose');

//connection to db

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/todoapp').on('open' ,()=>{
    console.log("db connected");
    
}).on('error',()=>{
    console.log("connection error");
    
});

module.exports = connection;