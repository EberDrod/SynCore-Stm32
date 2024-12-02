#!/bin/bash

# Solicitar el nombre del proyecto al usuario
read -p "Introduce el nombre del proyecto STM32: " PROJECT_NAME

# Validar que se haya proporcionado un nombre
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: No se proporcionó un nombre para el proyecto. Intenta de nuevo."
    exit 1
fi

# Crear la estructura de directorios
mkdir -p $PROJECT_NAME/Inc
mkdir -p $PROJECT_NAME/Src

# Crear los archivos en la carpeta Inc/
cat <<EOF > $PROJECT_NAME/Inc/stm32f4xx.h
#ifndef __STM32F4XX_H
#define __STM32F4XX_H

// Incluir headers necesarios
#include "stm32f4xx_hal.h"

#endif // __STM32F4XX_H
EOF

cat <<EOF > $PROJECT_NAME/Inc/stm32f4xx_hal.h
#ifndef __STM32F4XX_HAL_H
#define __STM32F4XX_HAL_H

#include <stdint.h>
#include "stm32f4xx.h"

// Prototipos básicos
void HAL_Init(void);
void HAL_Delay(uint32_t delay);

#endif // __STM32F4XX_HAL_H
EOF

cat <<EOF > $PROJECT_NAME/Inc/main.h
#ifndef __MAIN_H
#define __MAIN_H

#include "stm32f4xx_hal.h"

// Prototipos de funciones
void SystemClock_Config(void);
void GPIO_Init(void);

#endif // __MAIN_H
EOF

# Crear los archivos en la carpeta Src/
cat <<EOF > $PROJECT_NAME/Src/main.c
#include "main.h"

int main(void)
{
    HAL_Init();
    SystemClock_Config();
    GPIO_Init();

    while (1)
    {
        HAL_GPIO_TogglePin(GPIOA, GPIO_PIN_5);
        HAL_Delay(500);
    }
}

void GPIO_Init(void)
{
    __HAL_RCC_GPIOA_CLK_ENABLE();

    GPIO_InitTypeDef GPIO_InitStruct = {0};
    GPIO_InitStruct.Pin = GPIO_PIN_5;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
}

void SystemClock_Config(void)
{
    // Configuración del reloj del sistema
}
EOF

cat <<EOF > $PROJECT_NAME/Src/stm32f4xx_hal.c
#include "stm32f4xx_hal.h"

// Implementación básica de HAL
void HAL_Init(void) {
    // Configuración inicial del hardware
}

void HAL_Delay(uint32_t delay) {
    // Implementación básica de retardo
    for (uint32_t i = 0; i < delay * 1000; i++) {
        __asm__("nop");
    }
}
EOF

cat <<EOF > $PROJECT_NAME/Src/system_stm32f4xx.c
#include "stm32f4xx.h"

// Configuración del sistema
void SystemInit(void) {
    // Inicializar relojes y memoria
}
EOF

# Crear archivo de inicio
cat <<EOF > $PROJECT_NAME/startup_stm32f401xx.s
// Archivo de inicio para STM32F401 (ejemplo mínimo)
.section .isr_vector, "a"
.global g_pfnVectors
g_pfnVectors:
    .word  _estack
    .word  Reset_Handler
    .word  NMI_Handler
    .word  HardFault_Handler

// Handlers
Reset_Handler:
    b .
NMI_Handler:
    b .
HardFault_Handler:
    b .
EOF

# Crear Makefile
cat <<EOF > $PROJECT_NAME/Makefile
CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m4 -mthumb -Wall -g -O2 -IInc -I/usr/local/Cellar/arm-none-eabi-gcc/14.2.0/lib/gcc/arm-none-eabi/14.2.0/include
LDFLAGS = -TSTM32F401RE.ld

SRCS = Src/main.c Src/stm32f4xx_hal.c Src/system_stm32f4xx.c
OBJS = \$(SRCS:.c=.o)

TARGET = \$(PROJECT_NAME).elf

all: \$(TARGET)

\$(TARGET): \$(OBJS)
	\$(CC) \$(CFLAGS) \$(OBJS) \$(LDFLAGS) -o \$@

%.o: %.c
	\$(CC) \$(CFLAGS) -c \$< -o \$@

clean:
	rm -f \$(OBJS) \$(TARGET)
EOF

echo "Proyecto $PROJECT_NAME generado exitosamente."

