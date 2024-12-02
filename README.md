Preview Project

BlinkLED/
├── Inc/
│   ├── stm32f4xx.h
│   ├── stm32f4xx_hal.h
│   └── main.h
├── Src/
│   ├── main.c
│   ├── stm32f4xx_hal.c
│   └── system_stm32f4xx.c
├── Makefile
└── startup_stm32f401xx.s


Descripción de Archivos
Inc/: Contiene los archivos de encabezado (.h) necesarios para el proyecto.
Src/: Contiene los archivos fuente (.c) que implementan la lógica del programa.
Makefile: Archivo que define cómo compilar el proyecto.
startup_stm32f401xx.s: Archivo de inicio específico para el microcontrolador STM32F401.
Requisitos Previos
Asegúrate de tener instalado lo siguiente:

GNU Arm Embedded Toolchain: Puedes instalarlo usando Homebrew en macOS con el siguiente comando:

bash
Copiar código
brew install arm-none-eabi-gcc
Make: Generalmente ya está instalado en macOS y la mayoría de las distribuciones de Linux.

Compilación del Proyecto
Abre una terminal.

Navega al directorio del proyecto:

bash
Copiar código
cd /ruta/a/BlinkLED
Asegúrate de reemplazar /ruta/a/BlinkLED con la ruta real donde está tu proyecto.

Compila el proyecto usando make:

bash
Copiar código
make
Esto generará un archivo ejecutable llamado BlinkLED.elf en el directorio del proyecto. Si hay errores de compilación, verifica que todos los archivos necesarios estén en su lugar y que el Makefile esté configurado correctamente.

Para limpiar los archivos objeto y el ejecutable, puedes usar:

bash
Copiar código
make clean
Carga del Programa en el Microcontrolador
Para cargar el archivo BlinkLED.elf en tu microcontrolador STM32, necesitarás usar un programador compatible como ST-Link. Puedes usar herramientas como STM32CubeProgrammer o OpenOCD. Aquí hay un ejemplo usando STM32CubeProgrammer:

Abre STM32CubeProgrammer.
Conecta tu dispositivo a través de ST-Link.
Selecciona la opción para cargar un archivo binario o ELF.
Selecciona BlinkLED.elf y carga el programa en tu microcontrolador.
Problemas Comunes
No se encuentra stdint.h: Si ves un error indicando que stdint.h no se encuentra, asegúrate de que el arm-none-eabi-gcc esté correctamente instalado y que el Makefile incluya las rutas adecuadas a las bibliotecas estándar.

No se encuentra el Makefile: Asegúrate de estar en el directorio correcto donde se encuentra el Makefile al ejecutar make.
