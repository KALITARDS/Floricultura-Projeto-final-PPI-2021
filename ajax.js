//select
$('#select').on('click', function () {
    $.ajax({
        type: 'POST',
        url: 'http://localhost:3000/cliente/busca',
        data: JSON.stringify(
            {
                numero:  $('#entrada').val()
            }),
        contentType: 'application/json',
        success: info => {         
            $('#saida').html("<h2>Informações</h2>")
            $('#saida').append("Nome: ",info.nome)
            $('#saida').append("<br>CPF: ",info.cpf)
            $('#saida').append("<br>CEP: ",info.cep)
            $('#saida').append("<br>Cidade: ",info.cidade)

        },error: function(info){
            console.log('Erro');
       }
    });
});

//inserindo produtos- insert

$('#cadastrar').on('click', function () {
    $.ajax({
        type: 'POST',
        url: 'http://localhost:3000/cliente/cadastro',
        data: JSON.stringify(
            {
                nome: $("#nome").val(),
                categoria: $("#categoria").val(),
                preco: $("#preco").val(), 
            }),
        contentType: 'application/json',
        success: dados => {         
            $('#resposta').html("Cadastrado") 
        },error: function(dados){
            $('#resposta').html("ERRO ao Cadastrar")
       }
    });
});

//deletando cliente
$('#deletar').on('click', function () {
    $.ajax({
        type: 'POST',
        url: 'http://localhost:3000/cliente/deletar',
        data: JSON.stringify(
            {
                cod_produto: $("#cod_del").val(),
            }),
        contentType: 'application/json',
        success: dados => {         
            $('#resposta1').html("Deletado!") 
        },error: function(dados){
            $('#resposta1').html("ERRO ao Deletar")
       }
    });
});

//atualizar

$('#atualizar').on('click', function () {
    $.ajax({
        type: 'POST',
        url: 'http://localhost:3000/cliente/atualizar',
        data: JSON.stringify(
            {
                cod_produto: $("#at_cod").val(),
                preco: $("#at_preco").val()
            }),
        contentType: 'application/json',
        success: dados => {         
            $('#atual').html("Atualizado!"); 
        },error: function(dados){
            $('#atual').html("ERRO ao Atualizar");
       }
    });
});

//select
$('#pedido').on('click', function () {
    $.ajax({
        type: 'POST',
        url: 'http://localhost:3000/cliente/pedido',
        data: JSON.stringify(
            {
                num:  $('#numerop').val()
            }),
        contentType: 'application/json',
        success: info => {         
            $('#retorno').html("<h2>Informações</h2>")
            $('#retorno').append("ID: ",info.id)
            $('#retorno').append("<br>Data: ",info.data)
            $('#retorno').append("<br>CPF_Cliente: ",info.cpf)
            $('#retorno').append("<br>Cod_item: ",info.cod)


        },error: function(info){
            console.log('Erro');
       }
    });
});