/**
  ******************************************************************************
  * @file    stm32l0538_discovery.h
  * @author  MCD Application Team
  * @version V1.2.1
  * @date    27-July-2015
  * @brief   This file contains definitions for STM32L0538-DISCO Kit Leds, push-
  *          buttons hardware resources.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT(c) 2015 STMicroelectronics</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM32L0538_DISCOVERY_H
#define __STM32F0538_DISCOVERY_H

#ifdef __cplusplus
 extern "C" {
#endif
                     
/* Includes ------------------------------------------------------------------*/
#include "stm32l0xx_hal.h"

/** @addtogroup BSP
  * @{
  */

/** @addtogroup STM32L0538_DISCOVERY
  * @{
  */

/** @addtogroup STM32L0538_DISCOVERY_LOW_LEVEL
  * @{
  */

/** @defgroup STM32L0538_DISCOVERY_LOW_LEVEL_Exported_Types
  * @{
  */
typedef enum
{
  LED3 = 0,
  LED4 = 1
} Led_TypeDef;

typedef enum
{
  BUTTON_KEY = 0
} Button_TypeDef;

typedef enum
{
  BUTTON_MODE_GPIO = 0,
  BUTTON_MODE_EXTI = 1
} ButtonMode_TypeDef;

/**
  * @}
  */

/** @defgroup STM32L0538_DISCOVERY_LOW_LEVEL_Exported_Constants
  * @{
  */

/**
  * @brief  Define for STM32L0538_DISCO board
  */
#if !defined (USE_STM32L0538_DISCO)
 #define USE_STM32L0538_DISCO
#endif

/** @addtogroup STM32L0538_DISCOVERY_LOW_LEVEL_LED
  * @{
  */
#define LEDn                                    2

#define LED3_PIN                                GPIO_PIN_4
#define LED3_GPIO_PORT                          GPIOB
#define LED3_GPIO_CLK_ENABLE()                  __HAL_RCC_GPIOB_CLK_ENABLE()
#define LED3_GPIO_CLK_DISABLE()                 __HAL_RCC_GPIOB_CLK_DISABLE()

#define LED4_PIN                                GPIO_PIN_5
#define LED4_GPIO_PORT                          GPIOA
#define LED4_GPIO_CLK_ENABLE()                  __HAL_RCC_GPIOA_CLK_ENABLE()
#define LED4_GPIO_CLK_DISABLE()                 __HAL_RCC_GPIOA_CLK_DISABLE()

#define LEDx_GPIO_CLK_ENABLE(__INDEX__)         do {if(__INDEX__ == 0) LED3_GPIO_CLK_ENABLE(); else LED4_GPIO_CLK_ENABLE();} while (0)   
#define LEDx_GPIO_CLK_DISABLE(__INDEX__)        (((__INDEX__) == 0) ? LED3_GPIO_CLK_DISABLE() : LED4_GPIO_CLK_DISABLE())

/**
  * @}
  */

/** @addtogroup STM32L0538_DISCOVERY_LOW_LEVEL_BUTTON
  * @{
  */
#define BUTTONn                                 1

/**
 * @brief Wakeup push-button
 */
#define KEY_BUTTON_PIN                          GPIO_PIN_0
#define KEY_BUTTON_GPIO_PORT                    GPIOA
#define KEY_BUTTON_GPIO_CLK_ENABLE()            __HAL_RCC_GPIOA_CLK_ENABLE()
#define KEY_BUTTON_GPIO_CLK_DISABLE()           __HAL_RCC_GPIOA_CLK_DISABLE()
#define KEY_BUTTON_EXTI_LINE                    GPIO_PIN_0
#define KEY_BUTTON_EXTI_IRQn                    EXTI0_1_IRQn

#define BUTTONx_GPIO_CLK_ENABLE(__INDEX__)      do {KEY_BUTTON_GPIO_CLK_ENABLE();} while(0)
#define BUTTONx_GPIO_CLK_DISABLE(__INDEX__)     (KEY_BUTTON_GPIO_CLK_DISABLE())
/**
  * @}
  */

/*############################### SPI1 #######################################*/   
#define DISCOVERY_SPIx                          SPI1
#define DISCOVERY_SPIx_CLK_ENABLE()             __HAL_RCC_SPI1_CLK_ENABLE()
#define DISCOVERY_SPIx_GPIO_PORT                GPIOB                      /* GPIOB */
#define DISCOVERY_SPIx_AF                       GPIO_AF0_SPI1
    
#define DISCOVERY_SPIx_GPIO_CLK_ENABLE()        __HAL_RCC_GPIOB_CLK_ENABLE()
#define DISCOVERY_SPIx_GPIO_CLK_DISABLE()       __HAL_RCC_GPIOB_CLK_DISABLE()
    
#define DISCOVERY_SPIx_SCK_PIN                  GPIO_PIN_3                 /* PB.03 */
#define DISCOVERY_SPIx_MISO_PIN                 GPIO_PIN_4                 /* PB.04 */
#define DISCOVERY_SPIx_MOSI_PIN                 GPIO_PIN_5                 /* PB.05 */    

