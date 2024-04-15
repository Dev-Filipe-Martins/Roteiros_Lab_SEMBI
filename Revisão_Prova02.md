### Sobre a região de memória stack(pilha) responda:
#### a) O que é e em que situação a stack é utilizada?

#### b) A qual tipo de memória a stack está relacionada?

#### c) Qual o registro do Cortex M faz o controle da pilha e qual a diferença entre MSP e PSP(main stack pointer e process stack pointer)?

#### d) Como a pilha cresce e diminui durante a execução de um programa?

#### e) Cite pelo menos duas situações em que um estouro de pilha pode ocorrer. Ilustre estas situações apresentado trecho de codigo escrito em linguagem C


### Complete o Trecho do codigo disponibilizado abaixo de tal forma que ao final de sua execução a fonte de clock HSE(High Speed External) esteja habilitada e pronta para ser utilizada.

Código:

    void stm32_clockconfig(void)
    {
    
    /* habilita HSE Clock( RCC CR ) */
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_RCC, ENABLE);
    
    /* aguarda HSE ficar pronta */
    RCC_HSEConfig(RCC_HSE_Bypass);
    RCC_WaitForHSEStartUp();
    RCC_SYSCLKConfig(RCC_SYSCLKSource_HSE)

    /* Atualiza o SystemCoreClock */
    SystemCoreClockUpdate();
    
    }


### O RCC (Reset and Clock Control) é um controlador integrado aos microcontroladores da família STM32 que realiza a gestão e a configuração do clock do sistema e dos periféricos. Além disso, também gerencia os diferentes tipos de reset do dispositivo. A figura abaixo mostra o diagrama esquemático da configuração padrão da árvore de clock do microcontrolador STM32F411CE

#### a) Quantas e quais são as fontes de colck do microcontrolador STM32F411CE? Descreva de forma objetiva as características, utilização e limitaçoes de cada fonte de clock.

HSI (Oscilador RC Interno):

Frequência: 8 MHz (HSI64) ou 16 MHz (HSI16)
Vantagens: Baixo consumo de energia, disponível em todos os STM32
Desvantagens: Imprecisão (até ±2,5%), sensível a ruídos e temperatura
Aplicações: Inicialização do sistema, temporizadores básicos, comunicação de baixa velocidade
HSE (Oscilador RC Externo):

Frequência: Definida por cristal externo (entre 8 MHz e 32 MHz)
Vantagens: Maior precisão que HSI
Desvantagens: Aumento do custo (cristal externo), maior consumo de energia, suscetível a falhas do cristal
Aplicações: Comunicação de alta velocidade, geração de sinais precisos, temporizações críticas
PLL HS (PLL de Alta Velocidade):

Multiplica HSI/HSE por até 16
Frequência: Até 192 MHz
Vantagens: Frequências de clock mais altas
Desvantagens: Maior consumo de energia, maior complexidade, ruído de fase (dependendo da fonte)
Aplicações: Processamento de sinal digital, interfaces de alta velocidade, operações matemáticas complexas
PLL LS (PLL de Baixa Latência):

Multiplica HSE por até 2
Vantagens: Baixa latência de loop
Desvantagens: Maior consumo de energia, faixa de multiplicação limitada (até 2x HSE)
Aplicações: Geração de pulsos precisos, controle de motores, comunicação em tempo real
LSE (Low Speed External):

Frequência: 32 kHz (cristal externo)
Vantagens: Baixo consumo de energia, alta precisão (±0,2%)
Desvantagens: Aumento do custo (cristal externo), frequência fixa
Aplicações: Relógio de tempo real, wake-up de baixa potência, comunicação síncrona de baixa velocidade
Clock de Backup:

Frequência: 32 kHz (LSE ou bateria)
Vantagens: Baixo consumo de energia, alta precisão (±0,2%), alimentado por bateria ou LSE
Desvantagens: Requer fonte de alimentação adicional, frequência fixa
Aplicações: Manter contagem do tempo quando a alimentação principal é removida (relógio de tempo real, backups de dados)

#### b) Qual é o objetivo do módulo de geração de clock PLL? Quais são as vantagens de se ter um PLL integrado ao microcontrolador?

O módulo PLL (Phase-Locked Loop) integrado ao microcontrolador serve como um multiplicador de frequência preciso e flexível, capaz de gerar clocks de alta qualidade para diversas aplicações.

O PLL multiplica a frequência de um clock de referência (geralmente um oscilador de baixa frequência) para obter frequências mais altas, atendendo às demandas de componentes e interfaces que exigem clocks de alta velocidade.

Alta Precisão:

O PLL gera clocks com baixo nível de jitter e ruído de fase, essenciais para aplicações sensíveis ao tempo, como comunicação de dados de alta velocidade, geração de sinais precisos e processamento digital de sinal.
A precisão do clock é crucial para garantir a sincronização correta entre os componentes do sistema e evitar erros de dados ou falhas de operação.
Flexibilidade:

O PLL permite ajustar a frequência de clock de saída com alta resolução, atendendo às necessidades específicas de cada aplicação.
Essa flexibilidade permite que o microcontrolador opere em diferentes modos de desempenho, otimizando o consumo de energia e adaptando-se a diferentes tarefas.
Redução de Custo:

A integração do PLL no microcontrolador elimina a necessidade de componentes externos caros e complexos, como osciladores de alta frequência.
Isso simplifica o projeto da placa de circuito impresso, reduz o custo total do sistema e facilita a miniaturização.
Menor Consumo de Energia:

