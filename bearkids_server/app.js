// bearkis的后端程序


// 导入express模块==>用于创建后端服务器
const express = require("express");
// 导入borderParse解析post请求数据
const bodyParser =require("body-parser");
// 需要手动添加,导入cors模块，解决跨域问题
const cors=require("cors");
// 需要手动添加，导入express-session模块，解决数据共享问题
const session=require("express-session");

// 导入连接池
const pool=require("./pool");

// 导入routes文件夹下的各个路由器
const router=require("./routes/user.js");

// //代理
// const proxy=require("http-proxy-middleweare");

// //配置代理
// var option={
//   target:"https://www.tianqiapi.com/",
//   changeOrigin:true,
//   ws:true,
//   pahtRewrite:{
//     '^/apis':'/apis',
//   },
//   router:{
//     'dev.127.0.0.1:3000':'http:localhost:8080'
//   }

// };
// //实例化
// var myProxy=proxy(option);





// 创建服务器
var server =express();

// server.use('/apis',myProxy);
// 解决跨域问题
server.use(cors({
  // 允许跨域访问的程序访问地址列表
  origin:["http://127.0.0.1:8080"
  ,"http://localhost:8080","https://www.tianqiapi.com/api/?version=v1"],
  credentials:true
}));

// 解决session，数据共享问题
server.use(session({
  // 设置加密字符串
  secret:"128位字符串",
  // 设置每次请求保存session数据
  resave:true,
  // 设置保存初始化数据
  saveUninitialized:true
}));

// 托管静态资源(后端资源)，前端资源已经在前端框架中托管
server.use(express.static("public"));

// 监听服务器端口号
server.listen(3000);



// 使用第三方模块bodyParse
server.use(bodyParser.urlencoded({
  extended:false
}));

// 使用路由器/路由
server.use("/user",router);


