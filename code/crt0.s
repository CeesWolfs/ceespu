; The ceespu common runtime which sets up the runtime enviroment and interrupt handles
; This file is linked into every ceespu executable.
int_vector:
	b main
	b uart_rx_irq
	b timer_irq

	.globl	uart_rx_irq
	.align	4
timer_irq:                                ; @timer_irq
	sw c1, -4(csp)                        ; @entry
	lw c1, system_timer_irq_counter(c0)
 	addi c1, c1, 1
 	sw c1, system_timer_irq_counter(c0)
 	lw c1, -4(csp)
	bx cir
 
	.globl	uart_rx_irq
	.align	4
uart_rx_irq:                               ; @uart_rx_irq 
	sw c1, -8(csp)                         ; %entry
	sw c2, -4(csp)
	lw c2, 65532
	lw c1, system_receive_irq_buffer_size(c0)
	sw c2, system_receive_irq_buffer(c1)
 	addi c1, c1, 1
 	sw c1, system_receive_irq_buffer_size(c0)
 	lw c1, -4(csp)
	lw c2, -8(csp)
	bx cir
  
  .data
  .comm	system_timer_irq_counter,4,4
  .comm system_receive_irq_buffer,59,1
  .comm system_receive_irq_buffer_size,1,1
