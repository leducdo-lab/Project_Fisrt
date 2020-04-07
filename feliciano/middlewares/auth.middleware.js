var express = require('express');
var sql = require('mssql');
    var config = {
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

    sql.connect(config, function(err){
        if(err) throw err;
        sql.close();
        var CheckUser = "SELECT IDND FROM NguoiDung WHERE IDND = "+req.cookies.UsersID;
        new sql.Request().query(CheckUser, function(err, result){
            if(result.recordset.length.valueOf() == 0){
                res.redirect('/home/login');
                return;
            } 

            res.locals.user = result.recordset.IDND;
        });
    });
    
    next();
};

module.exports.NewBook = function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var SL = "SELECT * FROM Sach WHERE IDSach IN ( SELECT TOP(4) IDSach FROM SachDaMua GROUP BY IDSach ORDER BY COUNT(SoLuong) DESC )";

        new sql.Request().query(SL, function(err, result){
            if(err) throw err;
            var datas = result.recordset;
            var pages = parseInt(req.query.page) || 1; // n
            var perPage = 6; // x

            var start = (pages -1) * perPage;
            var end = pages * perPage;

            var SLBook = "SELECT TOP(12) IDSach,TenSach,Gia,TacGia FROM Sach ORDER BY NgayUp DESC";
            new sql.Request().query(SLBook, function(err, result){
                sql.close();
                if(err) throw err;
                else{
                    res.render('index',{
                        datas : datas,
                        data : result.recordset.slice(start, end),
                        user : req.cookies.UsersID,
                        page : pages
                    });
                }
            });
        });
    });
};

module.exports.MAXBook = function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var SL = "SELECT * FROM Sach WHERE IDSach IN ( SELECT TOP(4) IDSach FROM SachDaMua GROUP BY IDSach ORDER BY COUNT(SoLuong) DESC )";

        new sql.Request().query(SL, function(err, result){
            if(err) throw err;
            var datas = result.recordset;
            var pages = parseInt(req.query.page) || 1; // n
            var perPage = 6; // x

            var start = (pages -1) * perPage;
            var end = pages * perPage;

            var SLBook = "SELECT TOP(12) IDSach,TenSach,Gia,TacGia FROM Sach ORDER BY NgayUp DESC";
            new sql.Request().query(SLBook, function(err, result){
                sql.close();
                if(err) throw err;
                else{
                    res.render('index',{
                        datas : datas,
                        data : result.recordset.slice(start, end),
                        user : req.cookies.UsersID,
                        page : pages
                    });
                }
            });
        }); 
    });
};