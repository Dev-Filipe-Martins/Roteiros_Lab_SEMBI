####################################################################################
# Parte 01:

# main.o: main.c
# 	arm-none-eabi-gcc -c -g -mcpu=cortex-m4 -mthumb -O0 -Wall main.c -o main.o

# clean:
# 	rm -f *.o

# Parte 02:

# CC = arm-none-eabi-gcc
# CFLAGS = -g -mcpu=cortex-m4 -mthumb -O0 -Wall

# main.o: main.c
# 	$(CC) -c $(CFLAGS) main.c -o main.o

# clean:
# 	rm -f *.o

# Parte 03:

# CC = arm-none-eabi-gcc
# CFLAGS = -g -mcpu=cortex-m4 -mthumb -O0 -Wall

# all: startup.o main.o

# main.o: main.c
# 	$(CC) -c $(CFLAGS) $< -o $@

# startup.o: startup.c
# 	$(CC) -c $(CFLAGS) $< -o $@

# clean:
# 	rm -f *.o

# Parte 04:

# CC = arm-none-eabi-gcc
# CFLAGS = -g -mcpu=cortex-m4 -mthumb -Wall -O0

# all: startup.o main.o

# %.o: %.c
# 	$(CC) -c $(CFLAGS) $< -o $@

# clean:
# 	rm -f *.o

# Parte 05:

# # Ferramentas do toolchain

# CC = arm-none-eabi-gcc

# # Arquivos a serem compilados

# SRCS = startup.c main.c

# #Flags do compilador e linker

# CFLAGS = -g -mcpu=cortex-m4 -mthumb -Wall -O0

# # Gera uma lista de arquivos objeto utilizando os arquivos fonte

# OBJS = $(patsubst %, %.o, $(basename $(SRCS)))

# all: $(OBJS)

# %.o: %.c
# 	$(CC) -c $(CFLAGS) $< -o $@

# clean:
# 	rm -f *.o

# Parte 06:

# # Ferramentas do toolchain

# CC = arm-none-eabi-gcc
# RM = rm -rf

# # Diretorios arquivos objeto serao salvos

# # OBJDIR = src/build
# OBJDIR = build

# DEPDIR = .deps

# # Arquivos a serem compilados

# SRCS = startup.c  main.c

# #Flags do compilador e linker

# CFLAGS = -g -mcpu=cortex-m4 -mthumb -Wall -O0
# DEPFLAGS = -MMD -MP -MF $(DEPDIR)/$*.d

# # Gera uma lista de arquivos objeto utilizando os arquivos fonte

# OBJS = $(patsubst %, $(OBJDIR)/%.o, $(basename $(SRCS)))

# DEPS = $(patsubst %, $(DEPDIR)/%.d, $(basename $(SRCS)))

# # Cria diretorios onde serao armazenados arquivos objeto

# $(shell mkdir -p $(dir $(OBJS)) > /dev/null)
# $(shell mkdir -p $(dir $(DEPS)) > /dev/null)

# # all: $(OBJS) -C src
# all: $(OBJS)

# $(OBJDIR)/%.o: %.c $(DEPDIR)/%.d
# 	$(CC) -c $(CFLAGS) $(DEPFLAGS) $< -o $@

# $(DEPS):

# # build/main.o: main.c config.h
# # build/startup.o: startup.c
# # build/main.o: main.c config.h

# -include $(DEPS)

# .PHONY: clean
# clean:
# 	$(RM) $(OBJDIR) $(DEPDIR)
