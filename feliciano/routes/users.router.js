var express = require('express');
var authMiddleware = require('../middlewares/auth.middleware');
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
                res.render('users/index',{
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
                res.render('users/index',{
                    data : result.recordset.slice(start, end),
                    user : req.cookies.UsersID,
                    page : pages
                });
            }
        });
    });
});

router.get('/menu',function(req, res, next){
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
                res.render('users/menu',{
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

router.get('/search', function(req, res){
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
                res.render('users/index',{
                    errorSearch : 'Không có sách này'
                });
                return;
            }
            res.render('users/index',{
                dataSearch : result.recordset.slice(start,end),
                pages : pg,
                pg : pages,
                q : q
            });
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
                user : req.cookies.UsersID
            });
        });
    });
});

router.post('/book', function(req, res, next){
    
    if(!req.cookies.UsersID){
        res.redirect('/home/login');
        return;
    }
    sql.connect(config, function(err){
        if(err) throw err;
        var SoLuong = req.body.slg;
        var IDND = req.cookies.UsersID;
        var IDSach = req.body.id;
        var CheckSL = "SELECT SoLuong FROM Sach WHERE IDSach ='"+IDSach+"'";
        new sql.Request().query(CheckSL, function(err, result){
            if(err) throw err;
            if(SoLuong > result.recordset[0].SoLuong){
                res.render('Book/book',{
                    error : 'Khong du so luong trong kho'
                });
            }
            var ISRGH = "INSERT INTO GioHang \n VALUES ("+IDND+",'"+IDSach+"',"+SoLuong+")";
            new sql.Request().query(ISRGH, function(err, result){
                if(err) throw err;
                console.log('INSERT');
                res.redirect('/users/giohang');
            });
        });
    });
});

router.get('/UsersTK', function(req, res, next){
    
    sql.connect(config, function(err){
        if(err) throw err;
        
        var TK = "SELECT * FROM NguoiDung WHERE IDND = "+req.cookies.UsersID;
        
        
        new sql.Request().query(TK, function(err, result){
            
            if(err) throw err;
            var date = [result.recordset[0].NgaySinh.getDate(), result.recordset[0].NgaySinh.getMonth()+1,result.recordset[0].NgaySinh.getFullYear()];
            var dates = new Date();
            res.render('users/thanhvien',{
                data : result.recordset,
                date : date,
                dates : dates.getFullYear()
            });
        });
    });
});

router.post('/UsersTK',function(req, res, next){
    sql.connect(config, function(err){
        
        if(err) throw err;
        var Name = req.body.user_data.firstname;
        var Phone = req.body.user_data.phone;
        var DiaChi = req.body.user_data.diachi;
        var email = req.body.user_data.email;
        var pass1 = req.body.user_data.password1;
        var pass2 = req.body.user_data.password2;
        if(pass1 != pass2){
            res.render('users/thanhvien',{
                error : 'Hai mật khẩu khác nhau'
            });
        }
        var male =parseInt(req.body.user_data.render);
        if(req.body.user_data.thang >=1 && req.body.user_data.thang <= 9){
            req.body.user_data.thang = '0'+req.body.user_data.thang; 
        }
        if(req.body.user_data.ngay >= 1 && req.body.user_data.ngay <= 9){
            req.body.user_data.ngay = '0'+req.body.user_data.ngay;
        }
        var date = req.body.user_data.nam+req.body.user_data.thang+req.body.user_data.ngay;
        
        var UPDATE = "UPDATE NguoiDung SET Ten = N'"+Name+"',\n"+
        "TenDN = '"+email+"',\n"+"MatKhau = '"+pass1+"',\n"+
        "GioiTinh = "+male+",\n"+"NgaySinh = '"+date+"',\n"+
        "DiaChi = N'"+DiaChi+"',\n"+"Phone = '"+Phone+"'\n"+
        "WHERE IDND = "+req.cookies.UsersID;
        
        new sql.Request().query(UPDATE, function(err, result){
            console.log("UPDATE");
            res.redirect('/users/UsersTK');
        });
    });
});

router.get('/giohang', function(req, res, next){
    if(!req.cookies.UsersID){
        res.redirect('/home/login');
        return;
    }
    sql.connect(config, function(err){
        if(err) throw err;
        var GioHang = "SELECT  Sach.TenSach,Sach.IDSach,Sach.Gia,GioHang.SoLuong \n"+ 
        "FROM GioHang LEFT JOIN Sach \n"+
        "ON GioHang.IDSach = Sach.IDSach \n"+
        "WHERE IDND = " + req.cookies.UsersID;
        
        new sql.Request().query(GioHang, function(err, result){
            if(err) throw err;
            
            var SLSach = result.recordset.length;
            var Gia = 0;
            for(var x = 0; x < result.recordset.length; x++){
                Gia += parseInt(result.recordset[x].SoLuong) *parseFloat(result.recordset[x].Gia);
                
            }
            if(result.recordset.length != 0){
                res.render('Book/GioHang',{
                    GH : result.recordset,
                    SL : SLSach,
                    Gia : Gia
                });
            }
            if(result.recordset.length == 0){
                res.render('Book/GioHang');
            }
        });
    });
});

