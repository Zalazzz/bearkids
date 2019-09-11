// 创建数据库连接池
// 导入mysql模块
const mysql=require("mysql");
// 创建连接池对象
var pool=mysql.createPool({
  host:"127.0.0.1",
  user:"root",
  password:"",
  port:3306,
  database:"bearkids",
  connectionLimit:20
});
// 导出连接池对象
module.exports=pool;