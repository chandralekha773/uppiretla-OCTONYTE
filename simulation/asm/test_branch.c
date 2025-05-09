#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define MAX_DUMPS 100

typedef struct {
    unsigned long ra, sp, gp, tp;
    unsigned long t0, t1, t2;
    unsigned long s0, s1;
    unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
    unsigned long s2, s3, s4, s5, s6, s7, s8;
    unsigned long s9, s10, s11;
    unsigned long t3, t4, t5, t6;
} RegisterState;

typedef struct {
    RegisterState states[MAX_DUMPS];
    int count;
} RegisterDump;

void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, ra\n"
        "mv %1, sp\n"
        "mv %2, gp\n"
        "mv %3, tp\n"
        "mv %4, t0\n"
        "mv %5, t1\n"
        "mv %6, t2\n"
        "mv %7, s0\n"
        "mv %8, s1\n"
        "mv %9, a0\n"
        "mv %10, a1\n"
        "mv %11, a2\n"
        "mv %12, a3\n"
        "mv %13, a4\n"
        "mv %14, a5\n"
        "mv %15, a6\n"
        : "=r"(regs->ra), "=r"(regs->sp), "=r"(regs->gp), "=r"(regs->tp),
          "=r"(regs->t0), "=r"(regs->t1), "=r"(regs->t2), "=r"(regs->s0),
          "=r"(regs->s1), "=r"(regs->a0), "=r"(regs->a1), "=r"(regs->a2),
          "=r"(regs->a3), "=r"(regs->a4), "=r"(regs->a5), "=r"(regs->a6)
    );

    __asm__ volatile (
        "mv %0, a7\n"
        "mv %1, s2\n"
        "mv %2, s3\n"
        "mv %3, s4\n"
        "mv %4, s5\n"
        "mv %5, s6\n"
        "mv %6, s7\n"
        "mv %7, s8\n"
        "mv %8, s9\n"
        "mv %9, s10\n"
        "mv %10, s11\n"
        "mv %11, t3\n"
        "mv %12, t4\n"
        "mv %13, t5\n"
        "mv %14, t6\n"
        : "=r"(regs->a7), "=r"(regs->s2), "=r"(regs->s3), "=r"(regs->s4), "=r"(regs->s5),
          "=r"(regs->s6), "=r"(regs->s7), "=r"(regs->s8), "=r"(regs->s9), "=r"(regs->s10),
          "=r"(regs->s11), "=r"(regs->t3), "=r"(regs->t4), "=r"(regs->t5), "=r"(regs->t6)
    );
}

void save_register_dump(const RegisterDump *dump, const char *filename) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("Failed to open file");
        return;
    }

    for (int i = 0; i < dump->count; i++) {
        RegisterState state = dump->states[i];
        fprintf(file, "Dump %d:\n", i + 1);
        fprintf(file, "ra=%lu sp=%lu gp=%lu tp=%lu\n", state.ra, state.sp, state.gp, state.tp);
        fprintf(file, "t0=%lu t1=%lu t2=%lu s0=%lu s1=%lu\n", state.t0, state.t1, state.t2, state.s0, state.s1);
        fprintf(file, "a0=%lu a1=%lu a2=%lu a3=%lu a4=%lu a5=%lu a6=%lu a7=%lu\n",
                state.a0, state.a1, state.a2, state.a3, state.a4, state.a5, state.a6, state.a7);
        fprintf(file, "s2=%lu s3=%lu s4=%lu s5=%lu s6=%lu s7=%lu s8=%lu s9=%lu s10=%lu s11=%lu\n",
                state.s2, state.s3, state.s4, state.s5, state.s6, state.s7, state.s8, state.s9, state.s10, state.s11);
        fprintf(file, "t3=%lu t4=%lu t5=%lu t6=%lu\n\n", state.t3, state.t4, state.t5, state.t6);
    }

    fclose(file);
}

int main() {
    RegisterDump dump = { .count = 0 };
    RegisterState state;

    // Initialize
    __asm__ volatile (
        "li t0, 0\nli t1, 0\nli t2, 0\nli t3, 0\nli t4, 0\nli t5, 0\nli t6, 0\n"
    );
    get_registers(&state);
    dump.states[dump.count++] = state;

    // ADDI setup
    __asm__ volatile (
        "addi t0, zero, 5\n"
        "addi t1, zero, 5\n"
        "addi t2, zero, 3\n"
    );
    get_registers(&state);
    dump.states[dump.count++] = state;

    // BEQ (t0 == t1)
    __asm__ volatile (
        "beq t0, t1, beq_taken\n"
        "addi t3, zero, 1\n"
        "j beq_end\n"
        "beq_taken:\n"
        "addi t3, zero, 100\n"
        "beq_end:\n"
    );
    get_registers(&state);
    dump.states[dump.count++] = state;

    // BNE (t0 != t2)
    __asm__ volatile (
        "bne t0, t2, bne_taken\n"
        "addi t4, zero, 1\n"
        "j bne_end\n"
        "bne_taken:\n"
        "addi t4, zero, 200\n"
        "bne_end:\n"
    );
    get_registers(&state);
    dump.states[dump.count++] = state;

    // BGEU (t0 >= t2 unsigned)
    __asm__ volatile (
        "bgeu t0, t2, bgeu_taken\n"
        "addi t5, zero, 1\n"
        "j bgeu_end\n"
        "bgeu_taken:\n"
        "addi t5, zero, 255\n"
        "bgeu_end:\n"
    );
    get_registers(&state);
    dump.states[dump.count++] = state;

    // BLTU (t2 < t0 unsigned)
    __asm__ volatile (
        "bltu t2, t0, bltu_taken\n"
        "addi t6, zero, 1\n"
        "j bltu_end\n"
        "bltu_taken:\n"
        "addi t6, zero, 300\n"
        "bltu_end:\n"
    );
    get_registers(&state);
    dump.states[dump.count++] = state;

    // Save all dumps
    save_register_dump(&dump, "../test_compare/test_addi_branch_dump.txt");

    printf("Register dumps saved to test_addi_branch_dump.txt\n");
    return 0;
}
