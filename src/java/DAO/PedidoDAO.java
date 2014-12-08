package DAO;

import Model.Pedido;
import Model.Produto;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author JHenrique
 */

public class PedidoDAO {
    
    Connection conexao;
    
    public void criarPedido(Pedido pedido) throws SQLException{
        this.conexao = DriverManager.getConnection("jdbc:derby://localhost:1527//BD_Ecommerce","root","1234");
        String sql = "INSERT INTO Pedidos (NumPedido, ClienteCPF, Endereco, ValorTotal, FormaPagamento, Data) "+
                "VALUES (?,?,?,?,?,?)";
        PreparedStatement stmt = conexao.prepareStatement(sql);

        //String hora = new Date().toString();

        int numPedido = pedido.getNumPedido();
        String clienteCPF = pedido.getClienteCPF();
        String endereco = pedido.getEndereco();

        double valTotal = pedido.getValTotal();
        String formaPagamento = pedido.getFormaPagamento();
        

        stmt.setInt(1, numPedido);
        stmt.setString(2, clienteCPF);
        stmt.setString(3, endereco);
        stmt.setDouble(4, pedido.getValTotal());
        stmt.setString(5, formaPagamento);
            Date d = new Date();
            java.sql.Date dateSQL = new java.sql.Date(d.getYear(), d.getMonth(), d.getDay());
        stmt.setDate(6, dateSQL);
        
        try{
            stmt.execute(); 
        }finally{
            stmt.close();
        }
    }
            
    public void inserirNoPedido(int idPedido, int idProduto, int qtd, Double valor) throws SQLException{
        this.conexao = DriverManager.getConnection("jdbc:derby://localhost:1527//BD_Ecommerce","root","1234");
        String sql = "INSERT INTO Pedidos_Produtos (IDPedido, IDProduto, Quantidade, Valor) VALUES(?,?,?,?)";
        PreparedStatement stmt = conexao.prepareStatement(sql);

        stmt.setInt(1, idPedido);
        stmt.setInt(2, idProduto);
        stmt.setInt(3, qtd);
        stmt.setDouble(4, valor);

        try{
            stmt.execute(); 
        }finally{
            stmt.close();
        }
    }

    /*public Pedido getPedido(int idPedido) throws SQLException{

        return null;
    } */
    
    public void atualizarPedido(int id_compra, boolean pago) throws SQLException{
        this.conexao = DriverManager.getConnection("jdbc:derby://localhost:1527//BD_Ecommerce","root","1234");
        try {
            String sql = "UPDATE pedidos SET pago = ? WHERE numpedido = ?";
            PreparedStatement pstmt = conexao.prepareStatement(sql);
            pstmt.setBoolean(1, pago);
            pstmt.setInt(2, id_compra);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Pedido> buscarPedidos(String clienteCPF) throws SQLException{
        try{
            Connection conexao = DriverManager.getConnection("jdbc:derby://localhost:1527//BD_Ecommerce","root","1234");

            String sql= "select * from Pedidos where clienteCPF=? order by DATA";

            PreparedStatement stmt2 = conexao.prepareStatement(sql);

            stmt2.setString(1, clienteCPF); 

            ResultSet rs = stmt2.executeQuery();
            ArrayList <Pedido> pedidos = new ArrayList();

            while(rs.next()){
                //Cria objeto pedido
                Pedido p = new Pedido();
                p.setClienteCPF(clienteCPF);
                p.setData(rs.getDate("Data"));
                p.setEndereco(rs.getString("Endereco"));
                p.setFormaPagamento(rs.getString("FormaPagamento"));
                //p.setLista(rs.getString("pedidos??"); //??
                p.setNumPedido(rs.getInt("numPedido"));
                p.setPago(rs.getBoolean("pago"));
                Double d = rs.getDouble("valorTotal");
                p.setValTotal(d);
                
                int qtd = 0;

                pedidos.add(p);
            }
            return pedidos;

        } catch(SQLException e){
            return null;
        }
        
    }
}
