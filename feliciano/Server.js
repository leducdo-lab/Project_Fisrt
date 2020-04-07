var express = require('express');

var authMiddleware = require('./middlewares/auth.middleware'); 
var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser'); 
var HomeRouter = require('./routes/home.router');
var usersRouter = require('./routes/users.router');
var addminRouter = require('./routes/admin.router');


var app = express();
var port = 1225;
app.set('view engine', 'pug');
app.set('views', './views');

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(cookieParser());
app.use(express.static('public'));
app.use('/home',HomeRouter);
app.use('/users',usersRouter);
app.use('/addmin',addminRouter);

//var Connection = require('./connect/database');

var sql = require('mssql');
var config = {
        user: 'SA',
        password: 'Dockersql123',
        server: 'localhost', 
        database: 'DTPBook',
        options: {
            encrypt: true 
        },
        pool: {
            max: 10,
            min: 0,
            idleTimeoutMillis: 100000
        }
};

app.get('/',authMiddleware.MAXBook);

app.get('/new',authMiddleware.NewBook);

app.get('/menu',function(req, res, next){
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
                res.render('menu',{
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

app.get('/book', function(req,res, next){
    sql.connect(config, function(err){
        if(err) throw err;

        var q = req.query.book;
        var Book = "SELECT * FROM Sach WHERE IDSach = '"+q+"'";

        new sql.Request().query(Book, function(err, result){
            if(err) throw err;
            res.render('Book/book',{
                book : result.recordset,
                dataServer : 'dataServer'
            });
        });
    });
});

app.post('/book', function(req, res, next){
    if(!req.cookies.UsersID){
        res.redirect('/home/login');
        return;
    }
});

app.get('/qltv', function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var selectTV = "SELECT * FROM NguoiDung";
        var page = parseInt(req.query.page) || 1;
        var selectADmin = "SELECT * FROM QuanTri";
        
        new sql.Request().query(selectTV, function(err, result){    
            var pg;
            if(result.recordset.length % 8 == 0){
                pg = parseInt(result.recordset.length / 8);
            }
            if(result.recordset.length % 8 != 0){
                pg = parseInt(result.recordset.length / 8) + 1;
            }
            if(err) throw err;
            var thanhVien = result.recordset;
            new sql.Request().query(selectADmin, function(err, result){
                if(err) throw err;
                var Admin = result.recordset;
                for(var x = 0; x < thanhVien.length; x++){
                    for(var y = 0; y < Admin.length; y++){
                        if(thanhVien[x].IDND == Admin[y].IDND){
                            thanhVien[x].DiaChi = "Admin";
                        }
                    }
                }
                res.render('QLTV',{
                    TV : thanhVien,
                    slg : pg,
                    page : page
                });
            });
        });
    });
});

app.get('/suatv',function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var SelectTv = "SELECT * FROM NguoiDung WHERE IDND = "+parseInt(req.query.tv);

        new sql.Request().query(SelectTv, function(err, result){
            if(err) throw err;
            res.render('SuaQuyen',{
                TV : result.recordset
            });
        });
    });
});

app.post('/suatv',function(req, res, next){
    
    sql.connect(config,function(err){
        if(err) throw err;

        if(req.body.user_data.quyen == 'Member'){
            var IDND = req.body.user_data.id;
            var Delete = "DELETE FROM QuanTri WHERE IDND = "+IDND;
            new sql.Request().query(Delete, function(err, result){
                if(err) throw err;
                res.redirect('/qltv');
            });
        }
        if(req.body.user_data.quyen == 'Admin'){
            var IDND = req.body.user_data.id;
            var Insert = "INSERT INTO QuanTri VALUES("+IDND+")";
            new sql.Request().query(Insert, function(err, result){
                if(err) throw err;
                res.redirect('/qltv');
            });
        }
    });
});

app.get('/deletetv',function(req, res){
    
    sql.connect(config, function(err){
        if(err) throw err;
        var Delete = "DELETE FROM NguoiDung WHERE IDND ="+req.query.tv;
        new sql.Request().query(Delete, function(err, result){
            if(err) throw err;
            res.redirect('/qltv');
        });
    });
});


