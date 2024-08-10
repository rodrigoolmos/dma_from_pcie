#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <sys/mman.h>
#include <stdint.h>

#define MAP_SIZE 0x20000 /* 1 KB*/
#define N_UINTS  100

#define RAM0_ADDR   0x00000
#define RAM1_ADDR   0x1000

#define DMA_ADDR    0x10000  /*NA*/
#define DMA_STATUS  0x4      /*R*/
#define DMA_SA      0x18     /*R-W*/   
#define DMA_DA      0x20     /*R-W*/
#define DMA_BTT     0x28     /*R-W*/

void write_axi_lite_32b(void *addr, uint32_t offset, uint32_t *value, uint32_t vector_elemnts){

    int i;
    void *virt_addr;

    for (i = 0; i < vector_elemnts; i++){
        virt_addr = addr + offset + sizeof(uint32_t)*i;
        *((uint32_t *) virt_addr) = value[i];
    }
}

void read_axi_lite_32b(void *addr, uint32_t offset, uint32_t *value, uint32_t vector_elemnts){

    int i;
    void *virt_addr;

    for (i = 0; i < vector_elemnts; i++){
        virt_addr = addr + offset + sizeof(uint32_t)*i;
        value[i] = *((uint32_t *) virt_addr);
    }

}

void dma_transaction(void *addr, uint32_t src_addr,  uint32_t dest_addr, uint32_t n_bytes){

    uint32_t busy = 0;

    write_axi_lite_32b(addr, DMA_ADDR + DMA_DA, &dest_addr, 1);

    write_axi_lite_32b(addr, DMA_ADDR + DMA_SA, &src_addr, 1);

    write_axi_lite_32b(addr, DMA_ADDR + DMA_BTT, &n_bytes, 1);

    while (!(busy & 0x02))
        read_axi_lite_32b(addr, DMA_ADDR + DMA_STATUS, &busy, 1);

}

int main() {

    int fd;
    uint32_t dma_bram0_addr = 0;        /*Es casualidad que conincidan con los que ve el pcie*/
    uint32_t dma_bram1_addr = 0x1000;   /*Es casualidad que conincidan con los que ve el pcie*/
    uint32_t bytes_2_tx = N_UINTS * sizeof(uint32_t);
    uint32_t i;

    uint32_t read_data[N_UINTS] = {0};
    uint32_t write_data[N_UINTS] = {0};
    
    void *map_base;
    char *resource_paths = "/sys/bus/pci/devices/0000:01:00.0/resource0";
    

    if ((fd = open(resource_paths, O_RDWR | O_SYNC)) == -1) {
        perror("Error abriendo el dispositivo PCIe");
        exit(1);
    }
    map_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (map_base == (void *) -1) {
        perror("Error en mmap");
        close(fd);
        exit(1);
    }

    close(fd);

    for (i = 0; i < N_UINTS; i++)
        write_data[i] = rand();
     

    write_axi_lite_32b(map_base, RAM0_ADDR, write_data, N_UINTS);

    dma_transaction(map_base, dma_bram0_addr, dma_bram1_addr, bytes_2_tx);

    read_axi_lite_32b(map_base, RAM1_ADDR, read_data, N_UINTS);

    for (i = 0; i < N_UINTS; i++)
        printf("RAM0 data %u,\tRAM1 data %u\n", write_data[i], read_data[i]);

    if (munmap(map_base, MAP_SIZE) == -1) {
        perror("Error en munmap");
    }

    return 0;
}