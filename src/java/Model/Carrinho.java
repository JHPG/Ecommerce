/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DAO.ProdutoDAO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Carrinho{
    
   private ProdutoDAO dao = new ProdutoDAO();
   
   private double valTotal=0;

   public Carrinho(HttpServletRequest request){
      try{
          ArrayList<Produto> produtos = new ArrayList();
          HttpSession sessao = request.getSession(true);
          produtos = (ArrayList) sessao.getAttribute("carrinho");   //produtos
          for(Produto p : produtos) this.valTotal += p.getPreco() * p.getQtd();  //valTotal
        }catch(Exception e){}
   }

   public double getTotalCarrinho(){
      return this.valTotal;
   }

   public ArrayList<Produto> getItensCarrinho(HttpServletRequest request){
      HttpSession sessao = request.getSession(true);
      
      ArrayList<Produto> produtos = (ArrayList) sessao.getAttribute("carrinho");   //produtos
      if(produtos==null)produtos = new ArrayList<>();
      
      return produtos;
   }
    
}
