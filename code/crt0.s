; The ceespu common runtime which sets up the runtime enviroment and interrupt handles
; This file is linked into every ceespu executable.
int_vector:
	b main
	b uart_rx_irq
	b timer_irq

	.globl	uart_rx_irq
	.align	4
timer_irq:                                ; @timer_irq
	sw c1, -4(csp)                        ; %entry
	lw c1, system_timer_irq_counter(c0)
 	addi c1, c1, 1
 	sw c1, system_timer_irq_counter(c0)
 	lw c1, -4(csp)
	bx cir
 
	.globl	uart_rx_irq
	.align	4
uart_rx_irqv:                           ; uart_rx_irq
; BB#0:                                 ; %entry
	lb c20, 65524(c0)
	lbu c3, system_receive_irq_buffer_top(c0)
	addi c24, c0, 59
	add c22, c0, c0
	bgu c24, c23, LPBB0_3
LPBB0_1:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	addi c23, c0, system_receive_irq_buffer
	add c23, c22, c23
	lb c24, 1(c23)
	sb c24, 0(c23)
	addi c22, c22, 1
	addi c23, c0, 58
	bne c22, c23, LPBB0_1
; BB#2:                                 ; %for.end
	addi c22, c0, system_receive_irq_buffer_top
	sb c23, 0(c22)
LPBB0_3:                                ; %if.end
	lbu c22, 0(c21)
	addi c23, c22, 1
	sb c23, 0(c21)
	addi c21, c0, system_receive_irq_buffer
	add c21, c22, c21
	sb c20, 0(c21)
	bx clr

	.globl	system_receive_irq_buffer ; @system_receive_irq_buffer
system_receive_irq_buffer:
	.space 59

	.globl	system_receive_irq_buffer_top ; @system_receive_irq_buffer_top
system_receive_irq_buffer_top:
	.byte	0                       ; 0x0
system_timer_irq_counter:  
    .dword 0
