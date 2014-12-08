package WebService;

import DAO.ProdutoDAO;
import Model.Produto;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.ejb.Stateless;

/**
 *
 * @author JHenrique
 */
@WebService(serviceName = "BuscaWS")
@Stateless()
public class BuscaWS {
    
    @WebMethod(operationName = "nomeLoja")
    public String nomeLoja() {
        
        return "Marinhos_Loja";
    }
    
    @WebMethod(operationName = "listarProd")
    public Produto[] listarProd() throws Exception {
        //public ArrayList listarProd(@WebParam(name = "pesquisa") String txt) throws SQLException {
        
        ProdutoDAO dao = new ProdutoDAO();
        List<Produto> produtosL = dao.getProdutos("");
        
        Produto [] produtos = produtosL.toArray(new Produto[produtosL.size()]);
        //produtosL.toArray( produtos );
        //produtos = (Produto[]) produtosL.toArray();
        
        
        return produtos;
    }
}
