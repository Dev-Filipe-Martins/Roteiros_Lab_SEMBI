
- ## Questão de Programação

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


### Utilizando como referencia os códigos das listagens fornecidas em anexo. Implemente, utilizando linguagem C, a função stm32_gpio_write(uint32_t pinset, bool value).

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


- ## Questão de Clock:

### O RCC (Reset and Clock Control) é um controlador integrado aos microcontroladores da família STM32 que realiza a gestão e a configuração do clock do sistema e dos periféricos. Além disso, também gerencia os diferentes tipos de reset do dispositivo. A figura abaixo mostra o diagrama esquemático da configuração padrão da árvore de clock do microcontrolador STM32F411CE

#### a) Quantas e quais são as fontes de clock do microcontrolador STM32F411CE? Descreva de forma objetiva as características, utilização e limitaçoes de cada fonte de clock.

Em geral, o microcontrolador STM32F411CE possui duas fontes principais de clock: O clock interno e externo. Ambas as fontes são divididas em alta e baixa velocidade.

HSE (High Speed External) -> Fonte de clock de alta velocidade externa.
A frequencia é definida por crital externo (entre 8 e 32 MHz)
Tem maior precisão
Maior custo (cristal externo) e maior consumo de energia

HSI (High Speed Internal) -> Fonte de clock de alta velocidade interna.
Frequencia entre 8 e 16 MHz
Baixo consumo de energia, disponível em todos os STM32
Baixa precisão e sensível a ruídos e temperatura

LSE (Low Speed External) -> Fonte de clock de baixa velocidade externa.
Frequencia definida por cristal externo 32 KHz
Baixo consumo de energia e alta precisão
Maior custo (cristal externo) e frequencia fixa

LSI (Low Speed Internal) -> Fonte de clock de baixa velocidade interna.
Frequencia em KHz
Baixo consumo de energia
Baixa precisão

#### b) Qual é o objetivo do módulo de geração de clock PLL? Quais são as vantagens de se ter um PLL integrado ao microcontrolador?

O módulo PLL (Phase-Locked Loop) serve como um multiplicador de frequência preciso e flexível, capaz de gerar clocks de alta qualidade para diversas aplicações.

O PLL multiplica a frequência de um clock de referência (geralmente um oscilador de baixa frequência) para obter frequências mais altas, atendendo às demandas de componentes e interfaces que exigem clocks de alta velocidade.

Suas vantagens são: Alta precisão, menor consumo de energia, redução de custos.

É capaz de gerar clocks de alta precisão, atendendo as demandas de diversas aplicações. Reduz os custos com o consumo de energia e complexidade do projeto.

#### c) Considerando a estrutura da árvorede clock mostrada acima e a condfiguração indicada na Listagem 1 (board.h) e na documentação fornecida em anexo calcule os valores de:

    |  STM32_PLLCFG_PLLM      |         12        |
    |  STM32_PLLCFG_PLLN      |         96        |  
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


    




### No Anexo IV são apresentados os ciclos de escrita e leitura de byte de uma memória EEPROM modelo 24CS512 que utiliza o barramento I2C para se comunicar com o mestre. Essa memória possui 512 kbits organizados em 65536 palavras de 8bits (D0 a D7), exigindo, dessa forma, um endereço de acesso de 16 bits (A0 a A15, word address bytes 1 e 2). Outra característica dessa memória é permitir que parte do seu endereço I2C seja personalizado através de 3 pinos, representados pelos valores A2, A1 e A0 na fase de endereçamento do escravo (device address byte, não confundir com o endereço de memória descrito anteriormente). A figura abaixo apresenta o diagrama esquemáttico da conxão da memória com o microcontrolador. Além disso, também são detalhadas as funções de cada pino da memória.
### Considerando as informações disponibilizadas no Anexo IV e o diagrama esquemático apresentado faça:

#### a) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de escrita seja gravado o valor 0xAB no endereço 0x89AB.

#### b) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de leitura, seja lido o conteúdo do endereço 0x89AB
OBS: Considere que todas as confirmações do I2C (ACK) foram positivas (sem erro)




### Estudar Debouncing (Matérial no Teams)

    //funcao de interrupcao com debouncing
    void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin){
    	if(GPIO_Pin == INFR_Pin){
    
    		static uint32_t debouncing_ms = 0;
    		if((HAL_GetTick() - debouncing_ms) >= DEBOUNCING){
    			nmoedas++;
    			debouncing_ms = HAL_GetTick();
    		}
    	}
    }




- Questão de Debouncing

- ## Questão de Periférico
  - ## I2c

 ### No Anexo IV são apresentados os ciclos de escrita e leitura de byte de uma memória EEPROM modelo 24CS512 que utiliza o barramento I2C para se comunicar com o mestre. Essa memória possui 512 kbits organizados em 65536 palavras de 8bits (D0 a D7), exigindo, dessa forma, um endereço de acesso de 16 bits (A0 a A15, word address bytes 1 e 2). Outra característica dessa memória é permitir que parte do seu endereço I2C seja personalizado através de 3 pinos, representados pelos valores A2, A1 e A0 na fase de endereçamento do escravo (device address byte, não confundir com o endereço de memória descrito anteriormente). A figura abaixo apresenta o diagrama esquemáttico da conxão da memória com o microcontrolador. Além disso, também são detalhadas as funções de cada pino da memória.
### Considerando as informações disponibilizadas no Anexo IV e o diagrama esquemático apresentado faça:

#### a) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de escrita seja gravado o valor 0xAB no endereço 0x89AB.

#### b) Complete o diagrama abaixo, indicando os valores dos bits na imagem, de forma que no ciclo de leitura, seja lido o conteúdo do endereço 0x89AB
OBS: Considere que todas as confirmações do I2C (ACK) foram positivas (sem erro)


  - ## SPI
 










