const ToDoServices = require ("../service/todo.services");

exports.createTodo = async (req,res,next)=>{
    try {
        const {userId,title,desc} =req.body;
        let todo = await ToDoServices.createTodo(userId,title,desc);

        res.json({status: true,success:todo});

    } catch (error) {
        next(error);
    }
}
exports.getTodo = async (req,res,next)=>{
    try {
        const {userId} =req.body;
        let todo = await ToDoServices.getTodo(userId);

        res.json({status: true,success:todo});

    } catch (error) {
        next(error);
    }
}
exports.deleteTodo = async (req,res,next)=>{
    try {
        const {id} =req.body;
        let deleted = await ToDoServices.delTodo(id);

        res.json({status: true,success:deleted});

    } catch (error) {
        next(error);
    }
}