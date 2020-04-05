var express = require('express');

var authMiddleware = require('../middlewares/auth.middleware');
var menuRouter = require('./menu.router');

var router = express.Router();

var controller = require('../controllers/auth.controller');

router.use('/menu1',menuRouter);
router.get('/Login/contact',controller.login); 

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

router.get('/', function(req, res, next){
    
    sql.connect(config, function(err){
        if(err) throw err;
        var SL = "SELECT * FROM Sach WHERE IDSach IN ( SELECT TOP(4) IDSach FROM SachDaMua GROUP BY IDSach ORDER BY COUNT(SoLuong) DESC )";

        new sql.Request().query(SL, function(err, result){
            sql.on('err',err =>{
                console.log(err);
            });
            if(err) throw err;
            else{
                res.render('Home/index',{
                    datas : result.recordset,
                    user: req.cookies.UsersID
                });
            }
        });
    });
});

router.get('/new', function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;

        var pages = parseInt(req.query.page) || 1; // n
        var perPage = 6; // x

        var start = (pages -1) * perPage;
        var end = pages * perPage;

        var SLBook = "SELECT TOP(12) IDSach,TenSach,Gia,TacGia FROM Sach ORDER BY NgayUp DESC";
        new sql.Request().query(SLBook, function(err, result){
            sql.close();
            if(err) throw err;
            else{
                res.render('Home/index',{
                    data : result.recordset.slice(start, end),
                    user : req.cookies.UsersID,
                    page : pages
                });
            }
        });
    });
});

router.get('/book', function(req,res, next){
    sql.connect(config, function(err){
        if(err) throw err;

        var q = req.query.book;
        var Book = "SELECT * FROM Sach WHERE IDSach = '"+q+"'";

        new sql.Request().query(Book, function(err, result){
            if(err) throw err;
            res.render('Book/book',{
                book : result.recordset,
                dataHome: 'dataHome'
            });
        });
    });
});

router.post('/book',function(req, res, next){
    if(!req.cookies.UsersID){
        res.redirect('/home/login');
        return;
    }
});

router.get('/search', function(req, res,next){
    sql.connect(config, function(err){
        if(err) throw err;
        if(err) throw err;
        var pages = parseInt(req.query.page) || 1;
        var perPage = 6; // x

        var start = (pages -1) * perPage;
        var end = pages * perPage;
        var q = req.query.q;
        
        var SL = "SELECT * FROM Sach WHERE TenSach LIKE N'%"+q+"%'";

        new sql.Request().query(SL, function(err, result){
            
            if(err) throw err;
            sql.close();
            var pg;
            if(result.recordset.length % perPage == 0){
                pg = parseInt(result.recordset.length / perPage);
            }
            if(result.recordset.length % perPage != 0){
                pg = parseInt(result.recordset.length / perPage) + 1;
            }

            if(result.recordset.length == 0){
                res.render('Home/index',{
                    errorSearch : 'Không có sách này'
                });
                return;
            }
            res.render('Home/index',{
                dataSearch : result.recordset.slice(start,end),
                pages : pg,
                pg : pages,
                q : q
            });
        });
    });
});

router.get('/login', function(req, res){
    res.render('Login/contact');
});

router.get('/login/register', function (req, res) {
    res.render('Login/register');
});

router.get('/login/forgot', function(req, res){
    res.render('Login/forgot');
});

router.post('/login/register', function(req, res){
    
    sql.connect(config, function(err){
        if(err) throw err;
        var email = req.body.email;
        var password = req.body.password;
        var name = req.body.name;
        var date = req.body.date;
        var map = req.body.Map;
        var phone = req.body.Phone;
        var gioitinh = req.body.gioitinh;
        if(gioitinh == "nam") gioitinh = 0;
        if(gioitinh == "nữ") gioitinh = 1;
    
        var SLemail = "SELECT TenDN FROM NguoiDung WHERE TenDN = '"+email+"'";
        new sql.Request().query(SLemail, function(err, result){
            console.log(result.recordset);
            
            if(err) throw err;
            if(result.recordset[0] == undefined){
                var insert = "INSERT INTO NguoiDung VALUES('"+email+"','"+password+"',N'"+name+"','"+gioitinh+"','"+date+"','"+map+"','"+phone+"')";
                new sql.Request().query(insert, function(err, result){
                    if(err) throw err;
                    sql.close();
                    console.log("1 record inserted");
                    res.redirect('/home/login');        
                });
            }else{ 
                res.render('Login/register',{
                    errors : 'Email is failse',
                    values: req.body
                });
                return;
            }
        });
    });  
});

router.post('/login', function(req, res){

    sql.connect(config, function(err){
        if(err) throw err;
        var a = 0;
        
        var email = req.body.email;
        var password = req.body.password;
        var CheckUser = "SELECT IDND,TenDN,MatKhau FROM NguoiDung WHERE TenDN = '"+email+"' AND MatKhau = '"+password+"'";
        
        new sql.Request().query(CheckUser, function(err, result){
            if(err) throw err; 
            
            if(result.recordset.length != 0){
                
                if(result.recordset[0].TenDN.toString() != email){
                    res.render('Login/contact',{
                        errors: 'Tài Khoản hoặc Mật Khẩu bị sai',
                        values: req.body
                    });
    
                    return;
                }
                
                if(result.recordset[0].MatKhau.toString() != password)
                {
                    res.render('Login/contact',{
                        errors: 'Tài Khoản hoặc Mật Khẩu bị sai',
                        values: req.body
                    });
    
                    return;
                }
                var addmin = "SELECT * FROM QuanTri WHERE IDND = "+result.recordset[0].IDND;
                new sql.Request().query(addmin, function(err, result){
                    sql.close();
                    if(err) throw err;
                    if(result.recordset.length == 0){
                        res.cookie('UsersID',result.recordset[0].IDND);
                        res.redirect('/users');
                    }
                    res.cookie('UsersID',result.recordset[0].IDND);
                    res.redirect('/addmin');
                });
                
            }
            
            if(result.recordset.length == 0){
                res.render('Login/contact',{
                    errors: 'Tài Khoản hoặc Mật Khẩu bị sai',
                    values: req.body
                });
                return;
            }
        });
    });
});

module.exports = router;