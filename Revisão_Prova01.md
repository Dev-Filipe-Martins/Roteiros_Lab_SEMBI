# Revisão Prova 01 - SEMB I

### Descreva sucintamente o procedimento de reset dos microcontroladores da familia STM32. Qual o papel dos pinos BOOT0 e BOOT1 nesse processo?


### Sobre a região de memória stack (pilha) responda:
#### (A) O que é, e em que situação a stack é utilizada?

#### (B) A qual tipo de memória a stack está relacionada?

#### (C) Qual o registro do Cortex M faz o controle de pilha e qual a diferença entre MSP e PSP?

  MSP (main stack pointer)

  PSP (process stack ponter)

#### (D) Como a pilha cresce e diminui durante a execução de um programa?

#### (E) Cite pelo menos duas situações em que um estouro de pilha pode ocorrer. Ilustre estas situações apresentando trecho de código escrito em linguagem C.


### Como o periférico NVIC prioriza as exceções? Descreva o mecanismo detalhadamente considerando um processador com 16 níveis de prioridade, explique também sobre o que são as interrupções não mascaraveis e como são usadas no Cortex M.

### Complete o Trecho do codigo disponibilizado abaixo de tal forma que ao final de sua execução a fonte de clock HSE(High Speed External) esteja habilitada e pronta para ser utilizada.

  Código:

    void stm32_clockconfig(void)
    {

    /* habilita HSE Clock( RCC CR*/




    /* aguarda HSE ficar pronta */


    }
