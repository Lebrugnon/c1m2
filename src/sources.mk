#******************************************************************************
# Copyright (C) 2024 by Yannick DAHAN
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. 
#
#*****************************************************************************
ifeq ($(PLATFORM),HOST)

# Add your Source files to this variable
SOURCES = ./main.c \
		  ./memory.c 

INCLUDES = -I  ~/Dahan_Coursera_m2/include/common \

# Add your include paths to this variable


else ifeq ($(PLATFORM),MSP432)
SOURCES = ./main.c \
		  ./memory.c \
		  ./interrupts_msp432p401r_gcc.c \
		  ./startup_msp432p401r_gcc.c \
		  ./system_msp432p401r.c 

INCLUDES = -I  ~/Dahan_Coursera_m2/include/msp432\
			-I  ~/Dahan_Coursera_m2/include/common\
			-I  ~/Dahan_Coursera_m2/include/CMSIS
			 


else 
$(error Platform not supported: $(PLATFORM))
endif
