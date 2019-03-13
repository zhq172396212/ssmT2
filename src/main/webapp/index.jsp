<%--
  Created by IntelliJ IDEA.
  User: YangML
  Date: 2019/3/11
  Time: 上午8:57
  version:TODO
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="static/dist/bootstrap-table.css">
    <script src="static/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="static/dist/bootstrap-table.js" type="text/javascript"></script>
    <script src="static/dist/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>
    <script>
        function getall(){
            $.ajax({
                url:"blog/find",
                type:"post",
                dataType:"json",
                success:function(data){
                    console.log(data)
                }
            })
        }

        $(function(){
            //创建bootstrapTable
            $("#tab").bootstrapTable({
                method:"POST",
                //极为重要，缺失无法执行queryParams，传递page参数
                contentType : "application/x-www-form-urlencoded",
                dataType:"json",
                url:'blog/find',
                queryParams:queryParam,
                pagination:true,//显示分页条：页码，条数等
                striped:true,//隔行变色
                pageNumber:1,//首页页码
                pageSize:10,//分页，页面数据条数
                uniqueId:"bId",//Indicate an unique identifier for each row
                sidePagination:"server",//在服务器分页
                responseHandler:responseHandler,
                height:500,
                toolbar:"#toolbar",//工具栏
                columns : [{
                    checkbox:"true",
                    field : "box"
                },  {
                    title : "ID",
                    field : "bId",
                    visible: false
                }, {
                    title : "博客内容",
                    field : "context"
                }, {
                    title : "用户ID",
                    field : "userId"
                },{
                    title : "类型",
                    field : "type"
                }],
                showRefresh : true,//刷新
            });


        })

        function responseHandler(res) {
            console.log(res);
            if (res) {
                return {
                    "rows" : res.result.list,
                    "total" : res.result.total
                };
            } else {
                return {
                    "rows" : [],
                    "total" : 0
                };
            }
        }
        function queryParam(params) {
            var param = {
                limit : this.limit, // 页面大小
                offset : this.offset, // 页码
                pageNumber : this.pageNumber,
                pageSize : this.pageSize
            };
            return param;
        }

        function addBlog(){
         var  p = $("#addForm").serializeArray();
         $.ajax({
             url:"blog/addBlog",
             type:"post",
             data:p,
             dataType:"json",
             success:function(data){
                 $("#tab").bootstrapTable('refresh');
                 $("#addModal").modal("hide");
             }
         })
        }

        function delBlog(){
            var rows = $("#tab").bootstrapTable('getSelections');
            var arrId = [] ;
            for(i in rows){
               var id =  rows[i].bId;
                arrId.push(id)
            }
            console.log(arrId);
            $.ajax({
                url:"blog/delBlog",
                traditional:true,
                type:"post",
                data: {bId:arrId},
                dataType:"json",
                success:function(data){
                    $("#tab").bootstrapTable('refresh');
                }
            })
        }
    </script>
</head>
<body>

<a href="javascript:getall()" >test</a>

<div>
    <div class="container">
        <div id="toolbar">
            <input type="button" value="新增BLog" id="addBtn" data-toggle="modal" data-target="#addModal" class="btn btn-primary"></input>
            <input type="button" value="修改用户" id="editBtn" data-toggle="modal" data-target="#editUserModal" class="btn btn-primary" onclick="editUser()"></input>
            <input type="button" value="删除用户" id="deleteBtn" data-toggle="modal" class="btn btn-primary" onclick="delBlog()"></input>
        </div>
    </div>


    <!--新增 模态框（Modal） -->
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">添加blog</h4>
                </div>
                <div class="modal-body">
                    <form id="addForm">
                        <input type="text" name="context">
                        <input type="text" name="userId">
                        <input type="text" name="type">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" onclick="addBlog()" class="btn btn-primary">提交更改</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <table id="tab"></table>
</div>
</body>
</html>
