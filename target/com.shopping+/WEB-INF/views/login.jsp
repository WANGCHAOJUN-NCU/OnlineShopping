<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!--jstl核心标签库-->
<c:set var="cp" value="${pageContext.request.contextPath}"/><!--绝对路径-->

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SkyDog</title>
    <style>
        #code{
            font-family:Arial;
            font-style:italic;
            font-weight:bold;
            border:0;
            letter-spacing:2px;
            color:blue;
        }
    </style>
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<!--导航栏部分-->
<jsp:include page="include/header.jsp"/>

<div class="row">
    <div class="col-md-8">

        <img src="${cp}/img/login_illus.png" style="width: 100%;height: 500px;"></a>
    </div>
    <div class="  col-md-3 col-md-offset-0">
        <div class="jumbotron" style="background-color:#C5CAE9; height: 500px; width: 470px">
            <!-- 中间内容 -->


            <h2 class="title center">登录</h2>
            <br/>
            <div class="row">
                <!-- 表单输入 -->
                <div  class="form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-4 col-md-4 control-label">邮箱/用户名</label>
                        <div class="col-sm-7 col-md-7">
                            <input type="text" class="form-control" id="inputEmail" placeholder="xxxxxx@xx.com"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-4 col-md-4 control-label">密码
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        </label>
                        <div class="col-sm-7 col-md-7">
                            <input type="password" class="form-control" id="inputPassword" placeholder="禁止输入非法字符" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="checks" class="col-sm-4 col-md-4 control-label">验证码
                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        </label>
                        <div class="col-sm-7 col-md-7">
                            <input id="checks" class="form-control" type="text" style="width:150px;" style="display:inline;"/>
                            <input type = "button" id="code" onclick="createCode()" style="display:inline;"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-7 col-md-7 col-sm-offset-4 col-md-offset-4">
                            <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="startLogin()">登录</button>
                        </div>
                    </div>
                </div>
                <br/>
            </div>
        </div>
    </div>
</div>

</div>
<!--尾部-->
<jsp:include page="include/foot.jsp"/>

<script type="text/javascript">
    //设置一个全局的变量，便于保存验证码
    var code;
    function createCode(){
        //首先默认code为空字符串
        code = '';
        //设置长度，这里看需求，我这里设置了4
        var codeLength = 4;
        var codeV = document.getElementById('code');
        //设置随机字符
        var random = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R', 'S','T','U','V','W','X','Y','Z');
        //循环codeLength 我设置的4就是循环4次
        for(var i = 0; i < codeLength; i++){
            //设置随机数范围,这设置为0 ~ 36
            var index = Math.floor(Math.random()*36);
            //字符串拼接 将每次随机的字符 进行拼接
            code += random[index];
        }
        //将拼接好的字符串赋值给展示的Value
        codeV.value = code;
    }

    //设置此处的原因是每次进入界面展示一个随机的验证码，不设置则为空
    window.onload = function (){

        createCode();
    }
    function startLogin() {
        var loading = layer.load(0,{time: 1*1000});
        var user = {};
        var loginResult = "";
        var inputStr = document.getElementById('checks').value.toUpperCase();
        user.userNameOrEmail = document.getElementById("inputEmail").value;
        user.password = document.getElementById("inputPassword").value;
        if(inputStr!=null && inputStr!=""){
            inputStr = inputStr.toUpperCase();//将输入的字母全部转换成大写
            user.code=code;
            user.inputStr = inputStr;
        }else{
            alert("验证码不能为空!")
        }
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/doLogin',
            data : user,
            dataType : 'json',
            success : function(result) {
                loginResult = result.result;
                layer.close(loading);
            },
            error : function(result) {
                layer.alert('查询用户错误');
            }
        });

        if(loginResult === 'success'){
            layer.msg('登录成功',{icon:1});
            window.location.href = "${cp}/main";
        }
        else if(loginResult === 'unexist'){
            layer.msg('是不是用户名记错了？',{icon:2});
        }
        else if(loginResult === 'wrong'){
            layer.msg('密码不对哦，再想想~',{icon:2});
        }
        else if(loginResult === 'fail'){
            layer.msg('服务器异常',{icon:2});
        }
        else if(loginResult === 'notCode'){
            layer.msg('验证码错误！',{icon:2});
        }

    }
</script>

</body>
</html>