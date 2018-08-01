; The ceespu common runtime which sets up the runtime enviroment and interrupt handles
; This file is linked into every ceespu executable.
intie_vector:
	b main
	b uart_rx_irq
	b timer_irq

	.globl timer_rx_irq
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
	lb c1, 65524(c0)
	lbu c3, system_receive_irq_buffer_top(c0)
	addi c4, c0, 59
	add c2, c0, c0
	bgu c4, c3, LPBB0_3
LPBB0_1:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	addi c23, c0, system_receive_irq_buffer
	add c23, c22, c23
	lb c24, 1(c23)
	sb c24, 0(c23)
	addi c22, c22, 1
	addi c3, c0, 58
	bne c2, c3, LPBB0_1
; BB#2:                                 ; %for.end
	sb c3, system_receive_irq_buffer_top(c0)
LPBB0_3:                                ; %if.end
	lbu c2, system_receive_irq_buffer_top(c0)
	addi c3, c2, 1
	sb c3, system_receive_irq_buffer_top(c0)
	sb c20, system_receive_irq_buffer(c2)
	bx clr

	.globl	system_receive_irq_buffer ; @system_receive_irq_buffer
system_receive_irq_buffer:
	.space 59

	.globl	system_receive_irq_buffer_top ; @system_receive_irq_buffer_top
system_receive_irq_buffer_top:
	.byte	0                       ; 0x0
system_timer_irq_counter: 
        .word 0
