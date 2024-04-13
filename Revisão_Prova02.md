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
    
    /* habilita HSE Clock( RCC CR*/
    
    
    
    
    /* aguarda HSE ficar pronta */
    
    
    }


### O RCC (Reset and Clock Control) é um controlador integrado aos microcontroladores da família STM32 que realiza a gestão e a configuração do clock do sistema e dos periféricos. Além disso, também gerencia os diferentes tipos de reset do dispositivo. A figura abaixo mostra o diagrama esquemático da configuração padrão da árvore de clock do microcontrolador STM32F411CE

#### a) Quantas e quais são as fontes de colck do microcontrolador STM32F411CE? Descreva de forma objetiva as características, utilização e limitaçoes de cada fonte de clock.

#### b) Qual é o objetivo do módulo de geração de clock PLL? Quais são as vantagens de se ter um PLL integrado ao microcontrolador?

#### c) Considerando a estrutura da árvorede clock mostrada acima e a condfiguração indicada na Listagem 1 (board.h) e na documentação fornecida em anexo calcule os valores de:

    |  STM32_PLLCFG_PLLM      |                  |
    |  STM32_PLLCFG_PLLN      |                  |  
    |  STM32_PLLCFG_PLLP      |                  |
    |  STM32_RCC_CFGR_HPRE    |                  |
    |  STM32_RCC_CFGR_PPRE1   |                  |
    |  STM32_RCC_CFGR_PPRE2   |                  |

Observações:
  - o clock do VCO deve ser mantido entre 100MHz e 432MHz.

#### d) Escreva, utilizando a linguagem C, o código necessário para ajustar os registradores do RCC de acordo com a configuração proposta no item C

    void stm32_clockconfig(void)
    {
      /* Habilita High Speed External Clock - HSE (STM32_RCC_CR) */

      /* Aguarda HSE ficar pronto  */

      /* Ajusta o divisor do HCLK (STM32_RCC_CFGR) */

      /* Ajusta o divisor do PCLK2 (STM32_RCC_CFGR) */

      /* Ajusta o divisor do PCLK1 (STM32_RCC_CFRG) */

      /* Ajusta os divisores e multiplicadores do PLL (STM32_RCC_PLLCFG) */

      /* Habilita PLL (STM32_RCC_CR) */

      /* Aguarda PLL ficar pronto */
      
    }

### Utilizando como referencia os códigos das listagens fornecidas em anexo. Implemente, utilizando linguagem C, a função stm32_gpio_write(uint32_t pinset, bool value).

        void stm32_gpio_write (uint32_t pinset, bool value)
        {


        
        }

### No Anexo IV são apresentados os ciclos de escrita e leitura de byte de uma memória EEPROM modelo 24CS512 que utiliza o barramento I2C para se comunicar com o mestre. Essa memória possui 512 kbits organizados em 65536 palavras de 8bits (D0 a D7), exigindo, dessa forma, um endereço de acesso de 16 bits (A0 a A15, word address bytes 1 e 2). Outra característica dessa memória é permitir que parte do seu endereço I2C seja personalizado através de 3 pinos, representados pelos valores A2, A1 e A0 na fase de endereçamento do escravo (device address byte, não confundir com o endereço de memória descrito anteriormente). A figura abaixo apresenta o diagrama esquemáttico da conxão da memória com o microcontrolador. Além disso, também são detalhadas as funções de cada pino da memória.
### Considerando as informações disponibilizadas no Anexo IV e o diagrama esquemático apresentado faça:

#### a) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de escrita seja gravado o valor 0xAB no endereço 0x89AB.

#### b) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de leitura, seja lido o conteúdo do endereço 0x89AB
OBS: Considere que todas as confirmações do I2C (ACK) foram positivas (sem erro)




### Estudar Debouncing (Matérial no Teams)

