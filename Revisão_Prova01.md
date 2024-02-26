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

  A memória stack ou pilha é uma estrutura de dados LIFO (Last-in First-out) que armazena dados temporários e informaçoes de contexto relacionados a execução de funçoes e métodos em um programa. Os dados na stack podem ser acessados através do stack pointer. A stack armazena as variáveis locais de funçoes e informaçoes de contexto, como o endereço de retorno da função e o valor do stack ponter antes da chamada da função.
  
  A stack é utilizada para armazenar o estado de cada chamada recursiva em uma função. Também armazena os operandos e operadores durante a avaliação de expressoes aritmeticas. É utilizada para gerenciar a alocação e desalocaçao de memoria dinamica.

#### (B) A qual tipo de memória a stack está relacionada?

  Está relacionada a memória volátil (RAM) que permite leitura e escrita de dados, ela armazena dados que precisam ser sacessados rapidamente, como variáveis locais, parametros de funçoes e informaçoes de contexto. A memória volátil perde seus dados quando a energia é desligada, logo a stack precisa ser reinicializada a cada vez que o programa é executado.

#### (C) Qual o registro do Cortex M faz o controle de pilha e qual a diferença entre MSP e PSP?

  O Stack Pointer (SP) também conhecido como R13 é quem faz o controle da pilha. Ele armazena o endereço da última celula utilizada na pilha, indica a próxima celula disponivel para alocação na pilha. É incrementado quando há empilhamento (push) e decrementado quando há desempilhamento (pop).

  MSP (main stack pointer) é o ponteiro principal, usado por padrão para o modo de thread e interrupções, é mais eficiente para tarefas curtas, pois não requera troca de contexto entre diferentes tarefas.

  PSP (process stack ponter) é o ponteiro de processo, usado para o modo handler, usado para executar tarefas em um sistema multitarefa. Cada tarefa tem seu próprio PSP, que é usado para armazenar o contexto de tarefa. O PSP pode ser mais eficiente para tarefas longas, pois permite que o sistema operacional otimize o uso da memória. Porém é mais complexo de usar.

#### (D) Como a pilha cresce e diminui durante a execução de um programa?

  A pilha cresce quando uma função é chamada, ela armazena o contexto da função, inclui o valor do SP, as variáveis locais da função e os parametros da função. A instrução push coloca um valor na pilha incrementando o SP.

  A pilha diminui quando uma função termina, removendo o contexto da função, liberando a memória utilizada. A instrução pop remove um valor da pilha, decrementando o SP.

#### (E) Cite pelo menos duas situações em que um estouro de pilha pode ocorrer. Ilustre estas situações apresentando trecho de código escrito em linguagem C.

  O estouro de pilha (stack overflow) ocorre quando a pilha cresce além do seu tamanho limite. 
  
  Isso pode ocorrer por meio de uma recursão infinita, onde uma função recursiva nunca termina e consome toda a memória disponivel na pilha, levando a um estouro.

    void funcao(int n) {
      if (n > 0) {
        funcao(n - 1);
      }
    }
    
    int main() {
      funcao(10000);
      return 0;
    }

  Alocar muitas variáveis na pilha, especialmente grandes arrays ou estruturas, pode consumir toda a memória disponível.

    int main() {
      int array[1000000]; // Alocação de um array grande
      // ...
    }

  Passar grandes arrays ou estruturas como parametros para funções pode consumir muita memória na pilha.

    void funcao(int array[1000000]) {
      // ...
    }
    
    int main() {
      int array[1000000];
      funcao(array);
      return 0;
    }

  Erros no código, como loops infinitos ou acessos inválidos a memória, podem levar a um estouro de pilha.

    int main() {
      int *ptr = NULL;
      *ptr = 10; // Acesso inválido à memória
      return 0;
    }

  O processamento de interrupções pode consumir memória na pilha, especialmente se as interrupções forem frequentes ou complexas.

    void ISR_Handler() {
      // ...
      // Alocação de memória na pilha durante a interrupção
      // ...
    }
    
    int main() {
      // ...
    }

  Em sistemas multitarefa, cada tarefa pode ter sua próprio pilha. Se uma tarefa consumir muita memória na pilha, pode ocorrer um estouro.


### Como o periférico NVIC prioriza as exceções? Descreva o mecanismo detalhadamente considerando um processador com 16 níveis de prioridade, explique também sobre o que são as interrupções não mascaraveis e como são usadas no Cortex M.

  O NVIC prioriza as exceções usando um esquema de prioridade programável. Cada fonte de interrupçõa tem um nível de prioridade associado, que determina qual interrupção será atendida primeiro em caso de múltiplas interrupções simulâneas.

  Para um processador com 16 níveis de prioridade, o nível de prioridade 0 é o mais baixo, enquanto o 15 é o mais alto. As fontes de interrupção com prioridade mais alta serão atendidas antes das fontes de interrupção com baixa prioridade.

  As interrupções não mascaráveis (NMI - non-maskable interrupt) são eventos de alta prioridade que não podem ser desabilitadas por software. Elas são usadas para lidar com eventos críticos que exigem atenção imediata do processador.

  A NMI tem o nível de prioridade mais alto no sistema, superior a todas as interrupções mascaráveis. Ou seja, não podem ser mascaradas por software e sempre serão atendidas pelo processador, mesmo que as interrupções estejam desabilitadas.

  As NMI são utilizadas para lidar com situações criticas que exigem atenção imediata do processador, como falhas de hardware (erros de memória, falhas de clock, etc), detecção de intrusão, violações de acesso à memória e timeout do watchdog.

### Complete o Trecho do codigo disponibilizado abaixo de tal forma que ao final de sua execução a fonte de clock HSE(High Speed External) esteja habilitada e pronta para ser utilizada.

  Passo 1: Configurar os pinos do cristal HSE.
  Pinos PH0-OSC_IN e PH1-OSC_OUT

  Configurar os pinos como GPIO e configurar como entrada

  Passo 2: habilitar o clock HSE no RCC.
  Acessar o registrador RCC_CR (RCC - Clock control Register)
  Definir HSEON para 1
  Aguardar até que HSERDY esteja definido para 1, indicando que o clock HSE está estabilizado.

  Passo 3: Selecionar o clock HSE como clock do sistema
  Acessar o registrador RCC_CGFR
  Definir o campo SW para 1, selecionando o clock HSE como clock do sistema.

  
  Código:

    void stm32_clockconfig(void)
    {

      /* Habilita HSE Clock( RCC CR )*/
      RCC_CR |= RCC_CR_HSEON;



      /* aguarda HSE ficar pronta */
      while ((RCC_CR & RCC_CR_HSERDY) == 0);

      // Selecionar o clock HSE como clock do sistema
      RCC->CFGR &= ~RCC_CFGR_SW;
      RCC->CFGR |= RCC_CFGR_SW_HSE;


    }
