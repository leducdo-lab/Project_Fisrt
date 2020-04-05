var express = require('express');
var authMiddleware = require('../middlewares/auth.middleware');

var router = express.Router();

var sql = require('mssql');
var config = {
    user: 'SA',
    password: 'Dockersql123',
    server: 'localhost', 
    database: 'DTPBook',
    options: {
        encrypt: true 
    }
};

router.get('/',function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        
        var pages = parseInt(req.query.page) || 1;
        var page = parseInt(req.query.pg) || 1; // n
        var perPage = 8; // x

        var start = (page -1) * perPage;
        var end = page * perPage;
        var Sach = "SELECT * FROM Sach WHERE IDSach IN( SELECT IDSach FROM LoaiSach WHERE IDLoai = "+ pages+")";
        new sql.Request().query(Sach, function(err, result){
            sql.close();
            var pg;
            if(result.recordset.length % perPage == 0){
                pg = parseInt(result.recordset.length / perPage);
            }
            if(result.recordset.length % perPage != 0){
                pg = parseInt(result.recordset.length / perPage) + 1;
            }
            if(err) throw err;
            else{
                res.render('Home/menu',{
                    sach : result.recordset.slice(start, end),
                    user: req.cookies.UsersID,
                    page : pages,
                    pages : pg,
                    pg : page
                });
            }
        });
    });
});



module.exports = router;