const UserServices = require ("../service/user.services");
//sign up 
exports.register = async (req, res, next) => {
    try {
        console.log("Received Headers:", req.headers);  
        console.log("Received Body:", req.body);  

        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ status: false, error: "Email and password are required" });
        }

        const successRes = await UserServices.registerUser(email, password);
        res.json({ status: true, success: "User registered", user: successRes });
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: false, error: error.message });
    }
};


//sign in 
exports.login= async(req,res,next)=>{
    try{
        const {email,password} =req.body;
        //console.log(email,password)
        const user= await UserServices.checkUser(email);
        
        if (!user){
            throw new Error('user dont exist');
        }
        const  ismatch =await user.comparePassword(password);

        if (ismatch === false) {
            throw new Error ('Password Invalid');
        }

        let tokenData ={_id:user._id,email:user.email };

        const token = await UserServices.generateToken(tokenData,"keera","1h");
        res.status(200).json({status:true,token:token})
    }catch(error){
        throw error;
    }
}