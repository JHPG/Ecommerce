
package Controller;

import DAO.ProdutoDAO;
import Model.Carrinho;
import Model.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author JHenrique
 */
public class CarrinhoController extends HttpServlet implements Command{

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
            try {
                response.setContentType("text/html;charset=UTF-8");
                
                Carrinho carrinho = new Carrinho(request);
                
                String acao = (String) request.getParameter("car");
                int idProduto = Integer.parseInt(request.getParameter("CodProd"));
                
                ArrayList<Produto> produtos;
                HttpSession sessao = request.getSession(true);
                ProdutoDAO dao = new ProdutoDAO();
                Produto produto = dao.getProduto(idProduto);
                
                if(acao.equals("add")){
                    produtos = (ArrayList) carrinho.getItensCarrinho(request);
                    if(produtos==null)produtos = new ArrayList<>();
                    
                    try{
                        produtos.add(produto);
                    }catch(Exception e){}
                    sessao.setAttribute("carrinho", produtos);
                    response.sendRedirect("carrinho.jsp");
                    
                } else if(acao.equals("remove")){
                    try{
                        //carrinho.removeProduto(idProduto, request);
                        
                        produtos = (ArrayList) sessao.getAttribute("carrinho");   //produtos
                        //if(produtos==null)produtos = new ArrayList<>();
                        
                        for(Produto p : produtos){
                            if(p.getIdProduto() == idProduto) produtos.remove(p);
                        }
                        
                        response.sendRedirect("carrinho.jsp");
                    } catch (Exception ex) {
                        response.sendRedirect("carrinho.jsp"); //Arrumou um erro
                    }
                }else{
                    response.sendRedirect("busca.jsp");
                }   
            } catch (SQLException ex) {
                Logger.getLogger(CarrinhoController.class.getName()).log(Level.SEVERE, null, ex);
            }

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
