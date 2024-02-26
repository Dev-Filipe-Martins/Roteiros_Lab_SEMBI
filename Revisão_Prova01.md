# Revisão Prova 01 - SEMB I

### Descreva sucintamente o procedimento de reset dos microcontroladores da familia STM32. Qual o papel dos pinos BOOT0 e BOOT1 nesse processo?

  Existem quatro tipos principais de reset para os microcontroladores STM32:

  O reset por pino, que é realizado através do pino NRST do microcontrolador. Ao pressionar e segurar o pino por um tempo mínimo força o reset do microcontrolador.

  O reset de POR (Power-On Reset) e PDR (Power-Down Reset) que é realizado automaticamente quando o microcontrolador é ligado ou quando a alimentação é restaurada após uma queda de energia. Esse reset garante que o microcontrolador esteja em um estado conhecido após a inicialização.

  O reset por dois timers de watch dog IWDG (Independent Watchdog) e WWDG (Window Watchdog). O IWDG é um watchdog de contagem regressiva que gera um reset se não for recarregado periodicamente pelo software e o WWDG é um watchdog de janela que gera um reset se o valor do contador sair de uma faixa específica.

  O reset de software é realizado por uma instrução específica do conjunto de instruções do microcontrolador. Esta instrução força o microcontrolador a reiniciar a partir do endereço de reset. Esse reset de software é útil para reiniciar o sistema de forma controlada pelo software.

  O processo de reset dentro do processador é um procedimento complexo que envolve várias etapas. O tipo de reset (POR/PDR, watchdog, software, etc.) pode influenciar o processo.

  Primeiro o sinal de reset é iniciado por algum dos modos descritos acima. Com isso, o sinal de reset força a inicialização de diversos blocos de hardware do processador, incluindo: registradores de controle, unidade de controle, unidade lógica e aritmética, barramentos internos e memórias.

  O endereço de início da execução após o reset é armazenado em um local específico da memória, chamado de vetor de reset. O conteúdo do vetor de reset é carregado no registrador de contador de programa (PC), que determina o próximo endereço de instrução a ser executado.

  O código localizado no endereço de reset é executado. Este código é geralmente chamado de rotina de reset ou firmware de inicialização. A rotina de reset inicializa as variaveis globais, configura os periféricos, calibra o hardware e carrega o sistema operacional.

  Os pinos BOOT0 e BOOT1, são usados para configurar o modo de inicialização do dispositivo. ele permite que o usuario selecione entre diferentes opçoes de inicialização, como:
  - Inicialização normal: O microcontrolador inicia a partir do endereço de reset padrão na memória interna.
  - Inicialização a partir da memória externa: O microcontrolador inicia a partir de um endereço específico na memória externa, como uma EEPROM ou flash SPI.
  - Modo de bootloader: O microcontrolador entra em um modo especial que permite a programação da memória interna através de uma interface serial.

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
