var express = require('express');
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
                idleTimeoutMillis: 100000,
        }
};
var Connect = sql.connect(config);
module.exports = Connect;