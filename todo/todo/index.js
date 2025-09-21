const app = require('./app')
const db = require('./config/db.js')
const  UserModel =require('./models/user.model.js')

app.get('/',(req,res)=>
{
    res.send("hellognjkhkoo");
}
);
const port = 3000;
 app.listen(port,()=>{
    console.log(`Server Listening on port http://localhost:${port}`);
 }

 

);