Em comparação com osciladores de alta frequência, o PLL geralmente consome menos energia, especialmente quando operando em frequências mais baixas.
Essa característica é importante para aplicações que exigem longa vida útil da bateria ou operação com restrições de energia.
Integração Simplificada:

A integração do PLL no microcontrolador simplifica o projeto do sistema, reduzindo a necessidade de componentes externos e conexões complexas.
Isso facilita o desenvolvimento, a depuração e a manutenção do hardware, além de aumentar a confiabilidade do sistema.

#### c) Considerando a estrutura da árvorede clock mostrada acima e a condfiguração indicada na Listagem 1 (board.h) e na documentação fornecida em anexo calcule os valores de:

    |  STM32_PLLCFG_PLLM      |         25        |
    |  STM32_PLLCFG_PLLN      |         168       |  
    |  STM32_PLLCFG_PLLP      |         2         |
    |  STM32_RCC_CFGR_HPRE    |         1         |
    |  STM32_RCC_CFGR_PPRE1   |         2         |
    |  STM32_RCC_CFGR_PPRE2   |         1         |

Observações:
  - o clock do VCO deve ser mantido entre 100MHz e 432MHz.

#### d) Escreva, utilizando a linguagem C, o código necessário para ajustar os registradores do RCC de acordo com a configuração proposta no item C

    void stm32_clockconfig(void)
    {
        /* Habilita High Speed External Clock (HSE) */

        RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_RCC, ENABLE);  // Habilita o clock para o registro de controle do clock (RCC)

        RCC_HSEConfig(RCC_HSE_Bypass);                       // Configura o HSE para usar um bypass externo

        /* Aguarda HSE ficar pronto */
        
        RCC_WaitForHSEStartUp();                           // Aguarda até que o HSE esteja pronto
        RCC_SYSCLKConfig(RCC_SYSCLKSource_HSE);             // Configura o clock do sistema para usar o HSE como fonte

        /* Ajusta o divisor do HCLK (STM32_RCC_CFGR) */

        RCC_CFGR_HPRE(RCC_CFGR_HPRE_Div1);  // Define o divisor do HCLK como 1 (HCLK = SYSCLK)

        /* Ajusta o divisor do PCLK2 (STM32_RCC_CFGR) */

        RCC_CFGR_PPRE2(RCC_CFGR_PPRE2_Div2);  // Define o divisor do PCLK2 como 2 (PCLK2 = HCLK / 2)

        /* Ajusta o divisor do PCLK1 (STM32_RCC_CFGR) */

        RCC_CFGR_PPRE1(RCC_CFGR_PPRE1_Div2);  // Define o divisor do PCLK1 como 2 (PCLK1 = HCLK / 2)

        /* Ajusta os divisores e multiplicadores do PLL (STM32_RCC_PLLCFG) */

        RCC_PLLCFG_PLLM(25);  // Define o divisor PLLM como 25
        RCC_PLLCFG_PLLN(168); // Define o multiplicador PLLN como 168
        RCC_PLLCFG_PLLP(2);   // Define o divisor PLLP como 2

        /* Habilita PLL (STM32_RCC_CR) */

        RCC_PLLCmd(ENABLE);   // Habilita o PLL

        /* Aguarda PLL ficar pronto */

        while (RCC_GetFlagStatus(RCC_FLAG_PLLRDY) == RESET) {}; // Aguarda até que a flag PLLRDY seja definida
    }


    

### Utilizando como referencia os códigos das listagens fornecidas em anexo. Implemente, utilizando linguagem C, a função stm32_gpio_write(uint32_t pinset, bool value).

        void stm32_gpio_write (uint32_t pinset, bool value)
        {


        
        }

        #include "stm32f4xx_hal.h"

        void stm32_gpio_write(uint32_t pinset, bool value) 
        {
            /* Get the GPIO port from the pinset */
            GPIO_TypeDef* port = (GPIO_TypeDef*) ((pinset & 0xFF00) >> 8);
        
            /* Get the pin number within the port */
            uint16_t pin = (uint16_t) (pinset & 0x00FF);
        
            /* Set or reset the pin based on the value */
            if (value) 
            {
                HAL_GPIO_WritePin(port, pin, GPIO_PIN_SET);
            } 
            else 
            {
                HAL_GPIO_WritePin(port, pin, GPIO_PIN_RESET);
            }
        }


### No Anexo IV são apresentados os ciclos de escrita e leitura de byte de uma memória EEPROM modelo 24CS512 que utiliza o barramento I2C para se comunicar com o mestre. Essa memória possui 512 kbits organizados em 65536 palavras de 8bits (D0 a D7), exigindo, dessa forma, um endereço de acesso de 16 bits (A0 a A15, word address bytes 1 e 2). Outra característica dessa memória é permitir que parte do seu endereço I2C seja personalizado através de 3 pinos, representados pelos valores A2, A1 e A0 na fase de endereçamento do escravo (device address byte, não confundir com o endereço de memória descrito anteriormente). A figura abaixo apresenta o diagrama esquemáttico da conxão da memória com o microcontrolador. Além disso, também são detalhadas as funções de cada pino da memória.
### Considerando as informações disponibilizadas no Anexo IV e o diagrama esquemático apresentado faça:

#### a) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de escrita seja gravado o valor 0xAB no endereço 0x89AB.

#### b) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de leitura, seja lido o conteúdo do endereço 0x89AB
OBS: Considere que todas as confirmações do I2C (ACK) foram positivas (sem erro)




### Estudar Debouncing (Matérial no Teams)