/* Maximum Timeout values for flags waiting loops. These timeouts are not based
   on accurate values, they just guarantee that the application will not remain
   stuck if the SPI communication is corrupted.
   You may modify these timeout values depending on CPU frequency and application
   conditions (interrupts routines ...). */
#define SPIx_TIMEOUT_MAX              ((uint32_t)0x1000)

/*################################ EPD #######################################*/ 
/* Chip Select macro definition */
#define EPD_CS_LOW()            HAL_GPIO_WritePin(EPD_CS_GPIO_PORT, EPD_CS_PIN, GPIO_PIN_RESET)
#define EPD_CS_HIGH()           HAL_GPIO_WritePin(EPD_CS_GPIO_PORT, EPD_CS_PIN, GPIO_PIN_SET)

/* EPD Data/Command macro definition */
#define EPD_DC_LOW()            HAL_GPIO_WritePin(EPD_DC_GPIO_PORT, EPD_DC_PIN, GPIO_PIN_RESET)
#define EPD_DC_HIGH()           HAL_GPIO_WritePin(EPD_DC_GPIO_PORT, EPD_DC_PIN, GPIO_PIN_SET)

/* EPD Reset macro definition */
#define EPD_RESET_LOW()         HAL_GPIO_WritePin(EPD_RESET_GPIO_PORT, EPD_RESET_PIN, GPIO_PIN_RESET)
#define EPD_RESET_HIGH()        HAL_GPIO_WritePin(EPD_RESET_GPIO_PORT, EPD_RESET_PIN, GPIO_PIN_SET)

/* EPD PWR macro definition */
#define EPD_PWR_LOW()           HAL_GPIO_WritePin(EPD_PWR_GPIO_PORT, EPD_PWR_PIN, GPIO_PIN_RESET)
#define EPD_PWR_HIGH()          HAL_GPIO_WritePin(EPD_PWR_GPIO_PORT, EPD_PWR_PIN, GPIO_PIN_SET)

/**
  * @brief  EPD Control pin
  */
#define EPD_CS_PIN                              GPIO_PIN_15
#define EPD_CS_GPIO_PORT                        GPIOA
#define EPD_CS_GPIO_CLK_ENABLE()                __HAL_RCC_GPIOA_CLK_ENABLE()
#define EPD_CS_GPIO_CLK_DISABLE()               __HAL_RCC_GPIOA_CLK_DISABLE()

/**
  * @brief  EPD Command/data pin
  */
#define EPD_DC_PIN                              GPIO_PIN_11
#define EPD_DC_GPIO_PORT                        GPIOB
#define EPD_DC_GPIO_CLK_ENABLE()                __HAL_RCC_GPIOB_CLK_ENABLE()
#define EPD_DC_GPIO_CLK_DISABLE()               __HAL_RCC_GPIOB_CLK_DISABLE()

/**
  * @brief  EPD Reset pin
  */
#define EPD_RESET_PIN                           GPIO_PIN_2
#define EPD_RESET_GPIO_PORT                     GPIOB
#define EPD_RESET_GPIO_CLK_ENABLE()             __HAL_RCC_GPIOB_CLK_ENABLE()
#define EPD_RESET_GPIO_CLK_DISABLE()            __HAL_RCC_GPIOB_CLK_DISABLE()

/**
  * @brief  EPD Busy pin
  */
#define EPD_BUSY_PIN                            GPIO_PIN_8
#define EPD_BUSY_GPIO_PORT                      GPIOA
#define EPD_BUSY_GPIO_CLK_ENABLE()              __HAL_RCC_GPIOA_CLK_ENABLE()
#define EPD_BUSY_GPIO_CLK_DISABLE()             __HAL_RCC_GPIOA_CLK_DISABLE()

/**
  * @brief  EPD PWR pin
  */
#define EPD_PWR_PIN                             GPIO_PIN_10
#define EPD_PWR_GPIO_PORT                       GPIOB
#define EPD_PWR_GPIO_CLK_ENABLE()               __HAL_RCC_GPIOB_CLK_ENABLE()
#define EPD_PWR_GPIO_CLK_DISABLE()              __HAL_RCC_GPIOB_CLK_DISABLE()
/**             
  * @}
  */

/** @defgroup STM32L0538_DISCOVERY LOW_LEVEL_Exported_Macros
  * @{
  */
/**
  * @}
  */

/** @defgroup STM32L0538_DISCOVERY LOW_LEVEL_Exported_Functions
  * @{
  */
uint32_t  BSP_GetVersion(void);
void      BSP_LED_Init(Led_TypeDef Led);
void      BSP_LED_On(Led_TypeDef Led);
void      BSP_LED_Off(Led_TypeDef Led);
void      BSP_LED_Toggle(Led_TypeDef Led);
void      BSP_PB_Init(Button_TypeDef Button, ButtonMode_TypeDef ButtonMode);
uint32_t  BSP_PB_GetState(Button_TypeDef Button);

#ifdef __cplusplus
}
#endif

#endif /* __STM32L0538_DISCOVERY_H */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
