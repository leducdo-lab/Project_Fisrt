var express = require('express');

var authMiddleware = require('../middlewares/auth.middleware');

var router = express.Router();

var controller = require('../controllers/auth.controller');

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

router.get('/',authMiddleware.requireAuth, function(req, res){
    sql.connect(config, function(err){
        if(err) throw err;
        var request = new sql.Request();
        var SLBook = "SELECT TOP(6) IDSach,TenSach,Gia,TacGia FROM Sach ORDER BY NgayUp DESC";

        request.query(SLBook, function(err, result){
            if(err) throw err;
            else{
                res.render('Home/index',{
                    data : result.recordset
                });
            }
        });
        
    });
    res.render('Home/index');
});

router.get('/search', function(req, res){
    
});

router.get('/login', function(req, res){
    res.render('Login/contact');
});

router.get('/menu',authMiddleware.requireAuth ,function(req, res){
    res.render('Menu/menu');
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
        var request = new sql.Request();
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
        request.query(SLemail, function(err, result){
            if(err) throw err;
            if(result.output.TenDN == null){
                var insert = "INSERT INTO NguoiDung VALUES('"+email+"','"+password+"',N'"+name+"','"+gioitinh+"','"+date+"','"+map+"','"+phone+"')";
                request.query(insert, function(err, result){
                    if(err) throw err;
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
        var request = new sql.Request();
        var email = req.body.email;
        var password = req.body.password;
        var CheckUser = "SELECT IDND,TenDN,MatKhau FROM NguoiDung WHERE TenDN = '"+email+"' AND MatKhau = '"+password+"'";
        
        request.query(CheckUser, function(err, result){
            if(err) throw err; 

            if(result.recordset.length.valueOf() != 0){
                
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

                res.cookie('UsersID',result.recordset[0].IDND);
                res.redirect('/users');
            }
            
            if(result.recordset.length.valueOf() == 0){
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