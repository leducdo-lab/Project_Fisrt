var express = require('express');

var cookieParser = require('cookie-parser'); 

var router = express.Router();
router.use(cookieParser());

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

router.get('/', function(req, res){
    sql.connect(config, function(err){
        if(err) throw err;
        var request = new sql.Request();
        var SLBook = "SELECT TOP(6) IDSach, Gia, TacGia FROM Sach ORDER BY NgayUp DESC";

        request.query(SLBook, function(err, result){
            if(err) throw err;
            res.render('users/index2',{
                data :result.recordset
            });
            sql.close();
            console.log(result.recordset.length);
        });
    });
});

router.get('/menu', function(req, res){
    res.render('users/menu');
});

router.get('/thongTin', function(req, res){

});

router.get('/clearCookie', function(req, res){
    var cookie = res.cookies.UsersID.toString();
    clearCookie(cookie);
    res.render('../views/index.pug');
});

module.exports = router;