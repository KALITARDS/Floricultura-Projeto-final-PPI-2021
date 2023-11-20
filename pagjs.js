const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const pg = require('pg');
const { SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION } = require('constants');

const app = express();
app.use(cors());
app.use(bodyParser.json());

const client = new pg.Client(
    {   user: "postgres", 
        host: 'localhost',
        database: 'ProjetoFinal',
        password:"postgres",
        port: 5432
    }
);

// select
client.connect();
app.post('/cliente/busca',function(req,res){
    client.query(
        {
            text: 'SELECT * FROM cliente WHERE nome = $1', //seleciona da tabela cliente, onde o nome for referente a entrada do user.
            values: [req.body.numero]
        }
    )
   .then(
        function(ret) {
       let saida = ret.rows[0];
            res.json({
                status:'Sucesso',
                nome: saida.nome,
                cpf: saida.cpf,
                cep: saida.cep,
                cidade: saida.cidade,
            })                   
    })
});

//insert
app.post('/cliente/cadastro',function(req,res){
    client.query(
        {
            text: 'INSERT INTO produto (nome, categoria, preco) VALUES ($1, $2, $3)',
            values: [req.body.nome, req.body.categoria, req.body.preco]
        }
    )
   .then(
        function(ret) {
            res.json({
                status:'Sucesso',
            })                   
    })
});

//delete
app.post('/cliente/deletar',function(req,res){
    client.query(
        {
            text: 'DELETE FROM produto WHERE cod_produto = $1',
            values: [req.body.cod_produto]
        }
    )
   .then(
        function(ret) {
            res.json({
                status:'Sucesso',
            })                   
    })
});

app.listen(
    3000,
    function(){
        console.log('Inicialização OK');
    }
);

//atualizar

app.post('/cliente/atualizar',function(req,res){
    client.query(
        {
            text: 'UPDATE produto SET preco = $1  WHERE cod_produto = $2',
            values: [req.body.preco,req.body.cod_produto]
        }
    )
   .then(
        function(ret) {
            res.json({
                status:'Sucesso',
            })                   
    })
});
// select
app.post('/cliente/pedido',function(req,res){
    client.query(
        {
            text: 'SELECT * FROM pedido WHERE ID_pedido = $1', 
            values: [req.body.num]
        }
    )
   .then(
        function(ret) {
       let retorno = ret.rows[0];
            res.json({
                status:'Sucesso',
                id: retorno.id_pedido,
                data: retorno.data,
                cpf: retorno.cpf_cliente,
                cod: retorno.cod_item

            })                   
    })
});

