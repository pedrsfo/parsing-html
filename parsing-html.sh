#!/bin/bash

# Autor: Pedro Otávio
# Email: pedr_ofs@hotmail.com
# Atualizado: 14/02/2022

# Este simples script tem por finalidade realizar a análise do código fonte de uma pagina web e realizar
# a resolução de nomes dos endereços web encontrados.

# Verifica se o usuário entrou com o argumento.
if [ "$1" == "" ];
then
	echo "Modo de uso: $0 exemplo.com.br"
else
	clear
	echo -e "Abrindo conexão"

	# Executa o download da página web.
	wget -q --show-progress $1

	# Verifica se o download foi executado com sucesso.
	if [ $? -ne 0 ];
	then
		echo "Falha na execução do download do codigo fonte da página\n"
	else
		echo "Executando a análise do código fonte..."

		# Realiza o filtro no código fonte e adiciona o resultado em um arquivo chamado.
		grep 'href="http' index.html | cut -d "/" -f 3 | cut -d '"' -f 1 | cut -d ":" -f 1 > lista

		echo -e "Realizando resolução de nomes de dominios\n"

		# Executa o comando host em cada ítem do arquivo.
		for host in $(cat lista); do host $host; done

		# Apaga os arquivos temporários.
		rm index.html lista
	fi
fi
