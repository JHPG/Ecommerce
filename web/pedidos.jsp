<%-- 
    Document   : Pedidos
    Created on : 07/11/2014, 13:44:09
    Author     : JHenrique
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="DAO.PedidoDAO"%>
<%@page import="java.util.List"%>
<%@page import="Model.Pedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pedidos Ecommerce</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <style type="text/css">
            .relatorio{
                background-color: #eee;
                padding: 15px;
                margin: 10px;
                border-radius: 10px;
                float: left;
            }
        </style>
    </head>
    <body>
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

                    <div class="row" style="margin:1% 5%; display:table">

                    <%
                        HttpSession sessao = request.getSession(true); 
                        String cpfCliente = (String) sessao.getAttribute("cpfCliente");

                            try {
                                PedidoDAO dao = new PedidoDAO();
                                List<Pedido> pedidos = dao.buscarPedidos(cpfCliente);

                                %> <p> <b>Pedidos para o CPF: </b> <%=pedidos.get(0).getClienteCPF() %></p> <%

                                for(Pedido pedido : pedidos){

                                %>
                                <div class="relatorio">
                                    <p> <b>NumPedido:</b> <%=pedido.getNumPedido() %></p>
                                    <p> <b>Data:</b> <%=pedido.getData() %></p>
                                    <p> <b>Forma de pagamento:</b> <%=pedido.getFormaPagamento() %></p>
                                    <p> <b>Endereço:</b> <%=pedido.getEndereco() %></p>
                                    <p> <b>Valor total:</b> R$<%=pedido.getValTotal() %></p>

                                    <% String pago="Não"; String color="red" ;
                                    if(pedido.isPago()){ pago="Sim"; color="green"; } %>

                                    <p> <b>Pago:</b> <span style="color:<%=color%>"> <%=pago %> <span></p>
                                </div>
                                <%
                            }
                        }catch(Exception e){ }

                        %>
                        <br/>
                        <h3 style="clear: both"><a href="index.jsp">Voltar ... </a></h3>

                        <script src="js/bootstrap.min.js"></script>
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
</html>

