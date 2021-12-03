#include "textflag.h"

#define SYS_EXIT	1
#define SYS_FORK	2
#define SYS_WAIT4	449

// func forkAndWait()
TEXT ·forkAndWait(SB),NOSPLIT,$0
	MOVQ	$SYS_FORK, AX
	SYSCALL

	CMPQ	AX, $0
	JNE	parent

	// Child.
	MOVQ	$0, DI
	MOVQ	$SYS_EXIT, AX
	SYSCALL
	HLT

parent:
	MOVL	AX, DI	// arg 1 - pid
	MOVQ	$0, SI	// arg 2 - status
	MOVQ	$0, DX	// arg 3 - flags
	MOVQ	$0, R10	// arg 4 - rusage
	MOVQ	$SYS_WAIT4, AX
	SYSCALL
	RET

// func fork() int32
TEXT ·fork(SB),NOSPLIT,$0-4
	MOVQ	$SYS_FORK, AX
	SYSCALL

	CMPQ	AX, $0
	JNE	parent

	// Child.
	MOVQ	$0, DI
	MOVQ	$SYS_EXIT, AX
	SYSCALL
	HLT

parent:
	MOVL	AX, ret+0(FP)
	RET

