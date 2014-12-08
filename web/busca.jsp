<%-- 
    Document   : busca
    Created on : 05/10/2014, 01:12:07
    Author     : JHenrique
--%>

<%@page import="Controller.BuscaController"%>
<%@page import="Controller.Command"%>
<%@page import="DAO.ProdutoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Model.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Busca de produtos Ecommerce</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/shop-homepage.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <a class="navbar-brand" href="carrinho.jsp"><span class="glyphicon glyphicon-shopping-cart"></span>Meu carrinho</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="index.jsp">Home</a>
                    </li>
                    <li>
                        <a href="pedidos.jsp">Pedidos</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">

        <div class="row">

            <!-- <div class="col-md-3">
                <p class="lead">Shop Name</p>
                <div class="list-group">
                    <a href="#" class="list-group-item">Category 1</a>
                    <a href="#" class="list-group-item">Category 2</a>
                    <a href="#" class="list-group-item">Category 3</a>
                </div>
            </div> -->
            <%
                HttpSession sessao = request.getSession(true); 
                sessao.setAttribute("cpfCliente", "11122233345");       //Tirar depois de implantar o login
            %>
            <div class="">
                <div class="row carousel-holder">
                    <form method="GET" action="/Ecommerce/FrontController" class="input-group" style="max-width:600px; margin:5% auto">
                        <input type="text" class="form-control" placeholder="Pesquisa" name="busca">
                        <input type="hidden" name="acao" value="busca" />
                        <span class="input-group-btn">
                            <button class="btn btn-primary" type="submit"> <span class="glyphicon glyphicon-search"></span> Buscar</button>
                        </span>
                    </form>
                </div>

                <div class="row">
                    <div class="row">
                        <%
                            List<Produto> lista = new ArrayList();
                            lista = (ArrayList) request.getAttribute("busca");
                            int i = 0;
                            
                            if(lista == null){ //Se for lista for nula (página inicial com tds os produtos)                                
                                Command busca = new BuscaController();
                                busca.execute(request, response);          
                            }
                            
                            if(lista != null){
                                for(Produto p : lista){
                                    if(i==4){
                                        %><div class="row"></div><%
                                        i=0;
                                    }
                                    i++;
                                    
                                    try{
                                    %>

                                    <!-- Início produto -->
                                    <div class="col-sm-3 col-lg-3 col-md-3">
                                        <div class="thumbnail">
                                            <a href="produto.jsp?CodProd=<%=p.getIdProduto()%>">
                                                <img src="<%="img/produtos/"+p.getIdProduto()+".jpg"%>" alt="" class="thumb" style="max-height:150px; width:auto">
                                            </a>
                                            <div class="caption">
                                                <h4 class="pull-right"> <%="R$"+p.getPreco()%> </h4>
                                                <h4><a href="produto.jsp?CodProd=<%=p.getIdProduto()%>"><%=p.getNome()%></a></h4>

                                                <p><%=p.getDescricao()%></p>

                                                <a href="produto.jsp?CodProd=<%=p.getIdProduto()%>" type="button" class="btn btn-default pull-right">
                                                    <span class="glyphicon glyphicon-shopping-cart"></span> Comprar
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Fim produto -->

                                    <%
                                    }catch(Exception e){ e.printStackTrace(); }
                                }
                            }
                            if(lista.isEmpty())
                                %> <h3> A pesquisa não retornou resultados. </h3> <%
                        %>
                        
                        
                        
                        <!-- Início produto -->
                        <!--<div class="col-sm-4 col-lg-4 col-md-4">
                            <div class="thumbnail">
                                <img src="http://placehold.it/320x150" alt="" class="thumb">
                                <div class="caption">
                                    <h4 class="pull-right">R$24.99</h4>
                                    <h4><a href="produto.html">First Product</a>
                                    </h4>
                                    <p>This is a short description. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                
                                    <a href="produto.html?CodProd=1" type="button" class="btn btn-default pull-right">
                                        <span class="glyphicon glyphicon-shopping-cart"></span> Comprar
                                    </a>
                                </div>
                            </div>
                        </div>-->
                        <!-- Fim produto -->
                        
                        
                    </div>
                </div>

                <!--<div class="row" style="float: right">
                    <ul class="pagination">
                      <li><a href="#">&laquo;</a></li>
                      <li><a href="#">1</a></li>
                      <li><a href="#">2</a></li>
                      <li><a href="#">3</a></li>
                      <li><a href="#">4</a></li>
                      <li><a href="#">5</a></li>
                      <li><a href="#">&raquo;</a></li>
                    </ul>
                </div>-->

            </div>

        </div>

    </div>
    <!-- /.container -->

    <div class="container">

        <hr>

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Daniele, Jorge, Marcelo e Raphael</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>

