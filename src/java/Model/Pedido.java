package Model;

import DAO.ProdutoDAO;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class Pedido {

    private int numPedido=0;
    private String clienteCPF="", endereco="", formaPagamento="";
    private List<Produto> produtos = new ArrayList();
    private double valTotal=0;
    private Date data = new Date();
    private boolean pago = false; 

    private ProdutoDAO dao = new ProdutoDAO();

    public Pedido(HttpServletRequest request){
        HttpSession sessao = request.getSession(true); 
        this.produtos = (ArrayList) sessao.getAttribute("carrinho");   // produtos
        if(produtos == null) produtos = new ArrayList();
        
        for(Produto p : produtos) this.valTotal += p.getPreco(); //* p.getQtd();  // Valtotal
        //Gera com base no carrinho que está na sessão

        Random gerador = new Random();  //Gera um número aleatório para o pedido - Solução provisória
        numPedido = gerador.nextInt(1000000);   //De 0 a 1000000
    }
    
    public Pedido(){}

    //Criar outro construtor com tudo

    public List<Produto> getLista() {
        return produtos;
    }

    public void setLista(List<Produto> lista) {
        this.produtos = lista;
    }

    public double getValTotal() {
        return valTotal;
    }

    public void setValTotal(double valTotal) {
        this.valTotal = valTotal;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public int getNumPedido() {
        return numPedido;
    }

    public void setNumPedido(int numPedido) {
        this.numPedido = numPedido;
    }

    public String getFormaPagamento() {
        return formaPagamento;
    }

    public void setFormaPagamento(String formaPagamento) {
        this.formaPagamento = formaPagamento;
    }

    public String getClienteCPF() {
        return clienteCPF;
    }

    public void setClienteCPF(String clienteCPF) {
        this.clienteCPF = clienteCPF;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }
    
    public boolean isPago() {
        return pago;
    }

    public void setPago(boolean pago) {
        this.pago = pago;
    }
}
