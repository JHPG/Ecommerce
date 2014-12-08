package DAO;

import Model.Produto;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author rapharma
 */
public class ProdutoDAO {
    
    //buscarProduto retornar lista
    //inserir manualmente
    
    public ArrayList getProdutos(String pesq) throws SQLException{
        try{
            Connection conexao = DriverManager.getConnection("jdbc:derby://localhost:1527//BD_Ecommerce","root","1234");

            String sql= "select * from Produtos where LOWER(Nome) like LOWER(?) order by Preco DESC ";

            PreparedStatement stmt2 = conexao.prepareStatement(sql);

            stmt2.setString(1, "%"+pesq+"%"); 

            ResultSet rs = stmt2.executeQuery();
            //Dei import model.produto pra funcionar a linha abaixo by Raphael
            ArrayList <Produto> prodLista = new ArrayList();

            while(rs.next()){
                //Cria objeto produto
                int idProduto = rs.getInt("ID");
                String nome = rs.getString("Nome");
                double preco = rs.getDouble("Preco");
                String descricao = rs.getString("Descricao");
                String categoria = rs.getString("Categoria");
                int qtd = 0;

                Produto pro = new Produto(idProduto, nome, preco, descricao, categoria, qtd);
                pro.setEndSite("http://note_jh:8080/Ecommerce/produto.jsp?CodProd="+idProduto);
                pro.setEndImg("http://note_jh:8080/Ecommerce/img/"+ idProduto +".jpg");
                
                prodLista.add(pro);
            }
            return prodLista;

        } catch(SQLException e){
                return null;
        }
    }
    
    public Produto getProduto(int cod) throws SQLException{
        try{
            Connection conexao = DriverManager.getConnection("jdbc:derby://localhost:1527//BD_Ecommerce","root","1234");
            String sql= "Select * from Produtos where ID=?";

            PreparedStatement stmt2 = conexao.prepareStatement(sql);
            
            stmt2.setInt(1, cod);

            ResultSet rs = stmt2.executeQuery();

            //List <Produto> prodLista = new ArrayList();
            Produto prod = new Produto();

            while(rs.next()){
                //Cria objeto produto
                int idProduto = rs.getInt("ID");
                String nome = rs.getString("Nome");
                double preco = rs.getDouble("Preco");
                String descricao = rs.getString("Descricao");
                String categoria = rs.getString("Categoria");
                int qtd = 0;

                prod = new Produto(idProduto, nome, preco, descricao, categoria, qtd);
            }
            return prod;

        } catch(SQLException e){
                return new Produto();
        }
    }
    
}