app.get('/qlybook', function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;

        var pages = parseInt(req.query.page) || 1; // n
        var perPage = 10; // x

        var start = (pages -1) * perPage;
        var end = pages * perPage;
        var QLY = "SELECT Sach.IDSach,TenSach, Name,TacGia,NhaXB,NgayXB,SoLuong,Gia FROM Sach JOIN LoaiSach\n"+
        "ON Sach.IDSach = LoaiSach.IDSach\n"+
        "JOIN TheLoai \n"+
        "ON LoaiSach.IDLoai = TheLoai.IDLoai\n "

        new sql.Request().query(QLY, function(err, result){
            if(err) throw err;
            var pagez = result.recordset.length / perPage;
            res.render('quanlybook',{
                data : result.recordset.slice(start, end),
                page : pagez,
                pages : pages
            });
        });
    });
    
});

app.get('/Suabook',function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var bookname = req.query.book;
        var bookName = "SELECT * FROM Sach WHERE TenSach LIKE N'"+bookname+"'";
        var date = new Date();
        
        new sql.Request().query(bookName, function(err, result){
            if(err) throw err;
            var dmy = result.recordset[0].NgayXB.split("-",3);
            
            res.render('Suabook',{
                data : result.recordset,
                ddmmyy : dmy,
                date : date.getFullYear()
            });
        });
    });
});

app.post('/Suabook', function(req, res, next){
    // console.log(req.body);
    sql.connect(config, function(err){
        if(err) throw err;
        var bookName = req.body.tensach;
        // var image = req.body.Anh;
        var date = req.body.user_data.ngay[0] +'-'+req.body.user_data.thang+'-'+req.body.user_data.nam;
        
        var soluong = req.body.soluong;
        var TacGia = req.body.Tacgia;
        var NhaXB = req.body.Nhaxuatban;
        var Gia = req.body.Giatien;

        var UPDATE = "UPDATE Sach SET TenSach = N'"+bookName+"',\n"+
        "NgayXB = '"+date+"',\n"+
        "TacGia = N'"+TacGia+"',\n"+
        "NhaXB = N'"+NhaXB+"',\n"+
        "SoLuong = "+parseInt(soluong)+",\n"+
        "Gia = "+parseInt(Gia)+"\nWHERE IDSach = '"+req.body.idsach+"'";
        
        new sql.Request().query(UPDATE, function(err, result){
            if(err) throw err;
            if(req.body.the_loai == 'Văn học'){
                req.body.the_loai = 1;
            }
            if(req.body.the_loai == 'Kỹ năng sống'){
                req.body.the_loai = 5;
            }
            if(req.body.the_loai == 'Tiểu thuyết'){
                req.body.the_loai = 6;
            }
            if(req.body.the_loai == 'Truyện tranh'){
                req.body.the_loai = 2;
            }
            if(req.body.the_loai == 'Văn hóa - Kinh tế'){
                req.body.the_loai = 3;
            }
            if(req.body.the_loai == 'Kiến thức tổng hợp'){
                req.body.the_loai = 4;
            }
            
            var updateTL = "UPDATE LoaiSach SET IDLoai ="+parseInt(req.body.the_loai)+" WHERE IDSach = '"+req.body.idsach+"'";
            new sql.Request().query(updateTL, function(err, result){
                if(err) throw err;
                res.redirect('/qlybook');
            })
            
        });
    })
});

app.get('/deleteBook',function(req, res, next){
    sql.connect(config, function(err){
        var deleteBook = "DELETE FROM Sach WHERE IDSach = '"+req.query.book+"'";
        new sql.Request().query(deleteBook, function(err, result){
            if(err) throw err;
            console.log("DELETE");
            res.redirect('/qlybook');
        });
    });
});

app.get('/addbook', function(req, res, next){
    res.render('addbook');
});

