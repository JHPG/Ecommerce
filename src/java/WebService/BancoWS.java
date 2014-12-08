/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WebService;

import DAO.PedidoDAO;
import java.sql.SQLException;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.ejb.Stateless;

/**
 *
 * @author rapharma
 */
@WebService(serviceName = "BancoWS")
@Stateless()
public class BancoWS {

    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {      //Teste
        return "Hello " + txt + " !";
    }

    @WebMethod(operationName = "atualizarPedido")
    public void atualizarPedido(@WebParam(name = "id_compra") int id_compra, @WebParam(name = "pago") boolean pago) throws Exception {
        PedidoDAO pedidoDAO = new PedidoDAO();
        pedidoDAO.atualizarPedido(id_compra, pago);
    }
}
