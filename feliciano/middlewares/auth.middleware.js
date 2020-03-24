var express = require('express');
var sql = require('mssql');
    var cofig = {
        user: 'SA',
        password: 'Dockersql123',
        server: 'localhost', 
        database: 'DTPBook' 
    }; 
    
module.exports.requireAuth = function(req, res, next){
    
    if(!req.cookies.UsersID){
        res.redirect('/home/login');
        return;
    }

    sql.connect(cofig, function(err){
        if(err) throw err;
        var request = new sql.Request();

        var CheckUser = "SELECT IDND FROM NguoiDung WHERE IDND = "+req.cookies.UsersID;
        request.query(CheckUser, function(err, result){
            if(result.recordset.length.valueOf() == 0){
                res.redirect('/home/login');
                return;
            }
            res.locals.user = result.recordset.IDND;
        });
    });
    
    next();
};