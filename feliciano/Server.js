var express = require('express');

var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser'); 
var HomeRouter = require('./routes/home.router');
var usersRouter = require('./routes/users.router');

var app = express();
var port = 1234;
app.set('view engine', 'pug');
app.set('views', './views');

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(cookieParser());
app.use(express.static('public'));
app.use('/home',HomeRouter);
app.use('/users',usersRouter);

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

app.get('/', function(req, res){
    sql.connect(config, function(err){
        if(err) throw err;
        var request = new sql.Request();
        var SLBook = "SELECT TOP(6) IDSach,TenSach,Gia,TacGia FROM Sach ORDER BY NgayUp DESC";

        request.query(SLBook, function(err, result){
            if(err) throw err;
            else{
                res.render('index',{
                    data: result.recordset
                });
            }
        });
        
    });
});

app.get('/search', function(req, res){
    
    sql.connect(config, function(err){
        if(err) throw err;

        var request = new sql.Request();
        var q = req.query.q;
        var SL = "SELECT * FROM Sach WHERE TenSach LIKE '%"+q+"%'";

        request.query(SL, function(err, result){
            if(err) throw err;
            
            if(result.recordset.length == 0){
                res.render('index',{
                    errors : 'Không có sách này'
                });
                return;
            }
            res.render('index',{
                data : result.recordset
            });
        });
    });
});

app.listen(port, function () {
    console.log('Server is running..');
}); 