var express = require('express');
var router = express.Router();

var controller = require('../controllers/auth.controller');

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
                    res.render('Admin/index',{
                        datas : datas,
                        data : result.recordset.slice(start, end),
                        user : req.cookies.UsersID,
                        page : pages
                    });
                }
            });
        }); 
    });
});

router.get('/qltv', function(req, res, next){
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
                res.render('Admin/QLTV',{
                    TV : thanhVien,
                    slg : pg,
                    page : page
                });
            });
        });
    });
});

router.get('/suatv',function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var SelectTv = "SELECT * FROM NguoiDung WHERE IDND = "+parseInt(req.query.tv);

        new sql.Request().query(SelectTv, function(err, result){
            if(err) throw err;
            res.render('Admin/SuaQuyen',{
                TV : result.recordset
            });
        });
    });
});

router.post('/suatv',function(req, res, next){
    
    sql.connect(config,function(err){
        if(err) throw err;

        if(req.body.user_data.quyen == 'Member'){
            var IDND = req.body.user_data.id;
            var Delete = "DELETE FROM QuanTri WHERE IDND = "+IDND;
            new sql.Request().query(Delete, function(err, result){
                if(err) throw err;
                res.redirect('/addmin/qltv');
            });
        }
        if(req.body.user_data.quyen == 'Admin'){
            var IDND = req.body.user_data.id;
            var Insert = "INSERT INTO QuanTri VALUES("+IDND+")";
            new sql.Request().query(Insert, function(err, result){
                if(err) throw err;
                res.redirect('/addmin/qltv');
            });
        }
    });
});

router.get('/deletetv',function(req, res){
    
    sql.connect(config, function(err){
        if(err) throw err;
        var Delete = "DELETE FROM NguoiDung WHERE IDND ="+req.query.tv;
        new sql.Request().query(Delete, function(err, result){
            if(err) throw err;
            res.redirect('/addmin/qltv');
        });
    });
});


router.get('/qlybook', function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;

        var pages = parseInt(req.query.page) || 1; // n
        var perPage = 6; // x

        var start = (pages -1) * perPage;
        var end = pages * perPage;
        var QLY = "SELECT Sach.IDSach,TenSach, Name,TacGia,NhaXB,NgayXB,SoLuong,Gia FROM Sach JOIN LoaiSach\n"+
        "ON Sach.IDSach = LoaiSach.IDSach\n"+
        "JOIN TheLoai \n"+
        "ON LoaiSach.IDLoai = TheLoai.IDLoai\n "

        new sql.Request().query(QLY, function(err, result){
            if(err) throw err;
            var pagez = result.recordset.length / perPage;
            res.render('Admin/quanlybook',{
                data : result.recordset.slice(start, end),
                page : pagez,
                pages : pages
            });
        });
    });
    
});

router.get('/Suabook',function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var bookname = req.query.book;
        var bookName = "SELECT * FROM Sach WHERE TenSach LIKE N'"+bookname+"'";
        var date = new Date();
        console.log(bookName);
        new sql.Request().query(bookName, function(err, result){
            if(err) throw err;
            var dmy = result.recordset[0].NgayXB.split("-",3);
            
            res.render('Admin/Suabook',{
                data : result.recordset,
                ddmmyy : dmy,
                date : date.getFullYear()
            });
        });
    });
});

router.post('/Suabook', function(req, res, next){
    sql.connect(config, function(err){
        if(err) throw err;
        var bookName = req.body.tensach;
        var image = req.body.Anh;
        var date = req.body.user_data.ngay[1] +'-'+req.body.user_data.thang+'-'+req.body.user_data.nam;
        var soluong = req.body.soluong;
        var TacGia = req.body.Tacgia;
        var NhaXB = req.body.Nhaxuatban;
        var Gia = req.body.Giatien;

        var UPDATE = "UPDATE Sach SET TenSach = N'"+bookName+"',\n"+
        "NgayXB = '"+date+"',\n"+
        "TacGia = N'"+TacGia+"',\n"+
        "NhaXB = N'"+NhaXB+"',\n"+
        "SoLuong = "+parseInt(soluong)+",\n"+
        "Gia = "+parseInt(Gia)+"\nWHERE TenSach = N'"+bookName+"'";
        console.log(UPDATE);
        new sql.Request().query(UPDATE, function(err, result){
            res.redirect('/addmin/qlybook');
        });
    })
});

router.get('/deleteBook',function(req, res, next){
    sql.connect(config, function(err){
        var deleteBook = "DELETE FROM Sach WHERE IDSach = '"+req.query.book+"'";
        new sql.Request().query(deleteBook, function(err, result){
            if(err) throw err;
            console.log("DELETE");
            res.redirect('/addmin/qlybook');
        });
    });
});

router.get('/addbook', function(req, res, next){
    res.render('Admin/addbook');
});

router.post('/addbook', function(req, res, next){
    
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
        
        new sql.Request().query(Select1, function(err, result){
            
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
                    res.redirect('/addmin/qlybook'); 
                });
            }
        });
    });
});

module.exports = router;