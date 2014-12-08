<%-- 
    Document   : produto
    Created on : 05/10/2014, 01:18:01
    Author     : JHenrique
--%>

<%@page import="DAO.ProdutoDAO"%>
<%@page import="Model.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%
        try{
            int CodProd = Integer.parseInt(request.getParameter("CodProd"));
            ProdutoDAO dao = new ProdutoDAO();
            Produto prod = dao.getProduto(CodProd);
    %>
    
    
    <title><%=prod.getNome()+" - Detalhes do produto"%></title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/shop-item.css" rel="stylesheet">
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
                <a class="navbar-brand" href="index.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Home</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="carrinho.jsp">Meu carrinho</a>
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
                    <a href="#" class="list-group-item active">Category 1</a>
                    <a href="#" class="list-group-item">Category 2</a>
                    <a href="#" class="list-group-item">Category 3</a>
                </div>
            </div> -->

            <div class="thumbnail">
                <img class="img-responsive" src="<%="img/"+prod.getIdProduto()+".jpg"%>" style="max-height:350px;width:auto" alt="">
                <!-- <img class="img-responsive" src="http://placehold.it/800x300" style="max-width:800px" alt=""> -->
                <div class="caption-full">
                    <h4 class="pull-right"><%="R$"+prod.getPreco() %></h4>
                    <h4><a href="#"><%=prod.getNome() %></a></h4>
                    <p><%=prod.getDescricao() %></p>
                </div>
            </div>
        </div>
        <div class="row" style="float:right">
        <!--_____________________________-->
            <a href="/Ecommerce/FrontController?acao=carrinho&car=add&CodProd=<%=prod.getIdProduto()%>" class="btn btn-success" style="padding:7%">
                <h3><span class="glyphicon glyphicon-shopping-cart"></span> Comprar</h3>
            </a>
            <!-- Link de remover no carrinho:
                //dentro do for
                <a href="Ecommerce/CarrinhoController?acao=remove&CodProd=<%//=p.getIdProduto()%>" class="btn btn-danger" style="padding:3%">X</a>
            -->
         <!--_________________________-->
        </div>

    </div>
    <!-- /.container -->
    
    <%
        }catch(Exception e){ 
            e.printStackTrace();
        }
    %>

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
