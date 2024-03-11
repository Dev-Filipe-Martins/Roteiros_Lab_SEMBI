# Roteiros Lab SEMBI
Roteiros das Aulas Práticas de Sistemas Embarcados I

## Lab 01:
* Instalação do Ubuntu 20.04 no Windows Subsystem for Linux 2 (WSL2)\
https://github.com/daniel-p-carvalho/ufu-semb1-lab-01/blob/master/Instala%C3%A7%C3%A3o%20WSL.md

* Instalação das Ferramentas de Desenvolvimento\
https://github.com/daniel-p-carvalho/ufu-semb1-lab-01/blob/master/Configura%C3%A7%C3%A3o%20Ubuntu.md

Sistema Heterogeneo

Plataforma target (alvo) - ARM Cortex M4 \
Arquitetura host - linux ...

Sistema Embarcado (Target) - STM \
Debuger ou Gravador (Host) - St link: comunicação com o sistema embarcado

### Fazer um Hello World em C
Atalho para o diretório do usuário: 

    ~
Mostra qual pasta/diretório está:

    pwd
Faz a troca do diretório (Change directory):

    cd
    //Ex:
    cd Downloads
Cria pasta/diretório:

    mkdir nome_da_pasta
Lista conteudo do diretório:

    ls
Arquivos detalhados:

    ls -l
Arquivos ocultos:

    ls -la
    
Exemplo:

    cd Semb1_Workspace_2023_02
    ls
    mkdir aula_01-ta3
    cd aula_01-ta3
Atalho para criar arquivo. Caso já existente, atualiza a data de modificação:

    touch nome_do_arquivo
Abrir editor de texto:

    nano nome_do_arquivo
Exemplo:

    touch main.c
    nano main.c
Compila o programa:

    gcc nome_do_arquivo
Executa o programa:

    ./ nome_do_arquivo
Remove/Deleta o arquivo

    rm nome_do_arquivo
Nomeia o arquivo

    -o
Compila sem linkar. Apenas gera o arquivo objetor .o

    -c
Especificar  a arquitetura  ARM Cortex-M4

    -mcpu=cortex-m4

Alguns processadores ARM podem executar dois conjuntos de instruções distintos,
o conjunto de instruções ARM tradicional de 32-bits (por padrão) e um conjunto de instruções
reduzido de 16-bits denominado Thumb.\
Os processadores ARM Cortex-M suportam apenas o conjunto de instruções Thumb.\
Por padrão o compilador irá gerar o código utilizando o conjunto de instruções ARM. Para alterar este comportamento devemos utilizar a opção:
    
    -mthumb

Solicitar ao compilador para gerar informações de *debug:

    -g

Desabilitar as otimizaçõe:

    -O0

Ligar todos os *warnings a respeito de códigos que podem ser considerados questionáveis e que são de fácil detecção:

    -Wall

Para compilar o arquivo main.c:

    foo@bar$ arm-none-eabi-gcc -c -g -mcpu=cortex-m4 -mthumb -O0 -Wall main.c -o main.o

Exemplo:

    nano main.c
    gcc main.c

Para gerar como resultado do pré-processamento a lista de dependências de um determinado arquivo.:

    -M

Exemplo:

    arm-none-eabi-gcc -M main.c

Para gerar uma lista de depedências contendo apenas arquivos do usário, sem adicionar aquivos cabeçalhos do sistema mencionados direta ou indiretamente:

    -MM

Exemplo:

    arm-none-eabi-gcc -MM main.c

Para salvar a lista de depedências gerada pelo GCC em um arquivo:

    -MF

Exemplo:

    arm-none-eabi-gcc -MM -MF .deps/main.d main.c

O comando abaixo gera um arquivo contendo a lista de depedências ao invés de compilar o arquivo fonte.

    cat .deps/main.d

Para gerar a lista de depedências como subproduto do processo de compilação:

    -MMD

### No editor de texto:
Criando a função main:

    // # : Diretiva de pré compilação
    #include <stdio.h>
    
    int main(int argc, char *argv[])
    {
      printf("argc: %d\n", argc);
      printf("argv[0]: %s\n", *argv);
      printf("argv[1]: %s\n", *(argv[1]));
      return 0;
    }
Comentários:

    //
    /* */

----

## Lab 02:
* Piscar Led \
https://github.com/daniel-p-carvalho/ufu-semb1-lab-02/blob/master/Blinky%2001.md

* Algumas Video Aula:

  1 - Bare metal embedded lecture-1: Build process \
https://youtu.be/qWqlkCLmZoE?si=mn5yDnJYudQ1PpZH
 
  2 - Bare metal embedded lecture-2: Makefile and analyzing relocatable obj file \
https://youtu.be/Bsq6P1B8JqI?si=yuNLPj3JQ-2IT1yo
 
  3 - Bare metal embedded lecture-3: Writing MCU startup file from scratch \
https://youtu.be/2Hm8eEHsgls?si=c27MpZ47ApiMSwHR
 
  15 - Lecture 15: Booting Process \
https://youtu.be/3brOzLJmeek?si=MsHRUEJP8zofjwJQ

* Artigo Embedded Artistry - A General Overview of What Happens Before main(): \
https://embeddedartistry.com/blog/2019/04/08/a-general-overview-of-what-happens-before-main/

Abrir VScode por linha de comando:

    code .
No **Vscode**:

    #include <stdlib.h>

    //#define DEU_CERTO 0

    int main(int argc, char *argv[])
    {
     //return DEU_CERTO;
    }

No **Terminal Linux**:

    gcc main.c -0 nome_que_eu_quiser
    ls

    ./ main

    arm-none-eabi-gcc main.c -o main

    // Arquivo objeto
    arm-none-eabi-gcc -c main.c -o main.o
Arquivos objetos são arquivos binários que podem ser linkados ou executados. \
Armazena instruções que é uma operação que o processador é capaz de fazer (soma, sub, mover, etc...). \
Armazena a sequencia de instruções para excecutar um progrmama.

    // Mostra instruções
    arm-none-eabi -objdump -h main.o
    // Listar sections
    arm-none-eabi-objdump -h main.o
    // Detalhe do Armazenamento
    arm-none-eabi-objdump -s -j .data main.o
    arm-none-eabi-gcc -mcpu-cortex-m4 -mthumb -c -O0 -Wall main.c
    
----

## Lab 03:
Continuação Piscar Led. \
O que acontece antes da main \
Startup: Inicialização \
As primeiras 16 posições de memoria do cortex-m4 devem ser reservadas do 0 ao 8C \
Memoria não volatil (flash) \
No inicio: \
.ISR_VECTORS 0x0800 0000 \
.TEXT \
.DATA \
.RODATA \

----

## Lab 04:
Continuação Piscar Led. \
Arquivo main.c e startup.c estão na pasta Lab 02 do linux \
Criação do arquivo Makefile

    arm-none-eabi-gcc -c -mcpu=cortex-m4 -mthumb -O0 -Wall startup.c -o startup.o

## Lab 05:

RCC (reset and clock control): periférico que configura o clock, liga desliga o microcontrolador.
periférico chave: usa o tempo inteiro.

## Lab 06: 

Finalizar programa para piscar LED. 

Pelo esquemático o transistor N-MOS aberto acende o LED (Modo push-pull) ou (Open drain).

## Lab 07:

Utilizaremos Cube IDE para piscar Led