router.post('/giohang',function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var IDSach = req.body.baby;
        var DELETE = "DELETE FROM GioHang WHERE IDSach = '"+IDSach+"'";
        new sql.Request().query(DELETE, function(err){
            if(err) throw err;
            console.log("DELETE");
            res.redirect('/users/giohang');
        });
    });
});

router.get('/QlyDon',function(req, res, next){
    
    if(!req.cookies.UsersID){
        res.redirect('/home/login');
        return;
    }
    sql.connect(config, function(err){
        if(err) throw err;
        var select = "SELECT l.MaDonHang,IDSach,NgayMua,c.TenSach,c.SoLuong,TrangThai FROM LichSuMua AS l INNER JOIN ( \n"+
        "SELECT s.IDSach,s.MaDonHang,sa.TenSach,s.SoLuong FROM SachDaMua AS s INNER JOIN Sach AS sa \n"+
        "ON s.IDSach = sa.IDSach \n"+") AS c \n"+"ON l.MaDonHang = c.MaDonHang \n"+
        "WHERE IDND = "+req.cookies.UsersID;

        new sql.Request().query(select, function(err, result){
            if(err) throw err;
            var data = result.recordset;
            var date = [];


            if(result.recordset.length == 0){
                res.render('users/qlydonhang');
            }

            for(var x = 0; x < data.length; x++){
                date[x] = data[x].NgayMua.getDate().toString() +'-'+(data[x].NgayMua.getMonth() +1).toString()+'-'+data[x].NgayMua.getFullYear().toString();
            }
            console.log(date);
            res.render('users/qlydonhang',{
                DH : result.recordset,
                date : date
            });
        });
    })
});

router.get('/loginthanhtoan', function(req, res, next){
    res.render('users/loginthanhtoan');
});

router.get('/diachi', function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var ND = "SELECT * FROM NguoiDung WHERE IDND = "+req.cookies.UsersID;
        new sql.Request().query(ND, function(err, result){
            if(err) throw err;
            res.render('users/diachi',{
                ND : result.recordset
            })
        });
    });
});

router.post('/diachi',function(req, res){
    sql.connect(config, function(err){
        if(err) throw err;
        var ND = "SELECT * FROM NguoiDung WHERE IDND ="+req.body.user_data.idnd;
        new sql.Request().query(ND, function(err, result){
            var Ten = req.body.ten;
            var Phone = req.body.phone;
            var email = req.body.email;
            var address = req.body.b_address;
            var data = result.recordset;
            if(Ten != data[0].Ten || Phone != data[0].Phone || address != data[0].DiaChi){
                var update = "UPDATE NguoiDung SET Ten = N'"+Ten+"'\n"+
                "Phone = '"+Phone+"'\n"+"DiaChi = N'"+address+"'";
                new sql.Request().query(update, function(err, result){
                    if(err) throw err;
                    res.redirect('/users/thanhtoan');
                });
            }
            res.redirect('/users/thanhtoan');
        });
    });
});

router.get('/thanhtoan', function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var GioHang = "SELECT  Sach.TenSach,Sach.IDSach,Sach.Gia,GioHang.SoLuong \n"+ 
        "FROM GioHang LEFT JOIN Sach \n"+
        "ON GioHang.IDSach = Sach.IDSach \n"+
        "WHERE IDND = " + req.cookies.UsersID;
        new sql.Request().query(GioHang, function(err, result){
            if(err) throw err;
            
            var Gia = 0;
            for(var x = 0; x < result.recordset.length; x++){
                Gia += parseInt(result.recordset[x].SoLuong) *parseFloat(result.recordset[x].Gia);
            }

            res.render('users/thanhtoan2',{
                Gia : Gia,
                Book : result.recordset
            })
        });
    });
});

router.post('/thanhtoan',function(req, res){
    
});

router.get('/repassword', function(req, res){
    sql.connect(config, function(err){
        if(err) throw err;
        var select = "SELECT MatKhau FROM NguoiDung WHERE IDND = "+req.cookies.UsersID;

        new sql.Request().query(select, function(err, result){
            if(err) throw err;
            res.render('users/repassword',{
                pass : result.recordset
            });
        });
    });
});

router.post('/repassword', function(req, res){
    sql.connect(config, function(err){
        if(err) throw err;
        var id = req.cookies.UsersID;
        var pass1 = req.body.newpass1;
        var pass2 = req.body.newpass2;
        if(pass1 != pass2){
            res.render('users/repassword',{
                error : 'Mật khẩu mới không trùng nhau'
            });
        }
        var update = "UPDATE NguoiDung SET MatKhau = '"+pass1+"'\n"+
        "WHERE IDND = "+req.cookies.UsersID;
        new sql.Request().query(update, function(err, result){
            if(err) throw err;
            res.redirect('/users');
        });
    });
});

router.get('/clearCookie', function(req, res){   
    res.clearCookie("UsersID");
    res.redirect('/');
});



module.exports = router;