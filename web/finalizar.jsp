<%-- 
    Document   : finalizar
    Created on : 28/10/2014, 16:38:22
    Author     : JHenrique
--%>

<%@page import="Model.Pedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Finalização Ecommerce</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/shop-homepage.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <style type="text/css">
            .relatorio{
                background-color: #eee;
                padding: 6%;
                border-radius: 10px;
            }
            
        </style>
    </head>
    <body>
        <div style="margin:1% auto; display:table">
            <h1>Pedido efetuado!</h1><br/>

            <%
                try{
                    Pedido pedido = (Pedido) request.getAttribute("pedido");
                    %>
                    <div class="relatorio">
                        <p> <b>NumPedido:</b> <%=pedido.getNumPedido() %></p>
                        <p> <b>CPF do Cliente:</b> <%=pedido.getClienteCPF() %></p>
                        <p> <b>Data:</b> <%=pedido.getData() %></p>
                        <p> <b>Forma de pagamento:</b> <%=pedido.getFormaPagamento() %></p>
                        <p> <b>Endereço:</b> <%=pedido.getEndereco() %></p>
                        <p> <b>Valor total:</b> R$<%=pedido.getValTotal() %></p>

                        <% String pago="Não"; if(pedido.isPago()) pago="Sim"; %>
                        <p> <b>Pago:</b> <%=pago %></p>
                    </div>
                    
                    <%-- Dados a serem enviados ao banco --%>
                    <form method="POST" action="pagamento_banco.jsp" style="">
                        <input type="hidden" name="numPedido" value="<%=pedido.getNumPedido() %>" />
                        <input type="hidden" name="CPF" value="<%=pedido.getClienteCPF() %>" />
                        <input type="hidden" name="data" value="<%=pedido.getData() %>" />
                        <input type="hidden" name="formaPagamento" value="<%=pedido.getFormaPagamento() %>" />
                        <input type="hidden" name="endereco" value="<%=pedido.getEndereco() %>" />
                        <input type="hidden" name="valorTotal" value="<%=pedido.getValTotal() %>" />
                        <input type="hidden" name="pago" value="<%=pedido.isPago() %>" />
                        <br/>
                        <p><input type="submit" class="btn btn-success pull-right" value="Pagar agora"></p><br/>

                    </form>
                    
                    <%
                }catch(Exception e){ }

            %>
            <br/>
            <h3><a href="index.jsp">Voltar ... </a></h3>
            
            <script src="js/bootstrap.min.js"></script>
        </div>
    </body>
</html>
