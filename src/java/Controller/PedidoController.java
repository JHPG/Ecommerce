package Controller;

import DAO.PedidoDAO;
import Model.Pedido;
import Model.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class PedidoController extends HttpServlet implements Command{

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
                
                HttpSession sessao = request.getSession(true); 
		
                int idPedido=0, idProduto=0, qtd=1;
                double valor=0, valorTotal=0;
                String pgto="";

                Pedido pedido = new Pedido(request);
                PedidoDAO dao = new PedidoDAO();
                                
		//pedido = (Pedido) request.getAttribute("pedido");		//vai vir da página do carrinho
                
		idPedido = pedido.getNumPedido();
                pgto = request.getParameter("pagamento");
                
		pedido.setFormaPagamento(pgto);
                
                //Pegar cliente da sessão e atribuir endereço e CPF ao pedido
                String cpfCliente = (String) sessao.getAttribute("cpfCliente");
                
                pedido.setClienteCPF(cpfCliente); //Guerrero
                pedido.setEndereco("Rua dos Testes, 255");

                try {
                    //dao.criarPedido(idPedido, clienteCPF, endereco, valorTotal);
                    dao.criarPedido(pedido);    //Cria o pedido
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
                
		//for each com os itens do carrinho --
		for(Produto produto : pedido.getLista()){
                    try {
                        idProduto = produto.getIdProduto();
                        //qtd = produto.getQtd();				//pgto = produto.getFormaPagamento;
                        valor = produto.getPreco(); // * qtd;

                        dao.inserirNoPedido(idPedido, idProduto, qtd, valor);      //insere os produtos no pedido (um por um)
                        valorTotal += valor;
                    } catch (SQLException ex) { 
                        System.out.println(ex);
                    }
		}
                
                pedido.setValTotal(valorTotal);
                
                sessao.removeAttribute("carrinho");   // Apaga o carrinho
                
		//request.setAttribute("pedido", pedido);
                //RequestDispatcher rd = request.getRequestDispatcher("finalizar.jsp");	//Colocar a página de pagamento aqui
                //rd.forward(request, response);
                
                response.sendRedirect("http://cassio-vaio:8080/BancoAPD/login"
                + "?nome_loja=Marinhos_Loja&valor=" + pedido.getValTotal() + "&id_compra=" + 
                pedido.getNumPedido());
        }

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		execute(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
