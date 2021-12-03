package main

import (
	//"runtime"
	"syscall"
)

func fork() int32
func forkAndWait()

func main() {
	go func() {
		for {
			//forkAndWait()
			pid := fork()
			syscall.Syscall6(syscall.SYS_WAIT4, uintptr(pid), 0, 0, 0, 0, 0)
			//syscall.RawSyscall6(syscall.SYS_WAIT4, uintptr(pid), 0, 0, 0, 0, 0)
		}
	}()

	for {
		syscall.Syscall(syscall.SYS_GETPID, 0, 0, 0)
		//runtime.Gosched()
	}
}
