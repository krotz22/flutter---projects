const express =require('express');

const body_parser = require('body-parser');

const userRouter = require('./routers/user.routers');
const TodoRouter = require('./routers/todo.routers');

const app =express();

//app.use(body_parser.json());

// Middleware for parsing JSON
app.use(express.json());  // ✅ This must be present
app.use(express.urlencoded({ extended: true })); 

app.use('/',userRouter);
app.use('/',TodoRouter);

module.exports=app;