app.post('/addbook', function(req, res, next){
    
    sql.connect(config, function(err){
        if(err) throw err;
        var tensach = req.body.tensach;
        var theloai = req.body.user_data.ngay;
        var tacgia = req.body.Tacgia;
        var NXB  = req.body.Nhaxuatban;
        var NgayXB = req.body.Ngayxuatban;
        var Gia = req.body.Giatien;
        var SLg = req.body.soluong;
        var IDsach = req.body.IDSach;
        var Mota = req.body.Mota;
        var SLAnh = req.body.SLAnh;

        if(theloai == 'Văn học'){
            theloai = 1;
        }
        if(theloai == 'Kỹ năng sống'){
            theloai = 5;
        }
        if(theloai == 'Tiểu thuyết'){
            theloai = 6;
        }
        if(theloai == 'Truyện tranh'){
            theloai = 2;
        }
        if(theloai == 'Văn hóa - Kinh tế'){
            theloai = 3;
        }
        if(theloai == 'Kiến thức tổng hợp'){
            theloai = 4;
        }
        var Select1 = "SELECT * FROM Sach WHERE IDSach = '"+IDsach+"'";
        console.log(Select1);
        new sql.Request().query(Select1, function(err, result){
            console.log(result);
            if(result.rowsAffected[0] == 0){
                var insert1 = "INSERT INTO Sach(TenSach, IDSach, MoTa, Gia, NhaXB, TacGia, NgayXB,SoLuong,NgayUp,SoAnh)\n"+
                "VALUES (N'"+tensach+"','"+IDsach+"',N'"+Mota+"',"+Gia+",N'"+NXB+"','"+tacgia+"','"+NgayXB+"',"+SLg+",' ',"+SLAnh+")";
                console.log(insert1);
                new sql.Request().query(insert1, function(err, result){
                    if(err) throw err;
                    console.log("1 record inserted");
                });
                
                var insert2 = "INSERT INTO LoaiSach\n"+
                "VALUES ('"+IDsach+"',"+theloai+")";
                console.log(insert2);
                new sql.Request().query(insert2, function(err, result){
                    if(err) throw err;
                    console.log("1 record inserted");
                    res.redirect('/addbook'); 
                });
            }
        });
    });
});

app.get('/search', function(req, res){
    
    sql.connect(config, function(err){
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
                res.render('index',{
                    errorSearch : 'Không có sách này'
                });
                return;
            }
            res.render('index',{
                dataSearch : result.recordset.slice(start,end),
                pages : pg,
                pg : pages,
                q : q
            });
        });
    });
});

app.get('/qlyDon', function(req, res){
    if(!req.cookies.UsersID){
        res.redirect('/home/login');
        return;
    }
    sql.connect(config, function(err){
        if(err) throw err;
        var select = "SELECT l.MaDonHang,IDND,TongTien,TrangThai,c.SoLuong AS SL,c.TenSach"+
            " FROM LichSuMua AS l INNER JOIN ("+ "SELECT SachDaMua.SoLuong, TenSach, MaDonHang FROM SachDaMua INNER JOIN Sach"+
            " ON SachDaMua.IDSach = Sach.IDSach"+") AS c \n"+
            " ON c.MaDonHang = l.MaDonHang";
        new sql.Request().query(select, function(err, result){
            if(err) throw err;
            var dodai = result.recordset.length -1;
            var page = parseInt(req.query.page) || 1;
            var pg;
            var y=0;
            for(x=0;x<=result.recordset.length -1;x++){
                if(y<result.recordset[x].MaDonHang)
                    y=result.recordset[x].MaDonHang;
            }
            if(result.recordset[dodai].MaDonHang % 8 == 0){
                pg = parseInt(result.recordset[dodai].MaDonHang / 8);
            }
            if(result.recordset[dodai].MaDonHang % 8 != 0){
                pg = parseInt(result.recordset[dodai].MaDonHang / 8) + 1;
            }
            
            res.render('qlyDonHang',{
                DH : result.recordset,
                dodai : dodai,
                slg : pg,
                page : page,
                max : y
            });
        });
    });
});

app.get('/giohang', function(req, res, next){
    res.render('Book/GioHang');
});

app.listen(port, function () {
    console.log('Server is running..');
}); 