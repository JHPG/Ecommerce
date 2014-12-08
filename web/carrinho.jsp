<%-- 
    Document   : carrinho
    Created on : Oct 13, 2014, 7:50:07 PM
    Author     : JHenrique
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Model.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Carrinho</title>

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

        <style>
            .tituCarrinho{
                font-weight: bolder;
                padding: 1.3%;
                background-color: #ddd;
                color: #428bca;
                border-radius: 2px;
            }
        </style>

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

                    <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-shopping-cart"></span>Meu carrinho</a>
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

                <div class="col-md-2">
                    

                </div>

                <div class="col-md-10" style="">

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
                        <h3 class="tituCarrinho"> Produtos </h3>
                        <div class="caption">

                            <!--<div class="row" style="display:block; text-align:left; margin:2%">
                                <img style="width:20%" src="imagens/semimagem.jpg" alt="">
                                <p style="display:inline; margin:1%">blá blá blá blá blá blá</p>
                                <a href="#">
                                    <img style="width:2.5%" src="imagens/excluir.gif" alt="">
                                </a>
                            </div>-->
                            
                            <%
                                HttpSession sessao = request.getSession(true);
                                double soma = 0;

                                ArrayList<Produto> produtos = new ArrayList();
                                produtos = (ArrayList<Produto>) sessao.getAttribute("carrinho");   //produtos
                                if(produtos==null)produtos = new ArrayList();
                                
                                if(produtos.isEmpty()){
                                    %> <br/><h3> Não há produtos no carrinho. </h3><br/> <%
                                }
                                try{
                                    for(Produto p : produtos){		// Exibir produtos do carrinho	
                                        soma += p.getPreco(); // * p.getQtd();
                                    %>
                                        <div class="row" style="display:block; text-align:left; margin:2%">
                                            <img style="width:20%" src="img/produtos/<%=p.getIdProduto()%>.jpg" alt="">
                                            <p style="display:inline; margin:1%"><%=p.getNome()+" - <b>R$"+p.getPreco()+"</b>"%></p>
                                            <a href="/Ecommerce/FrontController?acao=carrinho&car=remove&CodProd=<%=p.getIdProduto()%>" style="padding:3%">
                                                <img style="width:2.3%" src="imagens/excluir.gif" alt="">
                                            </a>
                                        </div>
                                    <% } %>

                                <h4 class="tituCarrinho"> Total:  R$<%=soma%></h4>
                        <% 
                                }catch(Exception e){}
                        %>

                        </div>
                        <% 
                        if(produtos.isEmpty() == false){
                            %>
                        <form class="row" method="POST" action="/Ecommerce/FrontController">
                            <h4 class="tituCarrinho"> Forma de pagamento: 
                                <input type="radio" id="pagamento1" name="pagamento" value="Boleto" required>
                                    <label for="pagamento1"><img name="formas" src="imagens/boleto.png" /></label>
                                <input type="radio" id="pagamento2" name="pagamento" value="Itau">
                                    <label for="pagamento2"><img name="formas" src="imagens/itau.png" /></label>
                                <input type="radio" id="pagamento3" name="pagamento" value="master">
                                    <label for="pagamento3"><img name="formas" src="imagens/master.jpg" /></label>
                                <input type="radio" id="pagamento4" name="pagamento" value="Visa">
                                    <label for="pagamento4"><img name="formas" src="imagens/visa.png" /></label>
                                <br/>
                                <input type="hidden" name="acao" value="gerarPedido" />
                                <!-- Adicionar input com dados do usuário gerarPedido-->
                                <p><input type="submit" class="btn btn-success pull-right" value="Finalizar compra"><br/><br/></p>
                            </h4>   
                        </form>
                        <%  } %>
                    </div>      

                </div>

            </div>


        </div>
    </div>
    <!-- /.container -->

    <div class="container">

        <hr/>
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
