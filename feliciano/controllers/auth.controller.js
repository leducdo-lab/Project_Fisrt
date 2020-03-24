module.exports.login = function(req, res){
    res.render('Login/contact');
};

module.exports.postLogin = function(req, res){
    var sql = require('mssql');
    var cofig = {
        user: 'SA',
        password: 'Dockersql123',
        server: 'localhost', 
        database: 'DTPBook' 
    };
    sql.connect(cofig, function(err){
        if(err) throw err;
        var email = req.body.email;
        var password = req.body.password;
        var SLemail = "SELECT TenDN,IDND FROM NguoiDung WHERE TenDN = '"+email+"' AND MatKhau = '"+password+"'";
        request.query(SLemail, function(err, result){
            if(err) throw err;
            if(!SLemail.IDND) {
                res.render('Login/contact',{
                    errors:  'Email hoac mat khau khong ton tai' 
                });
                return;
            };
            res.redirect('/Home' );
        }); 
    });  
}; 