#******************************************************************************
# Copyright (C) 2024 by Yannick DAHAN
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. 
#
#*****************************************************************************

#------------------------------------------------------------------------------
# <Put a Description Here>
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <Put a description of the supported targets here>
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk

TARGET ?= c1m2

# BEGIN Parameters selection depending on native / cross compiling
ifeq ($(PLATFORM),HOST)
# gcc function 
CC = gcc
SIZE = size
OBJDUMP = objdump 
# Platfrom / architecture parameters 
PLATFORM_TARGET =-DHOST
ARCH_FLAGS = 
# Linker parameters 
LDFLAGS = -Wl,-Map=$(TARGET).map 

else ifeq ($(PLATFORM),MSP432)
# gcc function 
CC = arm-none-eabi-gcc
SIZE = arm-none-eabi-size
OBJDUMP = arm-none-eabi-objdump
# Platfrom / architecture parameters 
PLATFORM_TARGET=-DMSP432
ARCH_FLAGS = -mcpu=cortex-m4 \
			 -mthumb \
			 -march=armv7e-m \
			 -mfloat-abi=hard \
			 -mfpu=fpv4-sp-d16 \
			 --specs=nosys.specs \
# Linker parameters 
LINKER_FILE =../msp432p401r.lds
LDFLAGS = -Wl,-Map=$(TARGET).map -T $(LINKER_FILE)

else 
	$(error Platform not supported: $(PLATFORM))

endif 
# END Parameters selection depending on native / cross compiling




# Common Parameters for compiling
CFLAGS = -Wall -Werror -g -O0 -std=c99 -Wno-attributes
DEPFLAGS = -MMD -MP -MF$(@:.o=.d)
CPPFLAGS = $(INCLUDES)

# Variable for files selection
DEPFILES = $(SOURCES:.c=.d)
ASMFILES = $(SOURCES:.c=.asm)
PREPROCFILES = $(SOURCES:.c=.i)
OBJS = $(SOURCES:.c=.o) 



#Generate the object file for all c-source files (but do not link) by specifying the object file you want to compile.
%.o : %.c
	$(CC) -c $< $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) $(DEPFLAGS) $(PLATFORM_TARGET) -o $@
# Generate the preprocessed output of all c-program implementation files
%.i : %.c
	$(CC) -E $< $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) $(PLATFORM_TARGET) -o $@
#Generate assembly output of c-program implementation files 
%.asm : %.c
	$(CC) -S $< $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) $(PLATFORM_TARGET) -o $@



#######
#PHONY#
#######

#Generate assembly output of c-program implementation files and the final output executable 
.PHONY: asm
asm: $(TARGET).asm
$(TARGET).asm: $(OBJS) $(TARGET).out
	$(OBJDUMP) -S $< > $@ 

# Compile all object files and link into a final executable.
.PHONY: build
build: $(TARGET).out

$(TARGET).out: $(OBJS)
	$(CC) $(OBJS) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(DEPFLAGS) $(ARCH_FLAGS) $(PLATFORM_TARGET) -o $@

	@echo "build completed. Generating size report"
	$(SIZE) $(TARGET).out
	@echo "\nTo run the executable, use ./$(TARGET).out"

 
#Compile all object files, but DO NOT link.
.PHONY: compile-all
compile-all: $(OBJS)
%.o : %.C
	$(CC) -c $< $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) $(DEPGLAGS) $(PLATFORM_TARGET) -o $@


#remove all compiled objects, preprocessed outputs, assembly outputs, executable files and build output files.
.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET).out $(TARGET).map $(DEPFILES) $(ASMFILES) $(PREPROCFILES) $(TARGET).asm




