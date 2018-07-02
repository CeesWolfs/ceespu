	.text
	.file	"ceespu_assembler.cpp"
	.globl	_Z7is16biti             # -- Begin function _Z7is16biti
	.p2align	4, 0x90
	.type	_Z7is16biti,@function
_Z7is16biti:                            # @_Z7is16biti
	.cfi_startproc
# %bb.0:
	movswl	%di, %eax
	cmpl	%edi, %eax
	sete	%al
	retq
.Lfunc_end0:
	.size	_Z7is16biti, .Lfunc_end0-_Z7is16biti
	.cfi_endproc
                                        # -- End function
	.globl	_Z8TokenizeRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhh # -- Begin function _Z8TokenizeRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhh
	.p2align	4, 0x90
	.type	_Z8TokenizeRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhh,@function
_Z8TokenizeRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhh: # @_Z8TokenizeRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhh
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movzbl	(%rsi), %ebx
	movb	(%rdi), %cl
	testb	$1, %cl
	je	.LBB1_10
# %bb.1:
	movq	8(%rdi), %rax
	cmpq	%rbx, %rax
	je	.LBB1_11
	jmp	.LBB1_2
.LBB1_10:
	movl	%ecx, %eax
	shrb	%al
	movzbl	%al, %eax
	cmpq	%rbx, %rax
	je	.LBB1_11
.LBB1_2:
	leaq	1(%rdi), %r8
	movzbl	%dl, %r11d
	movq	%r8, %r10
	testb	$1, %cl
	je	.LBB1_4
# %bb.3:
	movq	16(%rdi), %r10
.LBB1_4:
	movq	$-1, %r9
	movq	$-1, %rdx
	subq	%r11, %rax
	jbe	.LBB1_13
# %bb.5:
	addq	%r10, %r11
	movabsq	$20895015895552, %r14   # imm = 0x130100000200
	movq	%r11, %rdx
	.p2align	4, 0x90
.LBB1_6:                                # =>This Inner Loop Header: Depth=1
	movzbl	(%rdx), %ecx
	movl	$1, %ebx
	shlq	%cl, %rbx
	cmpb	$63, %cl
	ja	.LBB1_12
# %bb.7:                                #   in Loop: Header=BB1_6 Depth=1
	andq	%r14, %rbx
	je	.LBB1_12
# %bb.8:                                #   in Loop: Header=BB1_6 Depth=1
	addq	$1, %rdx
	addq	$-1, %rax
	jne	.LBB1_6
# %bb.9:
	movq	$-1, %rdx
	jmp	.LBB1_13
.LBB1_12:
	subq	%r10, %rdx
.LBB1_13:
	movb	%dl, (%rsi)
	movzbl	%dl, %r10d
	movb	(%rdi), %r11b
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movq	16(%rdi), %r15
	movq	8(%rdi), %r14
	movq	%r15, %r12
	cmoveq	%r8, %r12
	movzbl	%al, %eax
	movq	%r14, %rcx
	cmoveq	%rax, %rcx
	movq	%rcx, %rbx
	subq	%r10, %rbx
	jbe	.LBB1_20
# %bb.14:
	leaq	(%r12,%r10), %rdi
	addq	%r12, %rcx
	movabsq	$20895015895552, %r9    # imm = 0x130100000200
	.p2align	4, 0x90
.LBB1_15:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %esi
	cmpq	$44, %rsi
	ja	.LBB1_17
# %bb.16:                               #   in Loop: Header=BB1_15 Depth=1
	btq	%rsi, %r9
	jb	.LBB1_19
.LBB1_17:                               #   in Loop: Header=BB1_15 Depth=1
	addq	$1, %rdi
	addq	$-1, %rbx
	jne	.LBB1_15
# %bb.18:
	movq	%rcx, %rdi
.LBB1_19:
	movq	%rdi, %rsi
	subq	%r12, %rsi
	cmpq	%rcx, %rdi
	movq	$-1, %r9
	cmovneq	%rsi, %r9
.LBB1_20:
	cmpb	$-1, %dl
	je	.LBB1_11
# %bb.21:
	testb	$1, %r11b
	cmoveq	%r8, %r15
	cmpb	$59, (%r15,%r10)
	jne	.LBB1_24
.LBB1_11:
	xorl	%eax, %eax
.LBB1_29:
                                        # kill: def %al killed %al killed %rax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB1_24:
	cmpq	$-1, %r9
	je	.LBB1_26
# %bb.25:
	movl	%r9d, %r14d
	movl	%r9d, %eax
.LBB1_26:
	testb	$1, %r11b
	je	.LBB1_28
# %bb.27:
	movl	%r14d, %eax
.LBB1_28:
	subb	%dl, %al
	jmp	.LBB1_29
.Lfunc_end1:
	.size	_Z8TokenizeRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhh, .Lfunc_end1-_Z8TokenizeRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhh
	.cfi_endproc
                                        # -- End function
	.globl	_Z12selfTokenizeNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERh # -- Begin function _Z12selfTokenizeNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERh
	.p2align	4, 0x90
	.type	_Z12selfTokenizeNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERh,@function
_Z12selfTokenizeNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERh: # @_Z12selfTokenizeNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERh
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movb	(%rsi), %bl
	movzbl	%bl, %eax
	movb	(%rdi), %cl
	testb	$1, %cl
	jne	.LBB2_15
# %bb.1:
	movl	%ecx, %edx
	shrb	%dl
	movzbl	%dl, %r8d
	cmpq	%rax, %r8
	je	.LBB2_16
.LBB2_2:
	movabsq	$20895015895552, %r8    # imm = 0x130100000200
	leaq	1(%rdi), %r9
	testb	$1, %cl
	je	.LBB2_4
	.p2align	4, 0x90
.LBB2_13:
	movq	8(%rdi), %rdx
	cmpq	%rax, %rdx
	jbe	.LBB2_18
.LBB2_5:
	movq	%r9, %rdx
	testb	$1, %cl
	je	.LBB2_7
# %bb.6:
	movq	16(%rdi), %rdx
.LBB2_7:
	cmpb	$64, (%rdx,%rax)
	jae	.LBB2_17
# %bb.8:
	movq	%r9, %rdx
	testb	$1, %cl
	je	.LBB2_10
# %bb.9:
	movq	16(%rdi), %rdx
.LBB2_10:
	movzbl	(%rdx,%rax), %edx
	btq	%rdx, %r8
	jae	.LBB2_17
# %bb.11:
	testb	$1, %cl
	jne	.LBB2_14
# %bb.12:
	shrb	%cl
	movzbl	%cl, %ebx
	jmp	.LBB2_3
	.p2align	4, 0x90
.LBB2_14:
	movq	8(%rdi), %rbx
.LBB2_3:
	movb	%bl, (%rsi)
	addq	$1, %rax
	movb	(%rdi), %cl
	testb	$1, %cl
	jne	.LBB2_13
.LBB2_4:
	movl	%ecx, %edx
	shrb	%dl
	movzbl	%dl, %edx
	cmpq	%rax, %rdx
	ja	.LBB2_5
.LBB2_18:
	movb	(%rdi), %r11b
	testb	$1, %r11b
	jne	.LBB2_24
.LBB2_19:
	movl	%r11d, %eax
	shrb	%al
	movzbl	%al, %eax
	movzbl	%bl, %r10d
	cmpb	%al, %bl
	jae	.LBB2_29
# %bb.20:
	movq	%r10, %rsi
	.p2align	4, 0x90
.LBB2_21:                               # =>This Inner Loop Header: Depth=1
	movsbq	1(%rdi,%rsi), %rcx
	cmpq	$63, %rcx
	ja	.LBB2_23
# %bb.22:                               #   in Loop: Header=BB2_21 Depth=1
	btq	%rcx, %r8
	jb	.LBB2_35
.LBB2_23:                               #   in Loop: Header=BB2_21 Depth=1
	addq	$1, %rsi
	cmpq	%rax, %rsi
	jb	.LBB2_21
	jmp	.LBB2_29
.LBB2_15:
	movq	8(%rdi), %r8
	cmpq	%rax, %r8
	jne	.LBB2_2
.LBB2_16:
	xorl	%eax, %eax
                                        # kill: def %al killed %al killed %rax
	popq	%rbx
	retq
.LBB2_17:
	movl	%eax, %ebx
	movb	%bl, (%rsi)
	movb	(%rdi), %r11b
	testb	$1, %r11b
	je	.LBB2_19
.LBB2_24:
	movq	8(%rdi), %rax
	movzbl	%bl, %r10d
	cmpq	%r10, %rax
	jbe	.LBB2_29
# %bb.25:
	movq	16(%rdi), %rcx
	movq	%r10, %rsi
	.p2align	4, 0x90
.LBB2_26:                               # =>This Inner Loop Header: Depth=1
	movsbq	(%rcx,%rsi), %rdx
	cmpq	$63, %rdx
	ja	.LBB2_28
# %bb.27:                               #   in Loop: Header=BB2_26 Depth=1
	btq	%rdx, %r8
	jb	.LBB2_35
.LBB2_28:                               #   in Loop: Header=BB2_26 Depth=1
	addq	$1, %rsi
	cmpq	%rsi, %rax
	ja	.LBB2_26
.LBB2_29:
	testb	$1, %r11b
	je	.LBB2_31
.LBB2_30:
	movq	16(%rdi), %r9
.LBB2_31:
	cmpb	$59, (%r9,%r10)
	je	.LBB2_33
# %bb.32:
	subb	%bl, %al
                                        # kill: def %al killed %al killed %rax
	popq	%rbx
	retq
.LBB2_33:
	xorl	%eax, %eax
                                        # kill: def %al killed %al killed %rax
	popq	%rbx
	retq
.LBB2_35:
	movq	%rsi, %rax
	testb	$1, %r11b
	jne	.LBB2_30
	jmp	.LBB2_31
.Lfunc_end2:
	.size	_Z12selfTokenizeNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERh, .Lfunc_end2-_Z12selfTokenizeNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERh
	.cfi_endproc
                                        # -- End function
	.globl	_Z12getImmidiatePch     # -- Begin function _Z12getImmidiatePch
	.p2align	4, 0x90
	.type	_Z12getImmidiatePch,@function
_Z12getImmidiatePch:                    # @_Z12getImmidiatePch
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%fs:40, %rax
	movq	%rax, 32(%rsp)
	movl	%esi, %ebp
	movq	%rdi, %rbx
	movl	%ebp, %ecx
	addb	$-1, %cl
	movq	$-1, %rax
	cmpb	$10, %cl
	ja	.LBB3_2
# %bb.1:
	leaq	20(%rsp), %r14
	movq	%r14, 8(%rsp)
	callq	__errno_location@PLT
	movq	%rax, %r15
	movl	$0, (%r15)
	movzbl	%bpl, %ebp
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%rbp, %rdx
	callq	memcpy@PLT
	movb	$0, 20(%rsp,%rbp)
	leaq	8(%rsp), %rsi
	xorl	%edx, %edx
	movq	%r14, %rdi
	callq	strtol@PLT
	cmpl	$1, (%r15)
	movl	%eax, %ecx
	sbbq	%rax, %rax
	notq	%rax
	orq	%rcx, %rax
.LBB3_2:
	movq	%fs:40, %rcx
	cmpq	32(%rsp), %rcx
	jne	.LBB3_4
# %bb.3:
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB3_4:
	callq	__stack_chk_fail@PLT
.Lfunc_end3:
	.size	_Z12getImmidiatePch, .Lfunc_end3-_Z12getImmidiatePch
	.cfi_endproc
                                        # -- End function
	.globl	_Z8getLabelPch          # -- Begin function _Z8getLabelPch
	.p2align	4, 0x90
	.type	_Z8getLabelPch,@function
_Z8getLabelPch:                         # @_Z8getLabelPch
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rsi, %r14
	movq	%rdi, %r12
	movl	%edx, %ebx
	cmpb	$58, -1(%r14,%rbx)
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%r12)
	movq	$0, 16(%r12)
	jne	.LBB4_7
# %bb.1:
	leaq	-1(%rbx), %r15
	cmpq	$-16, %r15
	jae	.LBB4_8
# %bb.2:
	cmpq	$23, %r15
	jae	.LBB4_3
# %bb.4:
	movl	%r15d, %eax
	addb	%al, %al
	movb	%al, (%r12)
	leaq	1(%r12), %r13
	testq	%r15, %r15
	jne	.LBB4_5
	jmp	.LBB4_6
.LBB4_3:
	addl	$15, %ebx
	andl	$496, %ebx              # imm = 0x1F0
	movq	%rbx, %rdi
	callq	_Znwm@PLT
	movq	%rax, %r13
	movq	%r13, 16(%r12)
	orq	$1, %rbx
	movq	%rbx, (%r12)
	movq	%r15, 8(%r12)
.LBB4_5:
	movq	%r13, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB4_6:
	movb	$0, (%r13,%r15)
.LBB4_7:
	movq	%r12, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB4_8:
	movq	%r12, %rdi
	callq	_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv@PLT
.Lfunc_end4:
	.size	_Z8getLabelPch, .Lfunc_end4-_Z8getLabelPch
	.cfi_endproc
                                        # -- End function
	.globl	_Z12getDirectivePch     # -- Begin function _Z12getDirectivePch
	.p2align	4, 0x90
	.type	_Z12getDirectivePch,@function
_Z12getDirectivePch:                    # @_Z12getDirectivePch
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdi, %r13
	movb	$-1, %al
	cmpb	$46, (%r13)
	jne	.LBB5_9
# %bb.1:
	addq	$1, %r13
	movzbl	%sil, %r12d
	addq	$-1, %r12
	movb	$10, %bl
	xorl	%ebp, %ebp
	leaq	directives(%rip), %r15
	.p2align	4, 0x90
.LBB5_2:                                # =>This Inner Loop Header: Depth=1
	movzbl	%bpl, %eax
	movzbl	%bl, %r14d
	addl	%eax, %r14d
	shrl	%r14d
	leaq	(%r15,%r14,8), %rsi
	movq	%r13, %rdi
	movq	%r12, %rdx
	callq	strncmp@PLT
	testl	%eax, %eax
	je	.LBB5_3
# %bb.4:                                #   in Loop: Header=BB5_2 Depth=1
	testl	%eax, %eax
	jg	.LBB5_5
# %bb.6:                                #   in Loop: Header=BB5_2 Depth=1
	addb	$-1, %r14b
	movl	%r14d, %ebx
	cmpb	%bl, %bpl
	jb	.LBB5_2
	jmp	.LBB5_8
	.p2align	4, 0x90
.LBB5_5:                                #   in Loop: Header=BB5_2 Depth=1
	addb	$1, %r14b
	movl	%r14d, %ebp
	cmpb	%bl, %bpl
	jb	.LBB5_2
.LBB5_8:
	movb	$-1, %al
	jmp	.LBB5_9
.LBB5_3:
	movl	%r14d, %eax
.LBB5_9:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end5:
	.size	_Z12getDirectivePch, .Lfunc_end5-_Z12getDirectivePch
	.cfi_endproc
                                        # -- End function
	.globl	_Z14getInstructionPch   # -- Begin function _Z14getInstructionPch
	.p2align	4, 0x90
	.type	_Z14getInstructionPch,@function
_Z14getInstructionPch:                  # @_Z14getInstructionPch
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdi, %r15
	movl	%esi, %eax
	movb	$0, (%r15,%rax)
	movq	$-1, %rax
	cmpb	$5, %sil
	ja	.LBB6_9
# %bb.1:
	movb	$42, %r13b
	xorl	%ebp, %ebp
	leaq	instr(%rip), %r12
	.p2align	4, 0x90
.LBB6_2:                                # =>This Inner Loop Header: Depth=1
	movzbl	%bpl, %eax
	movzbl	%r13b, %r14d
	addl	%eax, %r14d
	shrl	%r14d
	leaq	(%r12,%r14,8), %rbx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB6_3
# %bb.4:                                #   in Loop: Header=BB6_2 Depth=1
	testl	%eax, %eax
	jg	.LBB6_5
# %bb.6:                                #   in Loop: Header=BB6_2 Depth=1
	addb	$-1, %r14b
	movl	%r14d, %r13d
	cmpb	%r13b, %bpl
	jbe	.LBB6_2
	jmp	.LBB6_8
	.p2align	4, 0x90
.LBB6_5:                                #   in Loop: Header=BB6_2 Depth=1
	addb	$1, %r14b
	movl	%r14d, %ebp
	cmpb	%r13b, %bpl
	jbe	.LBB6_2
.LBB6_8:
	movq	$-1, %rax
	jmp	.LBB6_9
.LBB6_3:
	movq	(%rbx), %rax
.LBB6_9:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end6:
	.size	_Z14getInstructionPch, .Lfunc_end6-_Z14getInstructionPch
	.cfi_endproc
                                        # -- End function
	.globl	_Z11getRegisterPch      # -- Begin function _Z11getRegisterPch
	.p2align	4, 0x90
	.type	_Z11getRegisterPch,@function
_Z11getRegisterPch:                     # @_Z11getRegisterPch
	.cfi_startproc
# %bb.0:
	movl	%esi, %eax
	andb	$-2, %al
	movb	$-1, %cl
	cmpb	$2, %al
	jne	.LBB7_9
# %bb.1:
	cmpb	$99, (%rdi)
	jne	.LBB7_9
# %bb.2:
	movsbl	1(%rdi), %eax
	cmpb	$2, %sil
	jne	.LBB7_7
# %bb.3:
	leal	-48(%rax), %ecx
	cmpl	$10, %ecx
	jb	.LBB7_4
# %bb.5:
	movb	$-1, %al
                                        # kill: def %al killed %al killed %rax
	retq
.LBB7_7:
	leal	(%rax,%rax,4), %ecx
	movsbl	2(%rdi), %edx
	leal	(%rdx,%rcx,2), %esi
	addl	$-528, %esi             # imm = 0xFDF0
	cmpl	$31, %esi
	ja	.LBB7_10
# %bb.8:
	leal	(%rdx,%rcx,2), %ecx
	addb	$-16, %cl
	movl	%ecx, %eax
	retq
.LBB7_4:
	addb	$-48, %al
                                        # kill: def %al killed %al killed %rax
	retq
.LBB7_10:
	cmpb	$115, %al
	jne	.LBB7_12
# %bb.11:
	movb	$18, %cl
	cmpb	$112, %dl
	jne	.LBB7_12
.LBB7_9:
	movl	%ecx, %eax
	retq
.LBB7_12:
	xorb	$108, %al
	xorb	$114, %dl
	orb	%al, %dl
	movb	$19, %al
	je	.LBB7_14
# %bb.13:
	movb	$-1, %al
.LBB7_14:
	retq
.Lfunc_end7:
	.size	_Z11getRegisterPch, .Lfunc_end7-_Z11getRegisterPch
	.cfi_endproc
                                        # -- End function
	.globl	_Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo # -- Begin function _Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo
	.p2align	4, 0x90
	.type	_Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo,@function
_Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo: # @_Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%fs:40, %rax
	movq	%rax, 64(%rsp)
	movq	%rdx, %r14
	movq	%rdi, %r15
	movq	%rcx, 32(%rsp)          # 8-byte Spill
	movq	%rcx, %rdi
	shrq	$40, %rdi
	movb	(%rsi), %r9b
	movzbl	%r9b, %eax
	movb	(%r15), %r11b
	movl	%r11d, %ecx
	shrb	%cl
	testb	$1, %r11b
	movq	8(%r15), %r8
	movzbl	%cl, %ebp
	cmovneq	%r8, %rbp
	cmpq	%rax, %rbp
	je	.LBB8_1
# %bb.10:
	leaq	1(%r15), %r10
	movq	%r10, %r8
	testb	$1, %r11b
	je	.LBB8_12
# %bb.11:
	movq	16(%r15), %r8
.LBB8_12:
	movq	$-1, %r9
	subq	%rax, %rbp
	jbe	.LBB8_18
# %bb.13:
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	addq	%r8, %rax
	.p2align	4, 0x90
.LBB8_14:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %ecx
	movl	$1, %edx
	shlq	%cl, %rdx
	cmpb	$63, %cl
	ja	.LBB8_17
# %bb.15:                               #   in Loop: Header=BB8_14 Depth=1
	andq	%rbx, %rdx
	je	.LBB8_17
# %bb.16:                               #   in Loop: Header=BB8_14 Depth=1
	addq	$1, %rax
	addq	$-1, %rbp
	jne	.LBB8_14
	jmp	.LBB8_18
.LBB8_17:
	subq	%r8, %rax
	movq	%rax, %r9
.LBB8_18:
	movb	%r9b, (%rsi)
	movzbl	%r9b, %r12d
	movb	(%r15), %r11b
	movl	%r11d, %eax
	shrb	%al
	movq	8(%r15), %r8
	movzbl	%al, %r13d
	movq	%r13, %rdx
	testb	$1, %r11b
	je	.LBB8_19
# %bb.23:
	movq	16(%r15), %r10
	movq	%r8, %rdx
	movq	$-1, %rcx
	movq	%rdx, %rax
	subq	%r12, %rax
	ja	.LBB8_24
.LBB8_20:
	cmpb	$-1, %r9b
	je	.LBB8_30
.LBB8_21:
	cmpb	$59, (%r10,%r12)
	je	.LBB8_1
# %bb.32:
	cmpq	$-1, %rcx
	je	.LBB8_66
# %bb.33:
	movl	%ecx, %r13d
	testb	$1, %r11b
	jne	.LBB8_67
	jmp	.LBB8_68
.LBB8_19:
	movq	$-1, %rcx
	movq	%rdx, %rax
	subq	%r12, %rax
	jbe	.LBB8_20
.LBB8_24:
	leaq	(%r10,%r12), %rcx
	addq	%r10, %rdx
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB8_25:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rcx), %ebp
	cmpq	$44, %rbp
	ja	.LBB8_27
# %bb.26:                               #   in Loop: Header=BB8_25 Depth=1
	btq	%rbp, %rbx
	jb	.LBB8_29
.LBB8_27:                               #   in Loop: Header=BB8_25 Depth=1
	addq	$1, %rcx
	addq	$-1, %rax
	jne	.LBB8_25
# %bb.28:
	movq	%rdx, %rcx
.LBB8_29:
	movq	%rcx, %rax
	subq	%r10, %rax
	cmpq	%rdx, %rcx
	movq	$-1, %rcx
	cmovneq	%rax, %rcx
	cmpb	$-1, %r9b
	jne	.LBB8_21
.LBB8_30:
	movb	$-1, %r9b
.LBB8_1:
	xorl	%r13d, %r13d
	xorl	%ebp, %ebp
	xorl	%r10d, %r10d
	cmpb	$8, %dil
	ja	.LBB8_31
.LBB8_2:
	movzbl	%dil, %eax
	leaq	.LJTI8_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	jmpq	*%rax
.LBB8_3:
	movq	%rsi, %r10
	leaq	1(%r15), %rsi
	movq	%rsi, %rdi
	testb	$1, %r11b
	je	.LBB8_5
# %bb.4:
	movq	16(%r15), %rdi
.LBB8_5:
	movl	%r13d, %eax
	andb	$-2, %al
	movl	$-1, %r12d
	cmpb	$2, %al
	jne	.LBB8_407
# %bb.6:
	movzbl	%r9b, %ebp
	cmpb	$99, (%rdi,%rbp)
	jne	.LBB8_407
# %bb.7:
	movsbl	1(%rdi,%rbp), %eax
	cmpb	$2, %r13b
	jne	.LBB8_79
# %bb.8:
	movl	%eax, %edx
	addb	$-48, %dl
	cmpb	$-1, %dl
	je	.LBB8_407
# %bb.9:
	addl	$-48, %eax
	cmpl	$9, %eax
	jbe	.LBB8_174
	jmp	.LBB8_407
.LBB8_34:
	movq	%rsi, 16(%rsp)          # 8-byte Spill
	leaq	1(%r15), %r14
	movq	%r14, %rsi
	testb	$1, %r11b
	je	.LBB8_36
# %bb.35:
	movq	16(%r15), %rsi
.LBB8_36:
	movl	%r13d, %eax
	andb	$-2, %al
	movl	$-1, %r12d
	cmpb	$2, %al
	jne	.LBB8_407
# %bb.37:
	movzbl	%r9b, %edi
	cmpb	$99, (%rsi,%rdi)
	jne	.LBB8_407
# %bb.38:
	movsbl	1(%rsi,%rdi), %eax
	cmpb	$2, %r13b
	jne	.LBB8_75
# %bb.39:
	movl	%eax, %edx
	addb	$-48, %dl
	cmpb	$-1, %dl
	je	.LBB8_407
# %bb.40:
	addl	$-48, %eax
	cmpl	$9, %eax
	jbe	.LBB8_91
	jmp	.LBB8_407
.LBB8_41:
	movq	%rsi, 16(%rsp)          # 8-byte Spill
	leaq	1(%r15), %r14
	testb	$1, %r11b
	movq	16(%r15), %r12
	movq	%r12, %rsi
	cmoveq	%r14, %rsi
	movzbl	%r9b, %ebp
	movl	%r13d, %eax
	andb	$-2, %al
	movb	$-1, %dl
	cmpb	$2, %al
	jne	.LBB8_103
# %bb.42:
	cmpb	$99, (%rsi,%rbp)
	jne	.LBB8_103
# %bb.43:
	movsbl	1(%rsi,%rbp), %eax
	cmpb	$2, %r13b
	jne	.LBB8_77
# %bb.44:
	leal	-48(%rax), %ecx
	cmpl	$10, %ecx
	jae	.LBB8_102
# %bb.45:
	addb	$-48, %al
	movl	%eax, %edx
	jmp	.LBB8_103
.LBB8_46:
	leaq	1(%r15), %r14
	testb	$1, %r11b
	movq	16(%r15), %r10
	movq	%r10, %rdi
	cmoveq	%r14, %rdi
	movzbl	%r9b, %ebp
	movl	%r13d, %eax
	andb	$-2, %al
	movb	$-1, %bl
	cmpb	$2, %al
	jne	.LBB8_184
# %bb.47:
	cmpb	$99, (%rdi,%rbp)
	jne	.LBB8_184
# %bb.48:
	movsbl	1(%rdi,%rbp), %eax
	cmpb	$2, %r13b
	jne	.LBB8_81
# %bb.49:
	leal	-48(%rax), %ecx
	cmpl	$10, %ecx
	jae	.LBB8_183
# %bb.50:
	addb	$-48, %al
	movl	%eax, %ebx
	jmp	.LBB8_184
.LBB8_51:
	movq	%rsi, %r14
	leaq	1(%r15), %rdi
	movq	%rdi, %rsi
	testb	$1, %r11b
	je	.LBB8_53
# %bb.52:
	movq	16(%r15), %rsi
.LBB8_53:
	movl	%r13d, %eax
	andb	$-2, %al
	movl	$-1, %r12d
	cmpb	$2, %al
	jne	.LBB8_407
# %bb.54:
	movzbl	%r9b, %ebp
	cmpb	$99, (%rsi,%rbp)
	jne	.LBB8_407
# %bb.55:
	movsbl	1(%rsi,%rbp), %eax
	cmpb	$2, %r13b
	jne	.LBB8_83
# %bb.56:
	movl	%eax, %edx
	addb	$-48, %dl
	cmpb	$-1, %dl
	je	.LBB8_407
# %bb.57:
	addl	$-48, %eax
	cmpl	$9, %eax
	jbe	.LBB8_247
	jmp	.LBB8_407
.LBB8_58:
	leaq	1(%r15), %rax
	testb	$1, %r11b
	movq	16(%r15), %r14
	movq	%r14, %rbx
	movq	%rax, 8(%rsp)           # 8-byte Spill
	cmoveq	%rax, %rbx
	movzbl	%r9b, %edi
	movl	%r13d, %eax
	andb	$-2, %al
	movb	$-1, %cl
	movl	%ecx, (%rsp)            # 4-byte Spill
	cmpb	$2, %al
	jne	.LBB8_138
# %bb.59:
	cmpb	$99, (%rbx,%rdi)
	jne	.LBB8_138
# %bb.60:
	movsbl	1(%rbx,%rdi), %eax
	cmpb	$2, %r13b
	jne	.LBB8_85
# %bb.61:
	leal	-48(%rax), %ecx
	cmpl	$10, %ecx
	jb	.LBB8_136
.LBB8_62:
	movb	$-1, %al
	jmp	.LBB8_137
.LBB8_63:
	movl	%r13d, %eax
	addb	$-1, %al
	movq	$-1, %r10
	cmpb	$10, %al
	ja	.LBB8_71
# %bb.64:
	testb	$1, %r11b
	je	.LBB8_69
# %bb.65:
	movq	16(%r15), %r15
	jmp	.LBB8_70
.LBB8_66:
	movl	%r8d, %ecx
	testb	$1, %r11b
	je	.LBB8_68
.LBB8_67:
	movl	%ecx, %r13d
.LBB8_68:
	subb	%r9b, %r13b
	xorl	%ebp, %ebp
	xorl	%r10d, %r10d
	cmpb	$8, %dil
	jbe	.LBB8_2
.LBB8_31:
	xorl	%ebx, %ebx
	jmp	.LBB8_405
.LBB8_69:
	addq	$1, %r15
.LBB8_70:
	movzbl	%r9b, %ebp
	addq	%r15, %rbp
	leaq	52(%rsp), %r15
	movq	%r15, 40(%rsp)
	callq	__errno_location@PLT
	movq	%rax, %r12
	movl	$0, (%r12)
	movzbl	%r13b, %ebx
	movq	%r15, %rdi
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	callq	memcpy@PLT
	movb	$0, 52(%rsp,%rbx)
	leaq	40(%rsp), %rsi
	xorl	%edx, %edx
	movq	%r15, %rdi
	callq	strtol@PLT
	cmpl	$1, (%r12)
	movl	%eax, %eax
	sbbq	%r10, %r10
	notq	%r10
	orq	%rax, %r10
.LBB8_71:
	movswl	%r10w, %eax
	movl	$-1, %r12d
	cmpl	%r10d, %eax
	jne	.LBB8_407
# %bb.72:
	movabsq	$71776119061217280, %rax # imm = 0xFF000000000000
	andq	32(%rsp), %rax          # 8-byte Folded Reload
	movabsq	$11821949021847552, %rcx # imm = 0x2A000000000000
	cmpq	%rcx, %rax
	jne	.LBB8_74
# %bb.73:
	movb	$1, (%r14)
.LBB8_74:
	xorl	%ebp, %ebp
	xorl	%ebx, %ebx
	jmp	.LBB8_405
.LBB8_75:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%rsi,%rdi), %ecx
	leal	(%rcx,%rdx,2), %ebp
	addl	$-528, %ebp             # imm = 0xFDF0
	cmpl	$31, %ebp
	ja	.LBB8_87
# %bb.76:
	leal	(%rcx,%rdx,2), %edx
	addb	$-16, %dl
	jmp	.LBB8_91
.LBB8_77:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%rsi,%rbp), %ecx
	leal	(%rcx,%rdx,2), %edi
	addl	$-528, %edi             # imm = 0xFDF0
	cmpl	$31, %edi
	ja	.LBB8_99
# %bb.78:
	leal	(%rcx,%rdx,2), %edx
	addb	$-16, %dl
	jmp	.LBB8_103
.LBB8_79:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%rdi,%rbp), %ecx
	leal	(%rcx,%rdx,2), %ebx
	addl	$-528, %ebx             # imm = 0xFDF0
	cmpl	$31, %ebx
	ja	.LBB8_170
# %bb.80:
	leal	(%rcx,%rdx,2), %edx
	addb	$-16, %dl
	jmp	.LBB8_174
.LBB8_81:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%rdi,%rbp), %ecx
	leal	(%rcx,%rdx,2), %ebx
	addl	$-528, %ebx             # imm = 0xFDF0
	cmpl	$31, %ebx
	ja	.LBB8_180
# %bb.82:
	leal	(%rcx,%rdx,2), %ebx
	addb	$-16, %bl
	jmp	.LBB8_184
.LBB8_83:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%rsi,%rbp), %ecx
	leal	(%rcx,%rdx,2), %ebx
	addl	$-528, %ebx             # imm = 0xFDF0
	cmpl	$31, %ebx
	ja	.LBB8_243
# %bb.84:
	leal	(%rcx,%rdx,2), %edx
	addb	$-16, %dl
	jmp	.LBB8_247
.LBB8_85:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%rbx,%rdi), %ecx
	leal	(%rcx,%rdx,2), %ebp
	addl	$-528, %ebp             # imm = 0xFDF0
	cmpl	$31, %ebp
	ja	.LBB8_253
# %bb.86:
	leal	(%rcx,%rdx,2), %eax
	addb	$-16, %al
	jmp	.LBB8_137
.LBB8_87:
	cmpb	$115, %al
	jne	.LBB8_89
# %bb.88:
	movb	$18, %dl
	cmpb	$112, %cl
	je	.LBB8_91
.LBB8_89:
	cmpb	$108, %al
	jne	.LBB8_407
# %bb.90:
	movb	$19, %dl
	cmpb	$114, %cl
	jne	.LBB8_407
.LBB8_91:
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movzbl	%al, %eax
	cmoveq	%rax, %r8
	cmpq	%rdi, %r8
	jne	.LBB8_93
# %bb.92:
	movq	$-1, %r10
	xorl	%r13d, %r13d
	movswl	%r10w, %eax
	cmpl	%r10d, %eax
	je	.LBB8_346
	jmp	.LBB8_407
.LBB8_93:
	addb	%r13b, %r9b
	movzbl	%r9b, %ecx
	movq	$-1, %rdi
	movq	$-1, %rax
	subq	%rcx, %r8
	jbe	.LBB8_328
# %bb.94:
	movq	%rdx, %rbx
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%rsi, %rcx
	movq	%rcx, %rax
.LBB8_95:                               # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %ecx
	movl	$1, %ebp
	shlq	%cl, %rbp
	cmpb	$63, %cl
	ja	.LBB8_326
# %bb.96:                               #   in Loop: Header=BB8_95 Depth=1
	andq	%rdx, %rbp
	je	.LBB8_326
# %bb.97:                               #   in Loop: Header=BB8_95 Depth=1
	addq	$1, %rax
	addq	$-1, %r8
	jne	.LBB8_95
# %bb.98:
	movq	$-1, %rax
	jmp	.LBB8_327
.LBB8_99:
	cmpb	$115, %al
	jne	.LBB8_101
# %bb.100:
	movb	$18, %dl
	cmpb	$112, %cl
	je	.LBB8_103
.LBB8_101:
	xorb	$108, %al
	xorb	$114, %cl
	orb	%al, %cl
	movb	$19, %dl
	je	.LBB8_103
.LBB8_102:
	movb	$-1, %dl
.LBB8_103:
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movzbl	%al, %edi
	cmovneq	%r8, %rdi
	cmpq	%rbp, %rdi
	je	.LBB8_104
# %bb.110:
	movq	%rdx, 8(%rsp)           # 8-byte Spill
	addb	%r13b, %r9b
	movzbl	%r9b, %ecx
	movq	$-1, %r10
	movq	$-1, %r9
	subq	%rcx, %rdi
	movq	16(%rsp), %rbp          # 8-byte Reload
	jbe	.LBB8_117
# %bb.111:
	movabsq	$20895015895552, %rax   # imm = 0x130100000200
	addq	%rsi, %rcx
	movq	%rcx, %r9
	.p2align	4, 0x90
.LBB8_112:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%r9), %ecx
	movl	$1, %edx
	shlq	%cl, %rdx
	cmpb	$63, %cl
	ja	.LBB8_116
# %bb.113:                              #   in Loop: Header=BB8_112 Depth=1
	andq	%rax, %rdx
	je	.LBB8_116
# %bb.114:                              #   in Loop: Header=BB8_112 Depth=1
	addq	$1, %r9
	addq	$-1, %rdi
	jne	.LBB8_112
# %bb.115:
	movq	$-1, %r9
	jmp	.LBB8_117
.LBB8_116:
	subq	%rsi, %r9
.LBB8_117:
	movb	%r9b, (%rbp)
	movzbl	%r9b, %esi
	movb	(%r15), %r11b
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movq	16(%r15), %r12
	movq	8(%r15), %r8
	movq	%r12, %rdi
	cmoveq	%r14, %rdi
	movzbl	%al, %r15d
	movq	%r8, %rdx
	cmoveq	%r15, %rdx
	movq	%rdx, %rax
	subq	%rsi, %rax
	jbe	.LBB8_124
# %bb.118:
	leaq	(%rdi,%rsi), %rcx
	addq	%rdi, %rdx
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB8_119:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rcx), %ebp
	cmpq	$44, %rbp
	ja	.LBB8_121
# %bb.120:                              #   in Loop: Header=BB8_119 Depth=1
	btq	%rbp, %rbx
	jb	.LBB8_123
.LBB8_121:                              #   in Loop: Header=BB8_119 Depth=1
	addq	$1, %rcx
	addq	$-1, %rax
	jne	.LBB8_119
# %bb.122:
	movq	%rdx, %rcx
.LBB8_123:
	movq	%rcx, %rax
	subq	%rdi, %rax
	cmpq	%rdx, %rcx
	movq	$-1, %r10
	cmovneq	%rax, %r10
.LBB8_124:
	cmpb	$-1, %r9b
	je	.LBB8_127
# %bb.125:
	cmpb	$59, (%rdi,%rsi)
	movq	8(%rsp), %rdx           # 8-byte Reload
	jne	.LBB8_129
.LBB8_104:
	xorl	%r15d, %r15d
	cmpb	$-1, %dl
	je	.LBB8_128
.LBB8_105:
	testb	$1, %r11b
	cmoveq	%r14, %r12
	movzbl	%r9b, %esi
	movl	%r15d, %eax
	andb	$-2, %al
	movb	$-1, %bl
	cmpb	$2, %al
	jne	.LBB8_260
# %bb.106:
	cmpb	$99, (%r12,%rsi)
	jne	.LBB8_260
# %bb.107:
	movsbl	1(%r12,%rsi), %eax
	cmpb	$2, %r15b
	jne	.LBB8_131
# %bb.108:
	leal	-48(%rax), %ecx
	cmpl	$10, %ecx
	jb	.LBB8_256
.LBB8_109:
	movb	$-1, %bl
	jmp	.LBB8_260
.LBB8_127:
	movb	$-1, %r9b
	xorl	%r15d, %r15d
	movq	8(%rsp), %rdx           # 8-byte Reload
	cmpb	$-1, %dl
	jne	.LBB8_105
.LBB8_128:
	movl	$-1, %r12d
	movq	%fs:40, %rax
	cmpq	64(%rsp), %rax
	je	.LBB8_408
.LBB8_513:
	callq	__stack_chk_fail@PLT
.LBB8_129:
	cmpq	$-1, %r10
	je	.LBB8_133
# %bb.130:
	movl	%r10d, %r15d
	testb	$1, %r11b
	je	.LBB8_135
.LBB8_134:
	movl	%r10d, %r15d
.LBB8_135:
	subb	%r9b, %r15b
	cmpb	$-1, %dl
	jne	.LBB8_105
	jmp	.LBB8_128
.LBB8_131:
	movq	%rdx, %rbp
	leal	(%rax,%rax,4), %edx
	movsbl	2(%r12,%rsi), %ecx
	leal	(%rcx,%rdx,2), %edi
	addl	$-528, %edi             # imm = 0xFDF0
	cmpl	$31, %edi
	ja	.LBB8_257
# %bb.132:
	leal	(%rcx,%rdx,2), %ebx
	addb	$-16, %bl
	movq	%rbp, %rdx
	jmp	.LBB8_260
.LBB8_133:
	movl	%r8d, %r10d
	testb	$1, %r11b
	je	.LBB8_135
	jmp	.LBB8_134
.LBB8_136:
	addb	$-48, %al
                                        # kill: def %al killed %al killed %rax def %eax
.LBB8_137:
	movl	%eax, (%rsp)            # 4-byte Spill
.LBB8_138:
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movzbl	%al, %eax
	cmovneq	%r8, %rax
	cmpq	%rdi, %rax
	movq	%rsi, 16(%rsp)          # 8-byte Spill
	jne	.LBB8_140
# %bb.139:
	xorl	%r10d, %r10d
	movl	(%rsp), %ebx            # 4-byte Reload
	movq	8(%rsp), %r13           # 8-byte Reload
	movl	$-1, %r12d
	cmpb	$-1, %bl
	jne	.LBB8_163
	jmp	.LBB8_407
.LBB8_140:
	addb	%r13b, %r9b
	movzbl	%r9b, %ecx
	movq	$-1, %rdi
	movq	$-1, %r9
	subq	%rcx, %rax
	movq	8(%rsp), %r13           # 8-byte Reload
	jbe	.LBB8_147
# %bb.141:
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%rbx, %rcx
	movq	%rcx, %r9
	.p2align	4, 0x90
.LBB8_142:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%r9), %ecx
	movl	$1, %ebp
	shlq	%cl, %rbp
	cmpb	$63, %cl
	ja	.LBB8_146
# %bb.143:                              #   in Loop: Header=BB8_142 Depth=1
	andq	%rdx, %rbp
	je	.LBB8_146
# %bb.144:                              #   in Loop: Header=BB8_142 Depth=1
	addq	$1, %r9
	addq	$-1, %rax
	jne	.LBB8_142
# %bb.145:
	movq	$-1, %r9
	jmp	.LBB8_147
.LBB8_146:
	subq	%rbx, %r9
.LBB8_147:
	movb	%r9b, (%rsi)
	movzbl	%r9b, %r14d
	movb	(%r15), %r11b
	movl	%r11d, %ecx
	shrb	%cl
	testb	$1, %r11b
	movq	16(%r15), %rax
	movq	8(%r15), %r8
	movq	%rax, %r12
	cmoveq	%r13, %rax
	movzbl	%cl, %r10d
	movq	%r8, %rbp
	cmoveq	%r10, %rbp
	movq	%rbp, %rdx
	subq	%r14, %rdx
	jbe	.LBB8_154
# %bb.148:
	leaq	(%rax,%r14), %rcx
	addq	%rax, %rbp
	movabsq	$20895015895552, %rdi   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB8_149:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rcx), %ebx
	cmpq	$44, %rbx
	ja	.LBB8_151
# %bb.150:                              #   in Loop: Header=BB8_149 Depth=1
	btq	%rbx, %rdi
	jb	.LBB8_153
.LBB8_151:                              #   in Loop: Header=BB8_149 Depth=1
	addq	$1, %rcx
	addq	$-1, %rdx
	jne	.LBB8_149
# %bb.152:
	movq	%rbp, %rcx
.LBB8_153:
	movq	%rcx, %rdx
	subq	%rax, %rdx
	cmpq	%rbp, %rcx
	movq	$-1, %rdi
	cmovneq	%rdx, %rdi
.LBB8_154:
	cmpb	$-1, %r9b
	movl	(%rsp), %ebx            # 4-byte Reload
	je	.LBB8_158
# %bb.155:
	cmpb	$59, (%rax,%r14)
	je	.LBB8_159
# %bb.156:
	cmpq	$-1, %rdi
	movq	%r12, %r14
	je	.LBB8_160
# %bb.157:
	movl	%edi, %r10d
	testb	$1, %r11b
	je	.LBB8_162
.LBB8_161:
	movl	%edi, %r10d
.LBB8_162:
	subb	%r9b, %r10b
	movl	$-1, %r12d
	cmpb	$-1, %bl
	jne	.LBB8_163
	jmp	.LBB8_407
.LBB8_158:
	movb	$-1, %r9b
.LBB8_159:
	xorl	%r10d, %r10d
	movq	%r12, %r14
	movl	$-1, %r12d
	cmpb	$-1, %bl
	je	.LBB8_407
.LBB8_163:
	movl	%r11d, %eax
	andb	$1, %al
	movq	%r14, %rdi
	cmoveq	%r13, %rdi
	movzbl	%r9b, %esi
	movl	%r10d, %ecx
	andb	$-2, %cl
	movb	$-1, %bpl
	cmpb	$2, %cl
	jne	.LBB8_274
# %bb.164:
	cmpb	$99, (%rdi,%rsi)
	jne	.LBB8_274
# %bb.165:
	movsbl	1(%rdi,%rsi), %ecx
	cmpb	$2, %r10b
	jne	.LBB8_168
# %bb.166:
	leal	-48(%rcx), %edx
	cmpl	$10, %edx
	jae	.LBB8_273
# %bb.167:
	addb	$-48, %cl
	movl	%ecx, %ebp
	jmp	.LBB8_274
.LBB8_160:
	movl	%r8d, %edi
	testb	$1, %r11b
	je	.LBB8_162
	jmp	.LBB8_161
.LBB8_168:
	leal	(%rcx,%rcx,4), %ebx
	movsbl	2(%rdi,%rsi), %edx
	leal	(%rdx,%rbx,2), %ebp
	addl	$-528, %ebp             # imm = 0xFDF0
	cmpl	$31, %ebp
	ja	.LBB8_270
# %bb.169:
	leal	(%rdx,%rbx,2), %ebp
	addb	$-16, %bpl
	movl	(%rsp), %ebx            # 4-byte Reload
	jmp	.LBB8_274
.LBB8_170:
	cmpb	$115, %al
	jne	.LBB8_172
# %bb.171:
	movb	$18, %dl
	cmpb	$112, %cl
	je	.LBB8_174
.LBB8_172:
	cmpb	$108, %al
	jne	.LBB8_407
# %bb.173:
	movb	$19, %dl
	cmpb	$114, %cl
	jne	.LBB8_407
.LBB8_174:
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movzbl	%al, %eax
	cmoveq	%rax, %r8
	cmpq	%rbp, %r8
	je	.LBB8_407
# %bb.175:
	movq	%rdx, 8(%rsp)           # 8-byte Spill
	addb	%r13b, %r9b
	movzbl	%r9b, %eax
	movq	$-1, %r14
	subq	%rax, %r8
	jbe	.LBB8_357
# %bb.176:
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%rdi, %rax
.LBB8_177:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %ecx
	movl	$1, %ebx
	shlq	%cl, %rbx
	cmpb	$63, %cl
	ja	.LBB8_356
# %bb.178:                              #   in Loop: Header=BB8_177 Depth=1
	andq	%rdx, %rbx
	je	.LBB8_356
# %bb.179:                              #   in Loop: Header=BB8_177 Depth=1
	addq	$1, %rax
	addq	$-1, %r8
	jne	.LBB8_177
	jmp	.LBB8_357
.LBB8_180:
	cmpb	$115, %al
	jne	.LBB8_182
# %bb.181:
	movb	$18, %bl
	cmpb	$112, %cl
	je	.LBB8_184
.LBB8_182:
	xorb	$108, %al
	xorb	$114, %cl
	orb	%al, %cl
	movb	$19, %bl
	je	.LBB8_184
.LBB8_183:
	movb	$-1, %bl
.LBB8_184:
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movzbl	%al, %eax
	cmovneq	%r8, %rax
	cmpq	%rbp, %rax
	movq	%rsi, 16(%rsp)          # 8-byte Spill
	movq	%r14, 8(%rsp)           # 8-byte Spill
	jne	.LBB8_186
# %bb.185:
	xorl	%r14d, %r14d
	movl	$-1, %r12d
	cmpb	$-1, %bl
	jne	.LBB8_209
	jmp	.LBB8_407
.LBB8_186:
	movl	%ebx, (%rsp)            # 4-byte Spill
	addb	%r13b, %r9b
	movzbl	%r9b, %ecx
	movq	$-1, %rbx
	movq	$-1, %r9
	subq	%rcx, %rax
	jbe	.LBB8_193
# %bb.187:
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%rdi, %rcx
	movq	%rcx, %r9
	.p2align	4, 0x90
.LBB8_188:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%r9), %ecx
	movl	$1, %ebp
	shlq	%cl, %rbp
	cmpb	$63, %cl
	ja	.LBB8_192
# %bb.189:                              #   in Loop: Header=BB8_188 Depth=1
	andq	%rdx, %rbp
	je	.LBB8_192
# %bb.190:                              #   in Loop: Header=BB8_188 Depth=1
	addq	$1, %r9
	addq	$-1, %rax
	jne	.LBB8_188
# %bb.191:
	movq	$-1, %r9
	jmp	.LBB8_193
.LBB8_192:
	subq	%rdi, %r9
.LBB8_193:
	movb	%r9b, (%rsi)
	movzbl	%r9b, %r12d
	movb	(%r15), %r11b
	movl	%r11d, %ecx
	shrb	%cl
	testb	$1, %r11b
	movq	16(%r15), %r10
	movq	8(%r15), %r8
	movq	%r10, %rax
	cmoveq	%r14, %rax
	movzbl	%cl, %r14d
	movq	%r8, %rdx
	cmoveq	%r14, %rdx
	movq	%rdx, %rbp
	subq	%r12, %rbp
	jbe	.LBB8_200
# %bb.194:
	leaq	(%rax,%r12), %rcx
	addq	%rax, %rdx
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB8_195:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rcx), %edi
	cmpq	$44, %rdi
	ja	.LBB8_197
# %bb.196:                              #   in Loop: Header=BB8_195 Depth=1
	btq	%rdi, %rbx
	jb	.LBB8_199
.LBB8_197:                              #   in Loop: Header=BB8_195 Depth=1
	addq	$1, %rcx
	addq	$-1, %rbp
	jne	.LBB8_195
# %bb.198:
	movq	%rdx, %rcx
.LBB8_199:
	movq	%rcx, %rdi
	subq	%rax, %rdi
	cmpq	%rdx, %rcx
	movq	$-1, %rbx
	cmovneq	%rdi, %rbx
.LBB8_200:
	cmpb	$-1, %r9b
	je	.LBB8_203
# %bb.201:
	cmpb	$59, (%rax,%r12)
	je	.LBB8_202
# %bb.204:
	cmpq	$-1, %rbx
	je	.LBB8_206
# %bb.205:
	movl	%ebx, %r14d
	testb	$1, %r11b
	je	.LBB8_208
.LBB8_207:
	movl	%ebx, %r14d
.LBB8_208:
	subb	%r9b, %r14b
	movl	(%rsp), %ebx            # 4-byte Reload
	movl	$-1, %r12d
	cmpb	$-1, %bl
	jne	.LBB8_209
	jmp	.LBB8_407
.LBB8_203:
	movb	$-1, %r9b
.LBB8_202:
	xorl	%r14d, %r14d
	movl	(%rsp), %ebx            # 4-byte Reload
	movl	$-1, %r12d
	cmpb	$-1, %bl
	je	.LBB8_407
.LBB8_209:
	movzbl	%r9b, %eax
	movl	%r11d, %ecx
	shrb	%cl
	testb	$1, %r11b
	movzbl	%cl, %ecx
	cmoveq	%rcx, %r8
	cmpq	%rax, %r8
	jne	.LBB8_211
# %bb.210:
	movq	$-1, %r10
	xorl	%r14d, %r14d
	movswl	%r10w, %eax
	cmpl	%r10d, %eax
	je	.LBB8_236
	jmp	.LBB8_407
.LBB8_211:
	addb	%r14b, %r9b
	testb	$1, %r11b
	movq	8(%rsp), %rbp           # 8-byte Reload
	cmoveq	%rbp, %r10
	movzbl	%r9b, %ecx
	movq	$-1, %rdi
	movq	$-1, %rax
	subq	%rcx, %r8
	jbe	.LBB8_218
# %bb.212:
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%r10, %rcx
	movq	%rcx, %rax
	.p2align	4, 0x90
.LBB8_213:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %ecx
	movl	$1, %esi
	shlq	%cl, %rsi
	cmpb	$63, %cl
	ja	.LBB8_217
# %bb.214:                              #   in Loop: Header=BB8_213 Depth=1
	andq	%rdx, %rsi
	je	.LBB8_217
# %bb.215:                              #   in Loop: Header=BB8_213 Depth=1
	addq	$1, %rax
	addq	$-1, %r8
	jne	.LBB8_213
# %bb.216:
	movq	$-1, %rax
	jmp	.LBB8_218
.LBB8_217:
	subq	%r10, %rax
.LBB8_218:
	movq	16(%rsp), %rcx          # 8-byte Reload
	movb	%al, (%rcx)
	movzbl	%al, %r11d
	movb	(%r15), %r13b
	movl	%r13d, %edx
	shrb	%dl
	testb	$1, %r13b
	movq	16(%r15), %r8
	movq	8(%r15), %r9
	movq	%r8, %rcx
	cmoveq	%rbp, %rcx
	movzbl	%dl, %r14d
	movq	%r9, %rbp
	cmoveq	%r14, %rbp
	movq	%rbp, %rsi
	subq	%r11, %rsi
	jbe	.LBB8_225
# %bb.219:
	movl	%ebx, %r10d
	leaq	(%rcx,%r11), %rdi
	addq	%rcx, %rbp
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB8_220:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %ebx
	cmpq	$44, %rbx
	ja	.LBB8_222
# %bb.221:                              #   in Loop: Header=BB8_220 Depth=1
	btq	%rbx, %rdx
	jb	.LBB8_224
.LBB8_222:                              #   in Loop: Header=BB8_220 Depth=1
	addq	$1, %rdi
	addq	$-1, %rsi
	jne	.LBB8_220
# %bb.223:
	movq	%rbp, %rdi
.LBB8_224:
	movl	%r10d, %ebx
	movq	%rdi, %rdx
	subq	%rcx, %rdx
	cmpq	%rbp, %rdi
	movq	$-1, %rdi
	cmovneq	%rdx, %rdi
.LBB8_225:
	movq	$-1, %r10
	cmpb	$-1, %al
	je	.LBB8_228
# %bb.226:
	cmpb	$59, (%rcx,%r11)
	jne	.LBB8_229
.LBB8_228:
	xorl	%r14d, %r14d
	movswl	%r10w, %eax
	cmpl	%r10d, %eax
	je	.LBB8_236
	jmp	.LBB8_407
.LBB8_229:
	cmpq	$-1, %rdi
	je	.LBB8_231
# %bb.230:
	movl	%edi, %r9d
	movl	%edi, %r14d
.LBB8_231:
	testb	$1, %r13b
	je	.LBB8_233
# %bb.232:
	movl	%r9d, %r14d
.LBB8_233:
	subb	%al, %r14b
	movl	%r14d, %ecx
	addb	$-1, %cl
	cmpb	$10, %cl
	ja	.LBB8_235
# %bb.234:
	testb	$1, %r13b
	cmoveq	8(%rsp), %r8            # 8-byte Folded Reload
	movl	%ebx, %r13d
	movzbl	%al, %ebx
	addq	%r8, %rbx
	leaq	52(%rsp), %rax
	movq	%rax, 40(%rsp)
	callq	__errno_location@PLT
	movq	%rax, (%rsp)            # 8-byte Spill
	movl	$0, (%rax)
	movzbl	%r14b, %ebp
	leaq	52(%rsp), %rdi
	movq	%rbx, %rsi
	movl	%r13d, %ebx
	movq	%rbp, %rdx
	callq	memcpy@PLT
	movb	$0, 52(%rsp,%rbp)
	leaq	40(%rsp), %rsi
	xorl	%edx, %edx
	leaq	52(%rsp), %rdi
	callq	strtol@PLT
	movq	(%rsp), %rcx            # 8-byte Reload
	cmpl	$1, (%rcx)
	movl	%eax, %eax
	sbbq	%r10, %r10
	notq	%r10
	orq	%rax, %r10
.LBB8_235:
	movswl	%r10w, %eax
	cmpl	%r10d, %eax
	jne	.LBB8_407
.LBB8_236:
	movq	16(%rsp), %rsi          # 8-byte Reload
	movzbl	(%rsi), %eax
	movb	(%r15), %cl
	testb	$1, %cl
	je	.LBB8_238
# %bb.237:
	movq	16(%r15), %rdx
	movq	%rdx, 8(%rsp)           # 8-byte Spill
.LBB8_238:
	movl	%r14d, %edx
	andb	$-2, %dl
	movb	$-1, %bpl
	cmpb	$2, %dl
	jne	.LBB8_394
# %bb.239:
	movq	8(%rsp), %rdx           # 8-byte Reload
	cmpb	$99, (%rdx,%rax)
	jne	.LBB8_394
# %bb.240:
	movq	8(%rsp), %rdi           # 8-byte Reload
	movsbl	1(%rdi,%rax), %edx
	cmpb	$2, %r14b
	jne	.LBB8_324
# %bb.241:
	leal	-48(%rdx), %edi
	cmpl	$10, %edi
	jae	.LBB8_393
# %bb.242:
	addb	$-48, %dl
	movl	%edx, %ebp
	testb	$1, %cl
	je	.LBB8_396
	jmp	.LBB8_395
.LBB8_206:
	movl	%r8d, %ebx
	testb	$1, %r11b
	je	.LBB8_208
	jmp	.LBB8_207
.LBB8_243:
	cmpb	$115, %al
	jne	.LBB8_245
# %bb.244:
	movb	$18, %dl
	cmpb	$112, %cl
	je	.LBB8_247
.LBB8_245:
	cmpb	$108, %al
	jne	.LBB8_407
# %bb.246:
	movb	$19, %dl
	cmpb	$114, %cl
	jne	.LBB8_407
.LBB8_247:
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movzbl	%al, %eax
	cmoveq	%rax, %r8
	cmpq	%rbp, %r8
	je	.LBB8_407
# %bb.248:
	movq	%rdx, 8(%rsp)           # 8-byte Spill
	addb	%r13b, %r9b
	movzbl	%r9b, %eax
	movq	$-1, %r10
	subq	%rax, %r8
	jbe	.LBB8_374
# %bb.249:
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%rsi, %rax
.LBB8_250:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %ecx
	movl	$1, %ebx
	shlq	%cl, %rbx
	cmpb	$63, %cl
	ja	.LBB8_373
# %bb.251:                              #   in Loop: Header=BB8_250 Depth=1
	andq	%rdx, %rbx
	je	.LBB8_373
# %bb.252:                              #   in Loop: Header=BB8_250 Depth=1
	addq	$1, %rax
	addq	$-1, %r8
	jne	.LBB8_250
	jmp	.LBB8_374
.LBB8_253:
	cmpb	$115, %al
	jne	.LBB8_255
# %bb.254:
	movb	$18, %dl
	movl	%edx, (%rsp)            # 4-byte Spill
	cmpb	$112, %cl
	je	.LBB8_138
.LBB8_255:
	xorb	$108, %al
	xorb	$114, %cl
	orb	%al, %cl
	movb	$19, %al
	movl	%eax, (%rsp)            # 4-byte Spill
	jne	.LBB8_62
	jmp	.LBB8_138
.LBB8_256:
	addb	$-48, %al
	movl	%eax, %ebx
	jmp	.LBB8_260
.LBB8_257:
	cmpb	$115, %al
	movq	%rbp, %rdx
	jne	.LBB8_259
# %bb.258:
	movb	$18, %bl
	cmpb	$112, %cl
	je	.LBB8_260
.LBB8_259:
	xorb	$108, %al
	xorb	$114, %cl
	orb	%al, %cl
	movb	$19, %bl
	jne	.LBB8_109
.LBB8_260:
	movl	%r11d, %eax
	shrb	%al
	testb	$1, %r11b
	movzbl	%al, %eax
	cmoveq	%rax, %r8
	cmpq	%rsi, %r8
	je	.LBB8_269
# %bb.261:
	addb	%r15b, %r9b
	movzbl	%r9b, %esi
	movb	$-1, %al
	subq	%rsi, %r8
	jbe	.LBB8_268
# %bb.262:
	movq	%rdx, %rbp
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%r12, %rsi
	.p2align	4, 0x90
.LBB8_263:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rsi), %ecx
	movl	$1, %edi
	shlq	%cl, %rdi
	cmpb	$63, %cl
	ja	.LBB8_266
# %bb.264:                              #   in Loop: Header=BB8_263 Depth=1
	andq	%rdx, %rdi
	je	.LBB8_266
# %bb.265:                              #   in Loop: Header=BB8_263 Depth=1
	addq	$1, %rsi
	addq	$-1, %r8
	jne	.LBB8_263
	jmp	.LBB8_267
.LBB8_266:
	subl	%r12d, %esi
	movl	%esi, %eax
.LBB8_267:
	movq	%rbp, %rdx
.LBB8_268:
	movq	16(%rsp), %rcx          # 8-byte Reload
	movb	%al, (%rcx)
.LBB8_269:
	xorl	%r10d, %r10d
	xorl	%ebp, %ebp
	jmp	.LBB8_406
.LBB8_270:
	cmpb	$115, %cl
	movl	(%rsp), %ebx            # 4-byte Reload
	jne	.LBB8_272
# %bb.271:
	movb	$18, %bpl
	cmpb	$112, %dl
	je	.LBB8_274
.LBB8_272:
	xorb	$108, %cl
	xorb	$114, %dl
	orb	%cl, %dl
	movb	$19, %bpl
	je	.LBB8_274
.LBB8_273:
	movb	$-1, %bpl
.LBB8_274:
	shrb	%r11b
	testb	%al, %al
	movzbl	%r11b, %ecx
	cmoveq	%rcx, %r8
	cmpq	%rsi, %r8
	jne	.LBB8_276
# %bb.275:
	xorl	%r13d, %r13d
	movzbl	%r9b, %ecx
	movq	$-1, %rdx
	cmpq	%rcx, %r8
	jne	.LBB8_299
	jmp	.LBB8_322
.LBB8_276:
	addb	%r10b, %r9b
	movzbl	%r9b, %ecx
	movq	$-1, %r11
	movq	$-1, %r9
	subq	%rcx, %r8
	jbe	.LBB8_283
# %bb.277:
	movabsq	$20895015895552, %rax   # imm = 0x130100000200
	addq	%rdi, %rcx
	movq	%rcx, %r9
	.p2align	4, 0x90
.LBB8_278:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%r9), %ecx
	movl	$1, %edx
	shlq	%cl, %rdx
	cmpb	$63, %cl
	ja	.LBB8_282
# %bb.279:                              #   in Loop: Header=BB8_278 Depth=1
	andq	%rax, %rdx
	je	.LBB8_282
# %bb.280:                              #   in Loop: Header=BB8_278 Depth=1
	addq	$1, %r9
	addq	$-1, %r8
	jne	.LBB8_278
# %bb.281:
	movq	$-1, %r9
	jmp	.LBB8_283
.LBB8_282:
	subq	%rdi, %r9
.LBB8_283:
	movq	16(%rsp), %rax          # 8-byte Reload
	movb	%r9b, (%rax)
	movzbl	%r9b, %r14d
	movb	(%r15), %al
	movl	%eax, %ecx
	shrb	%cl
	andb	$1, %al
	movq	16(%r15), %rsi
	movq	8(%r15), %r10
	movq	%rsi, 24(%rsp)          # 8-byte Spill
	cmoveq	%r13, %rsi
	movzbl	%cl, %r13d
	movq	%r10, %r8
	cmoveq	%r13, %r8
	movq	%r8, %rdx
	subq	%r14, %rdx
	jbe	.LBB8_290
# %bb.284:
	leaq	(%rsi,%r14), %rdi
	leaq	(%rsi,%r8), %r11
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB8_285:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %ecx
	cmpq	$44, %rcx
	ja	.LBB8_287
# %bb.286:                              #   in Loop: Header=BB8_285 Depth=1
	btq	%rcx, %rbx
	jb	.LBB8_289
.LBB8_287:                              #   in Loop: Header=BB8_285 Depth=1
	addq	$1, %rdi
	addq	$-1, %rdx
	jne	.LBB8_285
# %bb.288:
	movq	%r11, %rdi
.LBB8_289:
	movq	%rdi, %rcx
	subq	%rsi, %rcx
	cmpq	%r11, %rdi
	movq	$-1, %r11
	cmovneq	%rcx, %r11
	movl	(%rsp), %ebx            # 4-byte Reload
.LBB8_290:
	cmpb	$-1, %r9b
	je	.LBB8_297
# %bb.291:
	cmpb	$59, (%rsi,%r14)
	je	.LBB8_298
# %bb.292:
	cmpq	$-1, %r11
	movq	24(%rsp), %r14          # 8-byte Reload
	je	.LBB8_294
# %bb.293:
	movl	%r11d, %r10d
	movl	%r11d, %r13d
.LBB8_294:
	testb	%al, %al
	je	.LBB8_296
# %bb.295:
	movl	%r10d, %r13d
.LBB8_296:
	subb	%r9b, %r13b
	movzbl	%r9b, %ecx
	movq	$-1, %rdx
	cmpq	%rcx, %r8
	jne	.LBB8_299
	jmp	.LBB8_322
.LBB8_297:
	movb	$-1, %r9b
.LBB8_298:
	xorl	%r13d, %r13d
	movq	24(%rsp), %r14          # 8-byte Reload
	movzbl	%r9b, %ecx
	movq	$-1, %rdx
	cmpq	%rcx, %r8
	je	.LBB8_322
.LBB8_299:
	addb	%r13b, %r9b
	testb	%al, %al
	movq	8(%rsp), %rbx           # 8-byte Reload
	cmoveq	%rbx, %r14
	movzbl	%r9b, %ecx
	movq	$-1, %rsi
	movq	$-1, %rax
	subq	%rcx, %r8
	jbe	.LBB8_306
# %bb.300:
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%r14, %rcx
	movq	%rcx, %rax
	.p2align	4, 0x90
.LBB8_301:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %ecx
	movl	$1, %edi
	shlq	%cl, %rdi
	cmpb	$63, %cl
	ja	.LBB8_305
# %bb.302:                              #   in Loop: Header=BB8_301 Depth=1
	andq	%rdx, %rdi
	je	.LBB8_305
# %bb.303:                              #   in Loop: Header=BB8_301 Depth=1
	addq	$1, %rax
	addq	$-1, %r8
	jne	.LBB8_301
# %bb.304:
	movq	$-1, %rax
	jmp	.LBB8_306
.LBB8_305:
	subq	%r14, %rax
.LBB8_306:
	movq	16(%rsp), %rcx          # 8-byte Reload
	movb	%al, (%rcx)
	movzbl	%al, %r11d
	movb	(%r15), %r8b
	movl	%r8d, %ecx
	shrb	%cl
	testb	$1, %r8b
	movq	16(%r15), %r9
	movq	8(%r15), %r10
	movq	%r9, %rdi
	cmoveq	%rbx, %rdi
	movzbl	%cl, %r14d
	movq	%r10, %rdx
	cmoveq	%r14, %rdx
	movq	%rdx, %rbx
	subq	%r11, %rbx
	jbe	.LBB8_313
# %bb.307:
	leaq	(%rdi,%r11), %rsi
	addq	%rdi, %rdx
	movabsq	$20895015895552, %r15   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB8_308:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rsi), %ecx
	cmpq	$44, %rcx
	ja	.LBB8_310
# %bb.309:                              #   in Loop: Header=BB8_308 Depth=1
	btq	%rcx, %r15
	jb	.LBB8_312
.LBB8_310:                              #   in Loop: Header=BB8_308 Depth=1
	addq	$1, %rsi
	addq	$-1, %rbx
	jne	.LBB8_308
# %bb.311:
	movq	%rdx, %rsi
.LBB8_312:
	movq	%rsi, %rcx
	subq	%rdi, %rcx
	cmpq	%rdx, %rsi
	movq	$-1, %rsi
	cmovneq	%rcx, %rsi
.LBB8_313:
	movq	$-1, %rdx
	cmpb	$-1, %al
	je	.LBB8_321
# %bb.314:
	cmpb	$59, (%rdi,%r11)
	movl	(%rsp), %ebx            # 4-byte Reload
	je	.LBB8_322
# %bb.315:
	cmpq	$-1, %rsi
	je	.LBB8_317
# %bb.316:
	movl	%esi, %r10d
	movl	%esi, %r14d
.LBB8_317:
	testb	$1, %r8b
	je	.LBB8_319
# %bb.318:
	movl	%r10d, %r14d
.LBB8_319:
	subb	%al, %r14b
	movl	%r14d, %ecx
	addb	$-1, %cl
	cmpb	$10, %cl
	ja	.LBB8_322
# %bb.320:
	testb	$1, %r8b
	cmoveq	8(%rsp), %r9            # 8-byte Folded Reload
	movzbl	%al, %r15d
	addq	%r9, %r15
	leaq	52(%rsp), %rax
	movq	%rax, 40(%rsp)
	callq	__errno_location@PLT
	movq	%rax, %r13
	movl	$0, (%r13)
	movzbl	%r14b, %r14d
	leaq	52(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	movb	$0, 52(%rsp,%r14)
	leaq	40(%rsp), %rsi
	xorl	%edx, %edx
	leaq	52(%rsp), %rdi
	callq	strtol@PLT
	cmpl	$1, (%r13)
	movl	%eax, %eax
	sbbq	%rdx, %rdx
	notq	%rdx
	orq	%rax, %rdx
	movswl	%dx, %eax
	cmpl	%edx, %eax
	je	.LBB8_323
	jmp	.LBB8_407
.LBB8_321:
	movl	(%rsp), %ebx            # 4-byte Reload
.LBB8_322:
	movswl	%dx, %eax
	cmpl	%edx, %eax
	jne	.LBB8_407
.LBB8_323:
	movl	%edx, %r10d
	andl	$1023, %r10d            # imm = 0x3FF
	shrq	$11, %rdx
	andb	$31, %dl
	jmp	.LBB8_406
.LBB8_324:
	movl	%ebx, %r8d
	leal	(%rdx,%rdx,4), %ebp
	movsbl	2(%rdi,%rax), %edi
	leal	(%rdi,%rbp,2), %ebx
	addl	$-528, %ebx             # imm = 0xFDF0
	cmpl	$31, %ebx
	ja	.LBB8_390
# %bb.325:
	leal	(%rdi,%rbp,2), %ebp
	addb	$-16, %bpl
	movl	%r8d, %ebx
	testb	$1, %cl
	jne	.LBB8_395
.LBB8_396:
	shrb	%cl
	movzbl	%cl, %edx
	cmpq	%rax, %rdx
	jne	.LBB8_397
	jmp	.LBB8_405
.LBB8_326:
	subq	%rsi, %rax
.LBB8_327:
	movq	%rbx, %rdx
.LBB8_328:
	movq	16(%rsp), %rcx          # 8-byte Reload
	movb	%al, (%rcx)
	movzbl	%al, %r11d
	movb	(%r15), %r8b
	movl	%r8d, %ecx
	shrb	%cl
	testb	$1, %r8b
	movq	16(%r15), %rbp
	movq	8(%r15), %r9
	movq	%rbp, (%rsp)            # 8-byte Spill
	cmoveq	%r14, %rbp
	movzbl	%cl, %r13d
	movq	%r9, %rbx
	cmoveq	%r13, %rbx
	movq	%rbx, %rsi
	subq	%r11, %rsi
	jbe	.LBB8_335
# %bb.329:
	movq	%rdx, %r10
	leaq	(%r11,%rbp), %rdi
	addq	%rbp, %rbx
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
.LBB8_330:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %ecx
	cmpq	$44, %rcx
	ja	.LBB8_332
# %bb.331:                              #   in Loop: Header=BB8_330 Depth=1
	btq	%rcx, %rdx
	jb	.LBB8_334
.LBB8_332:                              #   in Loop: Header=BB8_330 Depth=1
	addq	$1, %rdi
	addq	$-1, %rsi
	jne	.LBB8_330
# %bb.333:
	movq	%rbx, %rdi
.LBB8_334:
	movq	%rdi, %rcx
	subq	%rbp, %rcx
	cmpq	%rbx, %rdi
	movq	$-1, %rdi
	cmovneq	%rcx, %rdi
	movq	%r10, %rdx
.LBB8_335:
	movq	$-1, %r10
	cmpb	$-1, %al
	je	.LBB8_338
# %bb.336:
	cmpb	$59, (%rbp,%r11)
	jne	.LBB8_339
.LBB8_338:
	xorl	%r13d, %r13d
	movswl	%r10w, %eax
	cmpl	%r10d, %eax
	je	.LBB8_346
	jmp	.LBB8_407
.LBB8_339:
	cmpq	$-1, %rdi
	je	.LBB8_341
# %bb.340:
	movl	%edi, %r9d
	movl	%edi, %r13d
.LBB8_341:
	testb	$1, %r8b
	je	.LBB8_343
# %bb.342:
	movl	%r9d, %r13d
.LBB8_343:
	subb	%al, %r13b
	movl	%r13d, %ecx
	addb	$-1, %cl
	cmpb	$10, %cl
	ja	.LBB8_345
# %bb.344:
	testb	$1, %r8b
	movq	(%rsp), %rcx            # 8-byte Reload
	cmoveq	%r14, %rcx
	movzbl	%al, %ebp
	addq	%rcx, %rbp
	leaq	52(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	%rdx, %rbx
	callq	__errno_location@PLT
	movq	%rax, (%rsp)            # 8-byte Spill
	movl	$0, (%rax)
	movzbl	%r13b, %eax
	leaq	52(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%rax, %rbp
	movq	%rbp, %rdx
	callq	memcpy@PLT
	movb	$0, 52(%rsp,%rbp)
	leaq	40(%rsp), %rsi
	xorl	%edx, %edx
	leaq	52(%rsp), %rdi
	callq	strtol@PLT
	movq	%rbx, %rdx
	movq	(%rsp), %rcx            # 8-byte Reload
	cmpl	$1, (%rcx)
	movl	%eax, %eax
	sbbq	%r10, %r10
	notq	%r10
	orq	%rax, %r10
.LBB8_345:
	movswl	%r10w, %eax
	cmpl	%r10d, %eax
	jne	.LBB8_407
.LBB8_346:
	movq	%rdx, 8(%rsp)           # 8-byte Spill
	movq	16(%rsp), %rax          # 8-byte Reload
	movzbl	(%rax), %ecx
	movb	(%r15), %al
	testb	$1, %al
	je	.LBB8_348
# %bb.347:
	movq	8(%r15), %rdx
	cmpq	%rcx, %rdx
	jne	.LBB8_349
	jmp	.LBB8_407
.LBB8_348:
	movl	%eax, %edx
	shrb	%dl
	movzbl	%dl, %edx
	cmpq	%rcx, %rdx
	je	.LBB8_407
.LBB8_349:
	addb	%r13b, %cl
	movzbl	%cl, %edi
	movq	%r14, %rbp
	testb	$1, %al
	je	.LBB8_351
# %bb.350:
	movq	16(%r15), %rbp
.LBB8_351:
	movq	$-1, %rsi
	subq	%rdi, %rdx
	jbe	.LBB8_410
# %bb.352:
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	addq	%rbp, %rdi
.LBB8_353:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %ecx
	movl	$1, %eax
	shlq	%cl, %rax
	cmpb	$63, %cl
	ja	.LBB8_409
# %bb.354:                              #   in Loop: Header=BB8_353 Depth=1
	andq	%rbx, %rax
	je	.LBB8_409
# %bb.355:                              #   in Loop: Header=BB8_353 Depth=1
	addq	$1, %rdi
	addq	$-1, %rdx
	jne	.LBB8_353
	jmp	.LBB8_410
.LBB8_356:
	subq	%rdi, %rax
	movq	%rax, %r14
.LBB8_357:
	movb	%r14b, (%r10)
	movzbl	%r14b, %edi
	movb	(%r15), %r11b
	movl	%r11d, %eax
	shrb	%al
	movq	8(%r15), %r9
	movzbl	%al, %r8d
	movq	%rsi, %r13
	movq	%r8, %rdx
	testb	$1, %r11b
	je	.LBB8_358
# %bb.360:
	movq	16(%r15), %r13
	movq	%r9, %rdx
	movq	$-1, %rbx
	movq	%rdx, %rax
	subq	%rdi, %rax
	ja	.LBB8_361
.LBB8_359:
	cmpb	$-1, %r14b
	jne	.LBB8_367
	jmp	.LBB8_407
.LBB8_358:
	movq	$-1, %rbx
	movq	%rdx, %rax
	subq	%rdi, %rax
	jbe	.LBB8_359
.LBB8_361:
	leaq	(%rdi,%r13), %rbx
	addq	%r13, %rdx
	movabsq	$20895015895552, %rcx   # imm = 0x130100000200
.LBB8_362:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx), %ebp
	cmpq	$44, %rbp
	ja	.LBB8_364
# %bb.363:                              #   in Loop: Header=BB8_362 Depth=1
	btq	%rbp, %rcx
	jb	.LBB8_366
.LBB8_364:                              #   in Loop: Header=BB8_362 Depth=1
	addq	$1, %rbx
	addq	$-1, %rax
	jne	.LBB8_362
# %bb.365:
	movq	%rdx, %rbx
.LBB8_366:
	movq	%rbx, %rax
	subq	%r13, %rax
	cmpq	%rdx, %rbx
	movq	$-1, %rbx
	cmovneq	%rax, %rbx
	cmpb	$-1, %r14b
	je	.LBB8_407
.LBB8_367:
	cmpb	$59, (%r13,%rdi)
	je	.LBB8_407
# %bb.368:
	cmpq	$-1, %rbx
	movq	%r8, %rax
	cmovneq	%rbx, %rax
	cmoveq	%r9, %rbx
	testb	$1, %r11b
	cmoveq	%rax, %rbx
	movl	%ebx, %ecx
	subb	%r14b, %cl
	movl	%ecx, %eax
	andb	$-2, %al
	cmpb	$2, %al
	jne	.LBB8_407
# %bb.369:
	movzbl	%r14b, %edi
	cmpb	$99, (%r13,%rdi)
	jne	.LBB8_407
# %bb.370:
	movsbl	1(%r13,%rdi), %eax
	cmpb	$2, %cl
	jne	.LBB8_431
# %bb.371:
	movl	%eax, %ecx
	addb	$-48, %cl
	movl	%ecx, %r14d
	cmpb	$-1, %cl
	je	.LBB8_407
# %bb.372:
	addl	$-48, %eax
	cmpl	$9, %eax
	jbe	.LBB8_441
	jmp	.LBB8_407
.LBB8_373:
	subq	%rsi, %rax
	movq	%rax, %r10
.LBB8_374:
	movb	%r10b, (%r14)
	movzbl	%r10b, %esi
	movb	(%r15), %r11b
	movl	%r11d, %eax
	shrb	%al
	movq	8(%r15), %r9
	movzbl	%al, %r8d
	movq	%rdi, %r13
	movq	%r8, %rdx
	testb	$1, %r11b
	je	.LBB8_375
# %bb.377:
	movq	16(%r15), %r13
	movq	%r9, %rdx
	movq	$-1, %rbx
	movq	%rdx, %rax
	subq	%rsi, %rax
	ja	.LBB8_378
.LBB8_376:
	cmpb	$-1, %r10b
	jne	.LBB8_384
	jmp	.LBB8_407
.LBB8_375:
	movq	$-1, %rbx
	movq	%rdx, %rax
	subq	%rsi, %rax
	jbe	.LBB8_376
.LBB8_378:
	leaq	(%rsi,%r13), %rbx
	addq	%r13, %rdx
	movabsq	$20895015895552, %rcx   # imm = 0x130100000200
.LBB8_379:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx), %ebp
	cmpq	$44, %rbp
	ja	.LBB8_381
# %bb.380:                              #   in Loop: Header=BB8_379 Depth=1
	btq	%rbp, %rcx
	jb	.LBB8_383
.LBB8_381:                              #   in Loop: Header=BB8_379 Depth=1
	addq	$1, %rbx
	addq	$-1, %rax
	jne	.LBB8_379
# %bb.382:
	movq	%rdx, %rbx
.LBB8_383:
	movq	%rbx, %rax
	subq	%r13, %rax
	cmpq	%rdx, %rbx
	movq	$-1, %rbx
	cmovneq	%rax, %rbx
	cmpb	$-1, %r10b
	je	.LBB8_407
.LBB8_384:
	cmpb	$59, (%r13,%rsi)
	je	.LBB8_407
# %bb.385:
	cmpq	$-1, %rbx
	movq	%r8, %rax
	cmovneq	%rbx, %rax
	cmoveq	%r9, %rbx
	testb	$1, %r11b
	cmoveq	%rax, %rbx
	movl	%ebx, %ecx
	subb	%r10b, %cl
	movl	%ecx, %eax
	andb	$-2, %al
	cmpb	$2, %al
	jne	.LBB8_407
# %bb.386:
	movzbl	%r10b, %ebp
	cmpb	$99, (%r13,%rbp)
	jne	.LBB8_407
# %bb.387:
	movsbl	1(%r13,%rbp), %eax
	cmpb	$2, %cl
	jne	.LBB8_433
# %bb.388:
	movl	%eax, %ecx
	addb	$-48, %cl
	movl	%ecx, (%rsp)            # 4-byte Spill
	cmpb	$-1, %cl
	je	.LBB8_407
# %bb.389:
	addl	$-48, %eax
	cmpl	$9, %eax
	jbe	.LBB8_451
	jmp	.LBB8_407
.LBB8_390:
	cmpb	$115, %dl
	movl	%r8d, %ebx
	jne	.LBB8_392
# %bb.391:
	movb	$18, %bpl
	cmpb	$112, %dil
	je	.LBB8_394
.LBB8_392:
	xorb	$108, %dl
	xorb	$114, %dil
	orb	%dl, %dil
	movb	$19, %bpl
	je	.LBB8_394
.LBB8_393:
	movb	$-1, %bpl
.LBB8_394:
	testb	$1, %cl
	je	.LBB8_396
.LBB8_395:
	movq	8(%r15), %rdx
	cmpq	%rax, %rdx
	je	.LBB8_405
.LBB8_397:
	addb	%r14b, %al
	movzbl	%al, %edi
	movb	$-1, %r8b
	subq	%rdi, %rdx
	jbe	.LBB8_404
# %bb.398:
	movl	%ebx, %r9d
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	movq	8(%rsp), %r11           # 8-byte Reload
	addq	%r11, %rdi
.LBB8_399:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %ecx
	movl	$1, %eax
	shlq	%cl, %rax
	cmpb	$63, %cl
	ja	.LBB8_402
# %bb.400:                              #   in Loop: Header=BB8_399 Depth=1
	andq	%rbx, %rax
	je	.LBB8_402
# %bb.401:                              #   in Loop: Header=BB8_399 Depth=1
	addq	$1, %rdi
	addq	$-1, %rdx
	jne	.LBB8_399
	jmp	.LBB8_403
.LBB8_402:
	subl	%r11d, %edi
	movl	%edi, %r8d
.LBB8_403:
	movl	%r9d, %ebx
.LBB8_404:
	movb	%r8b, (%rsi)
.LBB8_405:
	xorl	%edx, %edx
.LBB8_406:
	movq	32(%rsp), %rdi          # 8-byte Reload
	movq	%rdi, %r12
	shrq	$48, %r12
	shrq	$56, %rdi
	movzbl	%dl, %eax
	shll	$21, %eax
	movzbl	%bl, %ecx
	shll	$16, %ecx
	orl	%eax, %ecx
	movzbl	%bpl, %eax
	shll	$11, %eax
	movzwl	%r10w, %edx
	shll	$26, %r12d
	orl	%edi, %r12d
	orl	%edx, %r12d
	orl	%eax, %r12d
	orl	%ecx, %r12d
.LBB8_407:
	movq	%fs:40, %rax
	cmpq	64(%rsp), %rax
	jne	.LBB8_513
.LBB8_408:
	movl	%r12d, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB8_409:
	subq	%rbp, %rdi
	movq	%rdi, %rsi
.LBB8_410:
	movq	16(%rsp), %rax          # 8-byte Reload
	movb	%sil, (%rax)
	movzbl	%sil, %ebp
	movb	(%r15), %r11b
	movl	%r11d, %eax
	shrb	%al
	movq	8(%r15), %r8
	movzbl	%al, %r9d
	movq	%r9, %rbx
	testb	$1, %r11b
	je	.LBB8_411
# %bb.413:
	movq	16(%r15), %r14
	movq	%r8, %rbx
	movq	$-1, %rdi
	movq	%rbx, %rcx
	subq	%rbp, %rcx
	ja	.LBB8_414
.LBB8_412:
	cmpb	$-1, %sil
	jne	.LBB8_420
	jmp	.LBB8_407
.LBB8_411:
	movq	$-1, %rdi
	movq	%rbx, %rcx
	subq	%rbp, %rcx
	jbe	.LBB8_412
.LBB8_414:
	leaq	(%r14,%rbp), %rdi
	addq	%r14, %rbx
	movabsq	$20895015895552, %rax   # imm = 0x130100000200
.LBB8_415:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %edx
	cmpq	$44, %rdx
	ja	.LBB8_417
# %bb.416:                              #   in Loop: Header=BB8_415 Depth=1
	btq	%rdx, %rax
	jb	.LBB8_419
.LBB8_417:                              #   in Loop: Header=BB8_415 Depth=1
	addq	$1, %rdi
	addq	$-1, %rcx
	jne	.LBB8_415
# %bb.418:
	movq	%rbx, %rdi
.LBB8_419:
	movq	%rdi, %rax
	subq	%r14, %rax
	cmpq	%rbx, %rdi
	movq	$-1, %rdi
	cmovneq	%rax, %rdi
	cmpb	$-1, %sil
	je	.LBB8_407
.LBB8_420:
	cmpb	$59, (%r14,%rbp)
	je	.LBB8_407
# %bb.421:
	cmpq	$-1, %rdi
	je	.LBB8_423
# %bb.422:
	movl	%edi, %r8d
	movl	%edi, %r9d
.LBB8_423:
	testb	$1, %r11b
	je	.LBB8_425
# %bb.424:
	movl	%r8d, %r9d
.LBB8_425:
	subb	%sil, %r9b
	movl	%r9d, %eax
	andb	$-2, %al
	cmpb	$2, %al
	jne	.LBB8_407
# %bb.426:
	movzbl	%sil, %ecx
	cmpb	$99, (%r14,%rcx)
	jne	.LBB8_407
# %bb.427:
	movsbl	1(%r14,%rcx), %eax
	cmpb	$2, %r9b
	jne	.LBB8_435
# %bb.428:
	movl	%eax, %ebx
	addb	$-48, %bl
	cmpb	$-1, %bl
	movq	8(%rsp), %rdx           # 8-byte Reload
	je	.LBB8_407
# %bb.429:
	addl	$-48, %eax
	cmpl	$9, %eax
	jbe	.LBB8_500
	jmp	.LBB8_407
.LBB8_431:
	leal	(%rax,%rax,4), %ecx
	movsbl	2(%r13,%rdi), %edx
	leal	(%rdx,%rcx,2), %ebp
	addl	$-528, %ebp             # imm = 0xFDF0
	cmpl	$31, %ebp
	ja	.LBB8_437
# %bb.432:
	leal	(%rdx,%rcx,2), %r14d
	addb	$-16, %r14b
	testb	$1, %r11b
	cmoveq	%r8, %r9
	cmpq	%rdi, %r9
	je	.LBB8_407
	jmp	.LBB8_442
.LBB8_433:
	leal	(%rax,%rax,4), %ecx
	movsbl	2(%r13,%rbp), %edx
	leal	(%rdx,%rcx,2), %esi
	addl	$-528, %esi             # imm = 0xFDF0
	cmpl	$31, %esi
	ja	.LBB8_447
# %bb.434:
	leal	(%rdx,%rcx,2), %eax
	addb	$-16, %al
	movl	%eax, (%rsp)            # 4-byte Spill
	jmp	.LBB8_451
.LBB8_435:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%r14,%rcx), %ecx
	leal	(%rcx,%rdx,2), %edi
	addl	$-528, %edi             # imm = 0xFDF0
	cmpl	$31, %edi
	ja	.LBB8_458
# %bb.436:
	leal	(%rcx,%rdx,2), %ebx
	addb	$-16, %bl
	xorl	%ebp, %ebp
	movq	8(%rsp), %rdx           # 8-byte Reload
	jmp	.LBB8_406
.LBB8_437:
	cmpb	$115, %al
	jne	.LBB8_439
# %bb.438:
	movb	$18, %r14b
	cmpb	$112, %dl
	je	.LBB8_441
.LBB8_439:
	cmpb	$108, %al
	jne	.LBB8_407
# %bb.440:
	movb	$19, %r14b
	cmpb	$114, %dl
	jne	.LBB8_407
.LBB8_441:
	testb	$1, %r11b
	cmoveq	%r8, %r9
	cmpq	%rdi, %r9
	je	.LBB8_407
.LBB8_442:
	movzbl	%bl, %eax
	movq	$-1, %r11
	subq	%rax, %r9
	jbe	.LBB8_462
# %bb.443:
	movabsq	$20895015895552, %rdx   # imm = 0x130100000200
	addq	%r13, %rax
.LBB8_444:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %ecx
	movl	$1, %edi
	shlq	%cl, %rdi
	cmpb	$63, %cl
	ja	.LBB8_461
# %bb.445:                              #   in Loop: Header=BB8_444 Depth=1
	andq	%rdx, %rdi
	je	.LBB8_461
# %bb.446:                              #   in Loop: Header=BB8_444 Depth=1
	addq	$1, %rax
	addq	$-1, %r9
	jne	.LBB8_444
	jmp	.LBB8_462
.LBB8_447:
	cmpb	$115, %al
	jne	.LBB8_449
# %bb.448:
	movb	$18, %cl
	movl	%ecx, (%rsp)            # 4-byte Spill
	cmpb	$112, %dl
	je	.LBB8_451
.LBB8_449:
	cmpb	$108, %al
	jne	.LBB8_407
# %bb.450:
	movb	$19, %al
	movl	%eax, (%rsp)            # 4-byte Spill
	cmpb	$114, %dl
	jne	.LBB8_407
.LBB8_451:
	testb	$1, %r11b
	cmoveq	%r8, %r9
	movq	$-1, %r10
	cmpq	%rbp, %r9
	je	.LBB8_499
# %bb.452:
	movzbl	%bl, %ecx
	movq	$-1, %rbx
	movq	$-1, %rbp
	subq	%rcx, %r9
	jbe	.LBB8_484
# %bb.453:
	movabsq	$20895015895552, %rax   # imm = 0x130100000200
	addq	%r13, %rcx
	movq	%rcx, %rbp
.LBB8_454:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rbp), %ecx
	movl	$1, %edx
	shlq	%cl, %rdx
	cmpb	$63, %cl
	ja	.LBB8_483
# %bb.455:                              #   in Loop: Header=BB8_454 Depth=1
	andq	%rax, %rdx
	je	.LBB8_483
# %bb.456:                              #   in Loop: Header=BB8_454 Depth=1
	addq	$1, %rbp
	addq	$-1, %r9
	jne	.LBB8_454
# %bb.457:
	movq	$-1, %rbp
	jmp	.LBB8_484
.LBB8_458:
	cmpb	$115, %al
	jne	.LBB8_501
# %bb.459:
	cmpb	$112, %cl
	jne	.LBB8_501
# %bb.460:
	xorl	%ebp, %ebp
	movb	$18, %bl
	movq	8(%rsp), %rdx           # 8-byte Reload
	jmp	.LBB8_406
.LBB8_461:
	subq	%r13, %rax
	movq	%rax, %r11
.LBB8_462:
	movb	%r11b, (%r10)
	movzbl	%r11b, %ebp
	movb	(%r15), %r10b
	movl	%r10d, %eax
	shrb	%al
	movq	8(%r15), %r8
	movzbl	%al, %r9d
	movq	%r9, %rbx
	testb	$1, %r10b
	je	.LBB8_463
# %bb.465:
	movq	16(%r15), %rsi
	movq	%r8, %rbx
	movq	$-1, %rdx
	movq	%rbx, %rax
	subq	%rbp, %rax
	ja	.LBB8_466
.LBB8_464:
	cmpb	$-1, %r11b
	jne	.LBB8_472
	jmp	.LBB8_407
.LBB8_463:
	movq	$-1, %rdx
	movq	%rbx, %rax
	subq	%rbp, %rax
	jbe	.LBB8_464
.LBB8_466:
	leaq	(%rsi,%rbp), %rdx
	addq	%rsi, %rbx
	movabsq	$20895015895552, %rdi   # imm = 0x130100000200
.LBB8_467:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rdx), %ecx
	cmpq	$44, %rcx
	ja	.LBB8_469
# %bb.468:                              #   in Loop: Header=BB8_467 Depth=1
	btq	%rcx, %rdi
	jb	.LBB8_471
.LBB8_469:                              #   in Loop: Header=BB8_467 Depth=1
	addq	$1, %rdx
	addq	$-1, %rax
	jne	.LBB8_467
# %bb.470:
	movq	%rbx, %rdx
.LBB8_471:
	movq	%rdx, %rax
	subq	%rsi, %rax
	cmpq	%rbx, %rdx
	movq	$-1, %rdx
	cmovneq	%rax, %rdx
	cmpb	$-1, %r11b
	je	.LBB8_407
.LBB8_472:
	cmpb	$59, (%rsi,%rbp)
	je	.LBB8_407
# %bb.473:
	cmpq	$-1, %rdx
	je	.LBB8_475
# %bb.474:
	movl	%edx, %r8d
	movl	%edx, %r9d
.LBB8_475:
	testb	$1, %r10b
	je	.LBB8_477
# %bb.476:
	movl	%r8d, %r9d
.LBB8_477:
	subb	%r11b, %r9b
	movl	%r9d, %eax
	andb	$-2, %al
	cmpb	$2, %al
	jne	.LBB8_407
# %bb.478:
	movzbl	%r11b, %ecx
	cmpb	$99, (%rsi,%rcx)
	jne	.LBB8_407
# %bb.479:
	movsbl	1(%rsi,%rcx), %eax
	cmpb	$2, %r9b
	jne	.LBB8_504
# %bb.480:
	movl	%eax, %ebp
	addb	$-48, %bpl
	cmpb	$-1, %bpl
	je	.LBB8_407
# %bb.481:
	addl	$-48, %eax
	cmpl	$9, %eax
	movl	%r14d, %ebx
	movq	8(%rsp), %rdx           # 8-byte Reload
	ja	.LBB8_407
# %bb.482:
	xorl	%r10d, %r10d
	jmp	.LBB8_406
.LBB8_483:
	subq	%r13, %rbp
.LBB8_484:
	movb	%bpl, (%r14)
	movzbl	%bpl, %r11d
	movb	(%r15), %r13b
	movl	%r13d, %eax
	shrb	%al
	testb	$1, %r13b
	movq	16(%r15), %r8
	movq	8(%r15), %r9
	movq	%r8, %rdx
	cmoveq	%rdi, %rdx
	movzbl	%al, %r14d
	movq	%r9, %rcx
	cmoveq	%r14, %rcx
	movq	%rcx, %rsi
	subq	%r11, %rsi
	jbe	.LBB8_491
# %bb.485:
	leaq	(%rdx,%r11), %rbx
	addq	%rdx, %rcx
	movabsq	$20895015895552, %r15   # imm = 0x130100000200
.LBB8_486:                              # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx), %eax
	cmpq	$44, %rax
	ja	.LBB8_488
# %bb.487:                              #   in Loop: Header=BB8_486 Depth=1
	btq	%rax, %r15
	jb	.LBB8_490
.LBB8_488:                              #   in Loop: Header=BB8_486 Depth=1
	addq	$1, %rbx
	addq	$-1, %rsi
	jne	.LBB8_486
# %bb.489:
	movq	%rcx, %rbx
.LBB8_490:
	movq	%rbx, %rax
	subq	%rdx, %rax
	cmpq	%rcx, %rbx
	movq	$-1, %rbx
	cmovneq	%rax, %rbx
.LBB8_491:
	movq	$-1, %r10
	cmpb	$-1, %bpl
	je	.LBB8_499
# %bb.492:
	cmpb	$59, (%rdx,%r11)
	je	.LBB8_499
# %bb.493:
	cmpq	$-1, %rbx
	je	.LBB8_495
# %bb.494:
	movl	%ebx, %r9d
	movl	%ebx, %r14d
.LBB8_495:
	testb	$1, %r13b
	je	.LBB8_497
# %bb.496:
	movl	%r9d, %r14d
.LBB8_497:
	subb	%bpl, %r14b
	movl	%r14d, %eax
	addb	$-1, %al
	cmpb	$10, %al
	ja	.LBB8_499
# %bb.498:
	testb	$1, %r13b
	cmoveq	%rdi, %r8
	movzbl	%bpl, %ebp
	addq	%r8, %rbp
	leaq	52(%rsp), %rbx
	movq	%rbx, 40(%rsp)
	callq	__errno_location@PLT
	movq	%rax, %r13
	movl	$0, (%r13)
	movzbl	%r14b, %r14d
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	movb	$0, 52(%rsp,%r14)
	leaq	40(%rsp), %rsi
	xorl	%edx, %edx
	movq	%rbx, %rdi
	callq	strtol@PLT
	cmpl	$1, (%r13)
	movl	%eax, %eax
	sbbq	%r10, %r10
	notq	%r10
	orq	%rax, %r10
.LBB8_499:
	movswl	%r10w, %eax
	cmpl	%r10d, %eax
	movl	(%rsp), %ebx            # 4-byte Reload
	movq	8(%rsp), %rdx           # 8-byte Reload
	jne	.LBB8_407
.LBB8_500:
	xorl	%ebp, %ebp
	jmp	.LBB8_406
.LBB8_501:
	cmpb	$108, %al
	jne	.LBB8_407
# %bb.502:
	cmpb	$114, %cl
	movq	8(%rsp), %rdx           # 8-byte Reload
	jne	.LBB8_407
# %bb.503:
	xorl	%ebp, %ebp
	movb	$19, %bl
	jmp	.LBB8_406
.LBB8_504:
	leal	(%rax,%rax,4), %edx
	movsbl	2(%rsi,%rcx), %ecx
	leal	(%rcx,%rdx,2), %esi
	addl	$-528, %esi             # imm = 0xFDF0
	cmpl	$31, %esi
	ja	.LBB8_506
# %bb.505:
	leal	(%rcx,%rdx,2), %ebp
	addb	$-16, %bpl
	xorl	%r10d, %r10d
	jmp	.LBB8_509
.LBB8_506:
	cmpb	$115, %al
	jne	.LBB8_510
# %bb.507:
	cmpb	$112, %cl
	jne	.LBB8_510
# %bb.508:
	xorl	%r10d, %r10d
	movb	$18, %bpl
.LBB8_509:
	movl	%r14d, %ebx
	movq	8(%rsp), %rdx           # 8-byte Reload
	jmp	.LBB8_406
.LBB8_510:
	cmpb	$108, %al
	jne	.LBB8_407
# %bb.511:
	cmpb	$114, %cl
	movl	%r14d, %ebx
	movq	8(%rsp), %rdx           # 8-byte Reload
	jne	.LBB8_407
# %bb.512:
	xorl	%r10d, %r10d
	movb	$19, %bpl
	jmp	.LBB8_406
.Lfunc_end8:
	.size	_Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo, .Lfunc_end8-_Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	2
.LJTI8_0:
	.long	.LBB8_3-.LJTI8_0
	.long	.LBB8_406-.LJTI8_0
	.long	.LBB8_41-.LJTI8_0
	.long	.LBB8_406-.LJTI8_0
	.long	.LBB8_51-.LJTI8_0
	.long	.LBB8_58-.LJTI8_0
	.long	.LBB8_63-.LJTI8_0
	.long	.LBB8_34-.LJTI8_0
	.long	.LBB8_46-.LJTI8_0
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function main
.LCPI9_0:
	.long	1593835520              # float 9.22337203E+18
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI9_1:
	.zero	16
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception0
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$520, %rsp              # imm = 0x208
	.cfi_def_cfa_offset 576
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rbx
	movq	%fs:40, %rax
	movq	%rax, 512(%rsp)
	cmpl	$1, %edi
	jle	.LBB9_1
# %bb.2:
	leaq	360(%rsp), %r12
	leaq	192(%rsp), %r15
	leaq	_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE+64(%rip), %rax
	movq	%rax, 360(%rsp)
	leaq	_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE+24(%rip), %rax
	movq	%rax, %xmm0
	movdqa	%xmm0, 176(%rsp)
.Ltmp0:
	movq	%r12, %rdi
	movq	%r15, %rsi
	callq	_ZNSt3__18ios_base4initEPv@PLT
.Ltmp1:
# %bb.3:
	movq	$0, 496(%rsp)
	movl	$-1, 504(%rsp)
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24(%rip), %rax
	movq	%rax, 176(%rsp)
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64(%rip), %rax
	movq	%rax, 360(%rsp)
.Ltmp3:
	movq	%r15, %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev
.Ltmp4:
# %bb.4:
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 96(%rsp)
	movdqa	%xmm0, 144(%rsp)
	movdqa	%xmm0, 128(%rsp)
	movb	$0, 95(%rsp)
	movq	$0, 112(%rsp)
	movl	$1065353216, 160(%rsp)  # imm = 0x3F800000
	cmpq	$0, 312(%rsp)
	je	.LBB9_5
.LBB9_9:
	movq	176(%rsp), %rax
	movq	-24(%rax), %rax
	leaq	(%rsp,%rax), %rdi
	addq	$176, %rdi
	movl	208(%rsp,%rax), %esi
	orl	$4, %esi
.Ltmp8:
	callq	_ZNSt3__18ios_base5clearEj@PLT
.Ltmp9:
.LBB9_10:
	movq	176(%rsp), %rax
	movq	-24(%rax), %rax
	testb	$5, 208(%rsp,%rax)
	jne	.LBB9_11
# %bb.25:
	movb	$0, 94(%rsp)
	leaq	32(%rsp), %rbp
	xorl	%r14d, %r14d
	jmp	.LBB9_26
	.p2align	4, 0x90
.LBB9_235:                              #   in Loop: Header=BB9_26 Depth=1
	movq	176(%rsp), %rax
	movq	-24(%rax), %rax
.LBB9_26:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB9_40 Depth 2
                                        #     Child Loop BB9_48 Depth 2
                                        #     Child Loop BB9_115 Depth 2
                                        #       Child Loop BB9_124 Depth 3
                                        #     Child Loop BB9_127 Depth 2
                                        #     Child Loop BB9_94 Depth 2
                                        #       Child Loop BB9_110 Depth 3
                                        #     Child Loop BB9_102 Depth 2
                                        #     Child Loop BB9_174 Depth 2
                                        #     Child Loop BB9_181 Depth 2
                                        #     Child Loop BB9_201 Depth 2
                                        #     Child Loop BB9_216 Depth 2
                                        #     Child Loop BB9_74 Depth 2
	leaq	(%rsp,%rax), %rsi
	addq	$176, %rsi
.Ltmp11:
	movq	%rbp, %rdi
	callq	_ZNKSt3__18ios_base6getlocEv@PLT
.Ltmp12:
# %bb.27:                               #   in Loop: Header=BB9_26 Depth=1
.Ltmp13:
	movq	%rbp, %rdi
	movq	_ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
.Ltmp14:
# %bb.28:                               #   in Loop: Header=BB9_26 Depth=1
	movq	(%rax), %rcx
.Ltmp15:
	movl	$10, %esi
	movq	%rax, %rdi
	callq	*56(%rcx)
	movl	%eax, %ebx
.Ltmp16:
# %bb.29:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%rbp, %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
.Ltmp18:
	movsbl	%bl, %edx
	leaq	176(%rsp), %rdi
	leaq	96(%rsp), %rsi
	callq	_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_
.Ltmp19:
# %bb.30:                               #   in Loop: Header=BB9_26 Depth=1
	movq	(%rax), %rcx
	movq	-24(%rcx), %rcx
	testb	$5, 32(%rax,%rcx)
	jne	.LBB9_31
# %bb.32:                               #   in Loop: Header=BB9_26 Depth=1
	addl	$1, %r14d
	movb	96(%rsp), %al
	movl	%eax, %ecx
	shrb	%cl
	testb	$1, %al
	movq	104(%rsp), %r10
	movzbl	%cl, %r11d
	movq	%r10, %rdx
	cmoveq	%r11, %rdx
	cmpq	$121, %rdx
	jae	.LBB9_33
# %bb.35:                               #   in Loop: Header=BB9_26 Depth=1
	movzbl	94(%rsp), %ecx
	cmpq	%rcx, %rdx
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	je	.LBB9_235
# %bb.36:                               #   in Loop: Header=BB9_26 Depth=1
	leaq	97(%rsp), %r13
	testb	$1, %al
	je	.LBB9_38
# %bb.37:                               #   in Loop: Header=BB9_26 Depth=1
	movq	112(%rsp), %r13
.LBB9_38:                               #   in Loop: Header=BB9_26 Depth=1
	movq	$-1, %r8
	movq	$-1, %rsi
	testq	%rdx, %rdx
	je	.LBB9_46
# %bb.39:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%rdx, %rdi
	movq	%r13, %rsi
	.p2align	4, 0x90
.LBB9_40:                               #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rsi), %ecx
	movl	$1, %ebp
	shlq	%cl, %rbp
	cmpb	$63, %cl
	ja	.LBB9_44
# %bb.41:                               #   in Loop: Header=BB9_40 Depth=2
	andq	%rbx, %rbp
	je	.LBB9_44
# %bb.42:                               #   in Loop: Header=BB9_40 Depth=2
	addq	$1, %rsi
	addq	$-1, %rdi
	jne	.LBB9_40
# %bb.43:                               #   in Loop: Header=BB9_26 Depth=1
	movq	$-1, %rsi
	jmp	.LBB9_45
.LBB9_44:                               #   in Loop: Header=BB9_26 Depth=1
	subq	%r13, %rsi
.LBB9_45:                               #   in Loop: Header=BB9_26 Depth=1
	leaq	32(%rsp), %rbp
.LBB9_46:                               #   in Loop: Header=BB9_26 Depth=1
	movb	%sil, 94(%rsp)
	movzbl	%sil, %r9d
	movq	%rdx, %rdi
	subq	%r9, %rdi
	jbe	.LBB9_51
# %bb.47:                               #   in Loop: Header=BB9_26 Depth=1
	leaq	(%r9,%r13), %rbp
	addq	%r13, %rdx
	.p2align	4, 0x90
.LBB9_48:                               #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rbp), %ecx
	cmpq	$44, %rcx
	ja	.LBB9_60
# %bb.49:                               #   in Loop: Header=BB9_48 Depth=2
	btq	%rcx, %rbx
	jb	.LBB9_50
.LBB9_60:                               #   in Loop: Header=BB9_48 Depth=2
	addq	$1, %rbp
	addq	$-1, %rdi
	jne	.LBB9_48
# %bb.61:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%rdx, %rbp
.LBB9_50:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%rbp, %r8
	subq	%r13, %r8
	cmpq	%rdx, %rbp
	movq	$-1, %rcx
	cmoveq	%rcx, %r8
	leaq	32(%rsp), %rbp
.LBB9_51:                               #   in Loop: Header=BB9_26 Depth=1
	cmpb	$-1, %sil
	je	.LBB9_235
# %bb.52:                               #   in Loop: Header=BB9_26 Depth=1
	cmpb	$59, (%r13,%r9)
	je	.LBB9_235
# %bb.53:                               #   in Loop: Header=BB9_26 Depth=1
	cmpq	$-1, %r8
	jne	.LBB9_54
# %bb.55:                               #   in Loop: Header=BB9_26 Depth=1
	testb	$1, %al
	jne	.LBB9_56
.LBB9_57:                               #   in Loop: Header=BB9_26 Depth=1
	subb	%sil, %r11b
	jne	.LBB9_58
	jmp	.LBB9_235
.LBB9_54:                               #   in Loop: Header=BB9_26 Depth=1
	movl	%r8d, %r10d
	movl	%r8d, %r11d
	testb	$1, %al
	je	.LBB9_57
.LBB9_56:                               #   in Loop: Header=BB9_26 Depth=1
	movl	%r10d, %r11d
	subb	%sil, %r11b
	je	.LBB9_235
.LBB9_58:                               #   in Loop: Header=BB9_26 Depth=1
	movzbl	%sil, %eax
	addq	%rax, %r13
	movzbl	%r11b, %ebp
	cmpb	$58, -1(%rbp,%r13)
	pxor	%xmm0, %xmm0
	movdqa	%xmm0, 64(%rsp)
	movq	$0, 80(%rsp)
	jne	.LBB9_59
# %bb.62:                               #   in Loop: Header=BB9_26 Depth=1
	movl	%r14d, (%rsp)           # 4-byte Spill
	movq	%r11, %r14
	movq	%r12, %rbx
	leaq	-1(%rbp), %r15
	cmpq	$23, %r15
	jae	.LBB9_63
# %bb.65:                               #   in Loop: Header=BB9_26 Depth=1
	movl	%r15d, %eax
	addb	%al, %al
	movb	%al, 64(%rsp)
	leaq	65(%rsp), %r12
	testq	%r15, %r15
	jne	.LBB9_66
	jmp	.LBB9_67
.LBB9_59:                               #   in Loop: Header=BB9_26 Depth=1
	xorl	%edx, %edx
	xorl	%eax, %eax
	leaq	32(%rsp), %rbx
	jmp	.LBB9_68
.LBB9_63:                               #   in Loop: Header=BB9_26 Depth=1
	addl	$15, %ebp
	andl	$496, %ebp              # imm = 0x1F0
.Ltmp21:
	movq	%rbp, %rdi
	callq	_Znwm@PLT
	movq	%rax, %r12
.Ltmp22:
# %bb.64:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%r12, 80(%rsp)
	orq	$1, %rbp
	movq	%rbp, 64(%rsp)
	movq	%r15, 72(%rsp)
.LBB9_66:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%r15, %rdx
	callq	memcpy@PLT
.LBB9_67:                               #   in Loop: Header=BB9_26 Depth=1
	movb	$0, (%r12,%r15)
	movb	64(%rsp), %al
	movq	72(%rsp), %rdx
	movq	%rbx, %r12
	leaq	192(%rsp), %r15
	leaq	32(%rsp), %rbx
	movq	%r14, %r11
	movl	(%rsp), %r14d           # 4-byte Reload
.LBB9_68:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%r11, 8(%rsp)           # 8-byte Spill
	movl	%eax, %ecx
	shrb	%cl
	testb	$1, %al
	movzbl	%cl, %ecx
	movq	%rcx, %rsi
	cmovneq	%rdx, %rsi
	testq	%rsi, %rsi
	je	.LBB9_69
# %bb.76:                               #   in Loop: Header=BB9_26 Depth=1
	testb	$1, %al
	cmovel	%ecx, %edx
	movq	80(%rsp), %rcx
	leaq	65(%rsp), %rax
	cmoveq	%rax, %rcx
	xorl	%eax, %eax
	leaq	.L.str.4(%rip), %rdi
	movl	%r14d, %esi
                                        # kill: def %edx killed %edx killed %rdx
	callq	printf@PLT
.Ltmp24:
	movq	%rbx, %rdi
	leaq	64(%rsp), %rsi
	callq	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS5_@PLT
.Ltmp25:
# %bb.77:                               #   in Loop: Header=BB9_26 Depth=1
	movq	$0, 56(%rsp)
	movb	32(%rsp), %al
	testb	$1, %al
	je	.LBB9_78
# %bb.79:                               #   in Loop: Header=BB9_26 Depth=1
	movq	48(%rsp), %rsi
	movq	40(%rsp), %rdx
	jmp	.LBB9_80
.LBB9_69:                               #   in Loop: Header=BB9_26 Depth=1
	movb	94(%rsp), %sil
	movb	96(%rsp), %bl
	movq	112(%rsp), %r13
	andb	$1, %bl
.LBB9_70:                               #   in Loop: Header=BB9_26 Depth=1
	testb	%bl, %bl
	leaq	97(%rsp), %rax
	cmoveq	%rax, %r13
	movzbl	%sil, %ecx
	leaq	(%rcx,%r13), %rax
	cmpb	$46, (%r13,%rcx)
	jne	.LBB9_71
# %bb.200:                              #   in Loop: Header=BB9_26 Depth=1
	movl	%r14d, (%rsp)           # 4-byte Spill
	movq	%rax, 16(%rsp)          # 8-byte Spill
	leaq	1(%rax), %r12
	movzbl	8(%rsp), %eax           # 1-byte Folded Reload
	movq	%rax, 24(%rsp)          # 8-byte Spill
	leaq	-1(%rax), %r14
	movb	$10, %r13b
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB9_201:                              #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	%r15b, %eax
	movzbl	%r13b, %ebx
	addl	%eax, %ebx
	shrl	%ebx
	leaq	directives(%rip), %rax
	leaq	(%rax,%rbx,8), %rsi
	movq	%r12, %rdi
	movq	%r14, %rdx
	callq	strncmp@PLT
	testl	%eax, %eax
	je	.LBB9_207
# %bb.202:                              #   in Loop: Header=BB9_201 Depth=2
	testl	%eax, %eax
	jg	.LBB9_203
# %bb.204:                              #   in Loop: Header=BB9_201 Depth=2
	addb	$-1, %bl
	movl	%ebx, %r13d
	movq	8(%rsp), %rbp           # 8-byte Reload
	cmpb	%r13b, %r15b
	jb	.LBB9_201
	jmp	.LBB9_206
	.p2align	4, 0x90
.LBB9_203:                              #   in Loop: Header=BB9_201 Depth=2
	addb	$1, %bl
	movl	%ebx, %r15d
	movq	8(%rsp), %rbp           # 8-byte Reload
	cmpb	%r13b, %r15b
	jb	.LBB9_201
.LBB9_206:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	360(%rsp), %r12
	movl	(%rsp), %r14d           # 4-byte Reload
	movq	16(%rsp), %rax          # 8-byte Reload
	movq	24(%rsp), %rcx          # 8-byte Reload
	jmp	.LBB9_72
.LBB9_78:                               #   in Loop: Header=BB9_26 Depth=1
	shrb	%al
	movzbl	%al, %edx
	leaq	33(%rsp), %rsi
.LBB9_80:                               #   in Loop: Header=BB9_26 Depth=1
.Ltmp27:
	leaq	120(%rsp), %rdi
	callq	_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm
	movq	%rax, %r13
.Ltmp28:
# %bb.81:                               #   in Loop: Header=BB9_26 Depth=1
	movq	136(%rsp), %r15
                                        # implicit-def: %rbx
	testq	%r15, %r15
	je	.LBB9_139
# %bb.82:                               #   in Loop: Header=BB9_26 Depth=1
	leaq	-1(%r15), %rdi
	testq	%r15, %rdi
	je	.LBB9_83
# %bb.84:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%r13, %rbx
	cmpq	%r15, %r13
	jb	.LBB9_86
# %bb.85:                               #   in Loop: Header=BB9_26 Depth=1
	xorl	%edx, %edx
	movq	%r13, %rax
	divq	%r15
	movq	%rdx, %rbx
.LBB9_86:                               #   in Loop: Header=BB9_26 Depth=1
	movq	128(%rsp), %rax
	movq	(%rax,%rbx,8), %rax
	testq	%rax, %rax
	je	.LBB9_139
.LBB9_87:                               #   in Loop: Header=BB9_26 Depth=1
	movq	(%rax), %rbp
	testq	%rbp, %rbp
	je	.LBB9_139
# %bb.88:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%rbx, (%rsp)            # 8-byte Spill
	movb	32(%rsp), %al
	movl	%eax, %r12d
	andb	$1, %r12b
	je	.LBB9_89
# %bb.90:                               #   in Loop: Header=BB9_26 Depth=1
	movq	40(%rsp), %r8
	movq	48(%rsp), %rbx
	testq	%r15, %rdi
	jne	.LBB9_113
	jmp	.LBB9_92
.LBB9_71:                               #   in Loop: Header=BB9_26 Depth=1
	movq	8(%rsp), %rbp           # 8-byte Reload
	movzbl	%bpl, %ecx
	jmp	.LBB9_72
.LBB9_83:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%rdi, %rbx
	andq	%r13, %rbx
	movq	128(%rsp), %rax
	movq	(%rax,%rbx,8), %rax
	testq	%rax, %rax
	jne	.LBB9_87
	jmp	.LBB9_139
.LBB9_207:                              #   in Loop: Header=BB9_26 Depth=1
	cmpl	$255, %ebx
	leaq	360(%rsp), %r12
	movq	8(%rsp), %rbp           # 8-byte Reload
	movl	(%rsp), %r14d           # 4-byte Reload
	movq	16(%rsp), %rax          # 8-byte Reload
	movq	24(%rsp), %rcx          # 8-byte Reload
	jne	.LBB9_208
.LBB9_72:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%rax, %r15
	movb	$0, (%rax,%rcx)
	movq	$-1, %rax
	cmpb	$5, %bpl
	ja	.LBB9_226
# %bb.73:                               #   in Loop: Header=BB9_26 Depth=1
	movb	$42, %r12b
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB9_74:                               #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	%r13b, %eax
	movzbl	%r12b, %ebp
	addl	%eax, %ebp
	shrl	%ebp
	leaq	instr(%rip), %rax
	leaq	(%rax,%rbp,8), %rbx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB9_75
# %bb.221:                              #   in Loop: Header=BB9_74 Depth=2
	testl	%eax, %eax
	jg	.LBB9_222
# %bb.223:                              #   in Loop: Header=BB9_74 Depth=2
	addb	$-1, %bpl
	movl	%ebp, %r12d
	movq	8(%rsp), %rbp           # 8-byte Reload
	cmpb	%r12b, %r13b
	jbe	.LBB9_74
	jmp	.LBB9_225
	.p2align	4, 0x90
.LBB9_222:                              #   in Loop: Header=BB9_74 Depth=2
	addb	$1, %bpl
	movl	%ebp, %r13d
	movq	8(%rsp), %rbp           # 8-byte Reload
	cmpb	%r12b, %r13b
	jbe	.LBB9_74
.LBB9_225:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	360(%rsp), %r12
	movq	$-1, %rax
	jmp	.LBB9_226
.LBB9_75:                               #   in Loop: Header=BB9_26 Depth=1
	movq	(%rbx), %rax
	leaq	360(%rsp), %r12
	movq	8(%rsp), %rbp           # 8-byte Reload
.LBB9_226:                              #   in Loop: Header=BB9_26 Depth=1
	movq	%rax, 32(%rsp)
	shrq	$40, %rax
	cmpb	$-1, %al
	leaq	32(%rsp), %rdx
	je	.LBB9_231
# %bb.227:                              #   in Loop: Header=BB9_26 Depth=1
	movzbl	%al, %ecx
	xorl	%eax, %eax
	leaq	.L.str.6(%rip), %rdi
	movl	%r14d, %esi
	callq	printf@PLT
	addb	94(%rsp), %bpl
	addb	$1, %bpl
	movb	%bpl, 94(%rsp)
	movq	32(%rsp), %rcx
	leaq	96(%rsp), %rdi
	leaq	94(%rsp), %rsi
	leaq	95(%rsp), %rdx
	callq	_Z16parseInstructionRNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEERhRb15InstructionInfo
	movl	%eax, %ecx
	cmpb	$42, 38(%rsp)
	je	.LBB9_229
# %bb.228:                              #   in Loop: Header=BB9_26 Depth=1
	movb	$0, 95(%rsp)
.LBB9_229:                              #   in Loop: Header=BB9_26 Depth=1
	cmpl	$-1, %ecx
	je	.LBB9_251
# %bb.230:                              #   in Loop: Header=BB9_26 Depth=1
	xorl	%eax, %eax
	leaq	.L.str.8(%rip), %rdi
	movl	%ecx, %esi
	callq	printf@PLT
.LBB9_231:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	192(%rsp), %r15
	testb	$1, 64(%rsp)
	jne	.LBB9_233
	jmp	.LBB9_234
.LBB9_89:                               #   in Loop: Header=BB9_26 Depth=1
	shrb	%al
	movzbl	%al, %r8d
	leaq	33(%rsp), %rbx
	testq	%r15, %rdi
	je	.LBB9_92
.LBB9_113:                              #   in Loop: Header=BB9_26 Depth=1
	testq	%r8, %r8
	je	.LBB9_126
# %bb.114:                              #   in Loop: Header=BB9_26 Depth=1
	movq	%r13, 16(%rsp)          # 8-byte Spill
.LBB9_115:                              #   Parent Loop BB9_26 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB9_124 Depth 3
	movq	8(%rbp), %rax
	cmpq	%r13, %rax
	je	.LBB9_119
# %bb.116:                              #   in Loop: Header=BB9_115 Depth=2
	cmpq	%r15, %rax
	jb	.LBB9_118
# %bb.117:                              #   in Loop: Header=BB9_115 Depth=2
	xorl	%edx, %edx
	divq	%r15
	movq	%rdx, %rax
.LBB9_118:                              #   in Loop: Header=BB9_115 Depth=2
	cmpq	(%rsp), %rax            # 8-byte Folded Reload
	jne	.LBB9_138
.LBB9_119:                              #   in Loop: Header=BB9_115 Depth=2
	movb	16(%rbp), %cl
	movl	%ecx, %eax
	shrb	%al
	movzbl	%al, %eax
	movq	%rax, %rdx
	testb	$1, %cl
	je	.LBB9_121
# %bb.120:                              #   in Loop: Header=BB9_115 Depth=2
	movq	24(%rbp), %rdx
.LBB9_121:                              #   in Loop: Header=BB9_115 Depth=2
	cmpq	%r8, %rdx
	jne	.LBB9_137
# %bb.122:                              #   in Loop: Header=BB9_115 Depth=2
	testb	$1, %cl
	jne	.LBB9_136
# %bb.123:                              #   in Loop: Header=BB9_115 Depth=2
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB9_124:                              #   Parent Loop BB9_26 Depth=1
                                        #     Parent Loop BB9_115 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzbl	17(%rbp,%rcx), %edx
	cmpb	(%rbx,%rcx), %dl
	jne	.LBB9_137
# %bb.125:                              #   in Loop: Header=BB9_124 Depth=3
	addq	$1, %rcx
	cmpq	%rcx, %rax
	jne	.LBB9_124
	jmp	.LBB9_169
.LBB9_136:                              #   in Loop: Header=BB9_115 Depth=2
	movq	32(%rbp), %rdi
	movq	%rbx, %rsi
	movq	%r8, %rdx
	movq	%r8, %r13
	callq	memcmp@PLT
	movq	%r13, %r8
	movq	16(%rsp), %r13          # 8-byte Reload
	testl	%eax, %eax
	je	.LBB9_169
.LBB9_137:                              #   in Loop: Header=BB9_115 Depth=2
	movq	(%rbp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_115
	jmp	.LBB9_138
.LBB9_208:                              #   in Loop: Header=BB9_26 Depth=1
	xorl	%eax, %eax
	leaq	.L.str.5(%rip), %rdi
	movl	%r14d, %esi
	movl	%ebx, %edx
	callq	printf@PLT
	movzbl	94(%rsp), %edx
	movb	96(%rsp), %cl
	testb	$1, %cl
	je	.LBB9_209
# %bb.210:                              #   in Loop: Header=BB9_26 Depth=1
	movq	104(%rsp), %rax
	leaq	192(%rsp), %r15
	cmpq	%rdx, %rax
	jne	.LBB9_212
	jmp	.LBB9_232
.LBB9_92:                               #   in Loop: Header=BB9_26 Depth=1
	testq	%r8, %r8
	je	.LBB9_101
# %bb.93:                               #   in Loop: Header=BB9_26 Depth=1
	movq	%r13, 16(%rsp)          # 8-byte Spill
	movq	%rdi, 24(%rsp)          # 8-byte Spill
.LBB9_94:                               #   Parent Loop BB9_26 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB9_110 Depth 3
	movq	8(%rbp), %rax
	cmpq	%r13, %rax
	je	.LBB9_96
# %bb.95:                               #   in Loop: Header=BB9_94 Depth=2
	andq	%rdi, %rax
	cmpq	(%rsp), %rax            # 8-byte Folded Reload
	jne	.LBB9_138
.LBB9_96:                               #   in Loop: Header=BB9_94 Depth=2
	movb	16(%rbp), %cl
	movl	%ecx, %eax
	shrb	%al
	movzbl	%al, %eax
	movq	%rax, %rdx
	testb	$1, %cl
	je	.LBB9_98
# %bb.97:                               #   in Loop: Header=BB9_94 Depth=2
	movq	24(%rbp), %rdx
.LBB9_98:                               #   in Loop: Header=BB9_94 Depth=2
	cmpq	%r8, %rdx
	jne	.LBB9_111
# %bb.99:                               #   in Loop: Header=BB9_94 Depth=2
	testb	$1, %cl
	jne	.LBB9_100
# %bb.109:                              #   in Loop: Header=BB9_94 Depth=2
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB9_110:                              #   Parent Loop BB9_26 Depth=1
                                        #     Parent Loop BB9_94 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzbl	17(%rbp,%rcx), %edx
	cmpb	(%rbx,%rcx), %dl
	jne	.LBB9_111
# %bb.112:                              #   in Loop: Header=BB9_110 Depth=3
	addq	$1, %rcx
	cmpq	%rcx, %rax
	jne	.LBB9_110
	jmp	.LBB9_169
.LBB9_100:                              #   in Loop: Header=BB9_94 Depth=2
	movq	32(%rbp), %rdi
	movq	%rbx, %rsi
	movq	%r8, %rdx
	movq	%r8, %r13
	callq	memcmp@PLT
	movq	24(%rsp), %rdi          # 8-byte Reload
	movq	%r13, %r8
	movq	16(%rsp), %r13          # 8-byte Reload
	testl	%eax, %eax
	je	.LBB9_169
.LBB9_111:                              #   in Loop: Header=BB9_94 Depth=2
	movq	(%rbp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_94
.LBB9_138:                              #   in Loop: Header=BB9_26 Depth=1
	movq	(%rsp), %rbx            # 8-byte Reload
	jmp	.LBB9_139
.LBB9_126:                              #   in Loop: Header=BB9_26 Depth=1
	movq	(%rsp), %rbx            # 8-byte Reload
.LBB9_127:                              #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	8(%rbp), %rax
	cmpq	%r13, %rax
	je	.LBB9_131
# %bb.128:                              #   in Loop: Header=BB9_127 Depth=2
	cmpq	%r15, %rax
	jb	.LBB9_130
# %bb.129:                              #   in Loop: Header=BB9_127 Depth=2
	xorl	%edx, %edx
	divq	%r15
	movq	%rdx, %rax
.LBB9_130:                              #   in Loop: Header=BB9_127 Depth=2
	cmpq	%rbx, %rax
	jne	.LBB9_139
.LBB9_131:                              #   in Loop: Header=BB9_127 Depth=2
	movzbl	16(%rbp), %eax
	testb	$1, %al
	je	.LBB9_132
# %bb.133:                              #   in Loop: Header=BB9_127 Depth=2
	movq	24(%rbp), %rax
	testq	%rax, %rax
	jne	.LBB9_135
	jmp	.LBB9_169
.LBB9_132:                              #   in Loop: Header=BB9_127 Depth=2
	shrb	%al
	movzbl	%al, %eax
	testq	%rax, %rax
	je	.LBB9_169
.LBB9_135:                              #   in Loop: Header=BB9_127 Depth=2
	movq	(%rbp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_127
	jmp	.LBB9_139
.LBB9_209:                              #   in Loop: Header=BB9_26 Depth=1
	movl	%ecx, %eax
	shrb	%al
	movzbl	%al, %eax
	leaq	192(%rsp), %r15
	cmpq	%rdx, %rax
	je	.LBB9_232
.LBB9_212:                              #   in Loop: Header=BB9_26 Depth=1
	addb	8(%rsp), %dl            # 1-byte Folded Reload
	movzbl	%dl, %edx
	leaq	97(%rsp), %rdi
	testb	$1, %cl
	je	.LBB9_214
# %bb.213:                              #   in Loop: Header=BB9_26 Depth=1
	movq	112(%rsp), %rdi
.LBB9_214:                              #   in Loop: Header=BB9_26 Depth=1
	movq	$-1, %rsi
	subq	%rdx, %rax
	movabsq	$20895015895552, %rbx   # imm = 0x130100000200
	jbe	.LBB9_220
# %bb.215:                              #   in Loop: Header=BB9_26 Depth=1
	addq	%rdi, %rdx
.LBB9_216:                              #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rdx), %ecx
	movl	$1, %ebp
	shlq	%cl, %rbp
	cmpb	$63, %cl
	ja	.LBB9_219
# %bb.217:                              #   in Loop: Header=BB9_216 Depth=2
	andq	%rbx, %rbp
	je	.LBB9_219
# %bb.218:                              #   in Loop: Header=BB9_216 Depth=2
	addq	$1, %rdx
	addq	$-1, %rax
	jne	.LBB9_216
	jmp	.LBB9_220
.LBB9_101:                              #   in Loop: Header=BB9_26 Depth=1
	movq	(%rsp), %rbx            # 8-byte Reload
.LBB9_102:                              #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	8(%rbp), %rax
	cmpq	%r13, %rax
	je	.LBB9_104
# %bb.103:                              #   in Loop: Header=BB9_102 Depth=2
	andq	%rdi, %rax
	cmpq	%rbx, %rax
	jne	.LBB9_139
.LBB9_104:                              #   in Loop: Header=BB9_102 Depth=2
	movzbl	16(%rbp), %eax
	testb	$1, %al
	je	.LBB9_105
# %bb.106:                              #   in Loop: Header=BB9_102 Depth=2
	movq	24(%rbp), %rax
	testq	%rax, %rax
	jne	.LBB9_108
	jmp	.LBB9_169
.LBB9_105:                              #   in Loop: Header=BB9_102 Depth=2
	shrb	%al
	movzbl	%al, %eax
	testq	%rax, %rax
	je	.LBB9_169
.LBB9_108:                              #   in Loop: Header=BB9_102 Depth=2
	movq	(%rbp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_102
.LBB9_139:                              #   in Loop: Header=BB9_26 Depth=1
.Ltmp30:
	movl	$48, %edi
	callq	_Znwm@PLT
	movq	%rax, %r12
.Ltmp31:
# %bb.140:                              #   in Loop: Header=BB9_26 Depth=1
	movq	%r12, %rbp
	movq	48(%rsp), %rax
	movq	%rax, 32(%rbp)
	movaps	32(%rsp), %xmm0
	movups	%xmm0, 16(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 32(%rsp)
	movq	$0, 48(%rsp)
	movzwl	56(%rsp), %eax
	movw	%ax, 40(%rbp)
	movq	%r13, %rax
	movq	%rax, 8(%rbp)
	movq	$0, (%rbp)
	movq	152(%rsp), %rax
	addq	$1, %rax
	js	.LBB9_141
# %bb.142:                              #   in Loop: Header=BB9_26 Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.LBB9_143
.LBB9_141:                              #   in Loop: Header=BB9_26 Depth=1
	movq	%rax, %rcx
	shrq	%rcx
	andl	$1, %eax
	orq	%rcx, %rax
	xorps	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	addss	%xmm0, %xmm0
.LBB9_143:                              #   in Loop: Header=BB9_26 Depth=1
	addq	$16, %r12
	movq	%r15, %rcx
	shrq	%rcx
	movl	%r15d, %eax
	andl	$1, %eax
	orq	%rcx, %rax
	testq	%r15, %r15
	js	.LBB9_144
# %bb.145:                              #   in Loop: Header=BB9_26 Depth=1
	cvtsi2ssq	%r15, %xmm2
	movss	160(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	je	.LBB9_148
.LBB9_147:                              #   in Loop: Header=BB9_26 Depth=1
	mulss	%xmm1, %xmm2
	ucomiss	%xmm2, %xmm0
	jbe	.LBB9_156
	jmp	.LBB9_148
.LBB9_144:                              #   in Loop: Header=BB9_26 Depth=1
	cvtsi2ssq	%rax, %xmm2
	addss	%xmm2, %xmm2
	movss	160(%rsp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	jne	.LBB9_147
.LBB9_148:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	(%r15,%r15), %rax
	cmpq	$3, %r15
	jb	.LBB9_149
# %bb.150:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	-1(%r15), %rcx
	xorl	%ebx, %ebx
	testq	%r15, %rcx
	setne	%bl
	jmp	.LBB9_151
.LBB9_149:                              #   in Loop: Header=BB9_26 Depth=1
	movl	$1, %ebx
.LBB9_151:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	192(%rsp), %r15
	orq	%rax, %rbx
	divss	%xmm1, %xmm0
	callq	ceilf@PLT
	movaps	%xmm0, %xmm1
	movss	.LCPI9_0(%rip), %xmm2   # xmm2 = mem[0],zero,zero,zero
	subss	%xmm2, %xmm1
	cvttss2si	%xmm1, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rcx, %rax
	cvttss2si	%xmm0, %rsi
	ucomiss	%xmm2, %xmm0
	cmovaeq	%rax, %rsi
	cmpq	%rsi, %rbx
	cmovaeq	%rbx, %rsi
.Ltmp33:
	leaq	128(%rsp), %rdi
	callq	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm
.Ltmp34:
# %bb.152:                              #   in Loop: Header=BB9_26 Depth=1
	movq	136(%rsp), %r15
	leaq	-1(%r15), %rax
	movq	%r13, %rbx
	testq	%r15, %rax
	je	.LBB9_153
# %bb.154:                              #   in Loop: Header=BB9_26 Depth=1
	cmpq	%r15, %rbx
	jb	.LBB9_156
# %bb.155:                              #   in Loop: Header=BB9_26 Depth=1
	xorl	%edx, %edx
	movq	%rbx, %rax
	divq	%r15
	movq	%rdx, %rbx
	movq	128(%rsp), %rcx
	movq	(%rcx,%rbx,8), %rax
	testq	%rax, %rax
	jne	.LBB9_166
	jmp	.LBB9_157
.LBB9_153:                              #   in Loop: Header=BB9_26 Depth=1
	andq	%rax, %rbx
.LBB9_156:                              #   in Loop: Header=BB9_26 Depth=1
	movq	128(%rsp), %rcx
	movq	(%rcx,%rbx,8), %rax
	testq	%rax, %rax
	je	.LBB9_157
.LBB9_166:                              #   in Loop: Header=BB9_26 Depth=1
	movq	(%rax), %rcx
	movq	%rcx, (%rbp)
	jmp	.LBB9_167
.LBB9_157:                              #   in Loop: Header=BB9_26 Depth=1
	movq	144(%rsp), %rax
	movq	%rax, (%rbp)
	movq	%rbp, 144(%rsp)
	leaq	144(%rsp), %rax
	movq	%rax, (%rcx,%rbx,8)
	movq	(%rbp), %rax
	testq	%rax, %rax
	je	.LBB9_168
# %bb.158:                              #   in Loop: Header=BB9_26 Depth=1
	movq	8(%rax), %rax
	leaq	-1(%r15), %rcx
	testq	%r15, %rcx
	je	.LBB9_159
# %bb.163:                              #   in Loop: Header=BB9_26 Depth=1
	cmpq	%r15, %rax
	jb	.LBB9_165
# %bb.164:                              #   in Loop: Header=BB9_26 Depth=1
	xorl	%edx, %edx
	divq	%r15
	movq	%rdx, %rax
	jmp	.LBB9_165
.LBB9_159:                              #   in Loop: Header=BB9_26 Depth=1
	andq	%rcx, %rax
.LBB9_165:                              #   in Loop: Header=BB9_26 Depth=1
	shlq	$3, %rax
	addq	128(%rsp), %rax
.LBB9_167:                              #   in Loop: Header=BB9_26 Depth=1
	movq	%rbp, (%rax)
.LBB9_168:                              #   in Loop: Header=BB9_26 Depth=1
	addq	$1, 152(%rsp)
	movb	32(%rsp), %r12b
	andb	$1, %r12b
.LBB9_169:                              #   in Loop: Header=BB9_26 Depth=1
	testb	%r12b, %r12b
	leaq	192(%rsp), %r15
	je	.LBB9_171
# %bb.170:                              #   in Loop: Header=BB9_26 Depth=1
	movq	48(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB9_171:                              #   in Loop: Header=BB9_26 Depth=1
	movzbl	94(%rsp), %ecx
	movb	96(%rsp), %bl
	movl	%ebx, %eax
	shrb	%al
	andb	$1, %bl
	movq	104(%rsp), %r8
	movzbl	%al, %r9d
	movq	%r8, %rbp
	cmoveq	%r9, %rbp
	cmpq	%rcx, %rbp
	leaq	360(%rsp), %r12
	je	.LBB9_232
# %bb.172:                              #   in Loop: Header=BB9_26 Depth=1
	addb	8(%rsp), %cl            # 1-byte Folded Reload
	testb	%bl, %bl
	movq	112(%rsp), %r13
	movq	%r13, %r10
	leaq	97(%rsp), %rax
	cmoveq	%rax, %r10
	movzbl	%cl, %ecx
	movq	%rbp, %rdx
	movq	$-1, %rsi
	subq	%rcx, %rdx
	jbe	.LBB9_179
# %bb.173:                              #   in Loop: Header=BB9_26 Depth=1
	addq	%r10, %rcx
	movq	%rcx, %rsi
	movabsq	$20895015895552, %rax   # imm = 0x130100000200
	.p2align	4, 0x90
.LBB9_174:                              #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rsi), %ecx
	movl	$1, %edi
	shlq	%cl, %rdi
	cmpb	$63, %cl
	ja	.LBB9_178
# %bb.175:                              #   in Loop: Header=BB9_174 Depth=2
	andq	%rax, %rdi
	je	.LBB9_178
# %bb.176:                              #   in Loop: Header=BB9_174 Depth=2
	addq	$1, %rsi
	addq	$-1, %rdx
	jne	.LBB9_174
# %bb.177:                              #   in Loop: Header=BB9_26 Depth=1
	movq	$-1, %rsi
	jmp	.LBB9_179
.LBB9_178:                              #   in Loop: Header=BB9_26 Depth=1
	subq	%r10, %rsi
.LBB9_179:                              #   in Loop: Header=BB9_26 Depth=1
	movq	$-1, %rcx
	movb	%sil, 94(%rsp)
	movzbl	%sil, %r11d
	movq	%rbp, %rdi
	subq	%r11, %rdi
	jbe	.LBB9_184
# %bb.180:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	(%r10,%r11), %rdx
	addq	%r10, %rbp
	.p2align	4, 0x90
.LBB9_181:                              #   Parent Loop BB9_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rdx), %ecx
	cmpq	$44, %rcx
	ja	.LBB9_188
# %bb.182:                              #   in Loop: Header=BB9_181 Depth=2
	movabsq	$20895015895552, %rax   # imm = 0x130100000200
	btq	%rcx, %rax
	jb	.LBB9_183
.LBB9_188:                              #   in Loop: Header=BB9_181 Depth=2
	addq	$1, %rdx
	addq	$-1, %rdi
	jne	.LBB9_181
# %bb.189:                              #   in Loop: Header=BB9_26 Depth=1
	movq	%rbp, %rdx
.LBB9_183:                              #   in Loop: Header=BB9_26 Depth=1
	movq	%rdx, %rcx
	subq	%r10, %rcx
	cmpq	%rbp, %rdx
	movq	$-1, %rax
	cmoveq	%rax, %rcx
.LBB9_184:                              #   in Loop: Header=BB9_26 Depth=1
	cmpb	$-1, %sil
	je	.LBB9_232
# %bb.185:                              #   in Loop: Header=BB9_26 Depth=1
	cmpb	$59, (%r10,%r11)
	je	.LBB9_232
# %bb.186:                              #   in Loop: Header=BB9_26 Depth=1
	cmpq	$-1, %rcx
	je	.LBB9_187
# %bb.190:                              #   in Loop: Header=BB9_26 Depth=1
	movl	%ecx, %r8d
	testb	%bl, %bl
	jne	.LBB9_192
	jmp	.LBB9_193
.LBB9_187:                              #   in Loop: Header=BB9_26 Depth=1
	movl	%r9d, %ecx
	testb	%bl, %bl
	je	.LBB9_193
.LBB9_192:                              #   in Loop: Header=BB9_26 Depth=1
	movl	%r8d, %ecx
.LBB9_193:                              #   in Loop: Header=BB9_26 Depth=1
	subb	%sil, %cl
	movq	%rcx, 8(%rsp)           # 8-byte Spill
	jne	.LBB9_70
	jmp	.LBB9_232
.LBB9_219:                              #   in Loop: Header=BB9_26 Depth=1
	subq	%rdi, %rdx
	movq	%rdx, %rsi
.LBB9_220:                              #   in Loop: Header=BB9_26 Depth=1
	movb	%sil, 94(%rsp)
.LBB9_232:                              #   in Loop: Header=BB9_26 Depth=1
	testb	$1, 64(%rsp)
	je	.LBB9_234
.LBB9_233:                              #   in Loop: Header=BB9_26 Depth=1
	movq	80(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB9_234:                              #   in Loop: Header=BB9_26 Depth=1
	leaq	32(%rsp), %rbp
	jmp	.LBB9_235
.LBB9_5:
	movq	8(%rbx), %rdi
	leaq	.L.str.12(%rip), %rsi
	callq	fopen@PLT
	movq	%rax, 312(%rsp)
	testq	%rax, %rax
	je	.LBB9_9
# %bb.6:
	movl	$8, 344(%rsp)
	movq	176(%rsp), %rax
	leaq	176(%rsp), %rdi
	addq	-24(%rax), %rdi
.Ltmp6:
	xorl	%esi, %esi
	callq	_ZNSt3__18ios_base5clearEj@PLT
.Ltmp7:
	jmp	.LBB9_10
.LBB9_33:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	.L.str.3(%rip), %rsi
	xorl	%eax, %eax
	movl	%r14d, %edx
	callq	fprintf@PLT
	movl	$1, %r14d
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_14
	jmp	.LBB9_17
.LBB9_31:
	xorl	%r14d, %r14d
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_14
	jmp	.LBB9_17
.LBB9_1:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	movq	(%rbx), %rdx
	leaq	.L.str.1(%rip), %rsi
	xorl	%eax, %eax
	callq	fprintf@PLT
	movl	$1, %r14d
	movq	%fs:40, %rax
	cmpq	512(%rsp), %rax
	je	.LBB9_23
	jmp	.LBB9_248
.LBB9_11:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	leaq	.L.str.2(%rip), %rdi
	movl	$37, %esi
	movl	$1, %edx
	callq	fwrite@PLT
	movl	$1, %r14d
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	je	.LBB9_17
	.p2align	4, 0x90
.LBB9_14:                               # =>This Inner Loop Header: Depth=1
	movq	(%rbp), %rbx
	testb	$1, 16(%rbp)
	je	.LBB9_16
# %bb.15:                               #   in Loop: Header=BB9_14 Depth=1
	movq	32(%rbp), %rdi
	callq	_ZdlPv@PLT
.LBB9_16:                               #   in Loop: Header=BB9_14 Depth=1
	movq	%rbp, %rdi
	callq	_ZdlPv@PLT
	movq	%rbx, %rbp
	testq	%rbx, %rbx
	jne	.LBB9_14
.LBB9_17:
	movq	128(%rsp), %rdi
	movq	$0, 128(%rsp)
	testq	%rdi, %rdi
	je	.LBB9_19
# %bb.18:
	callq	_ZdlPv@PLT
.LBB9_19:
	testb	$1, 96(%rsp)
	je	.LBB9_21
# %bb.20:
	movq	112(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB9_21:
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24(%rip), %rax
	movq	%rax, 176(%rsp)
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64(%rip), %rax
	movq	%rax, 360(%rsp)
	movq	%r15, %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	leaq	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+8(%rip), %rsi
	leaq	176(%rsp), %rdi
	callq	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r12, %rdi
	callq	_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%fs:40, %rax
	cmpq	512(%rsp), %rax
	jne	.LBB9_248
.LBB9_23:
	movl	%r14d, %eax
	addq	$520, %rsp              # imm = 0x208
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB9_251:
	movq	stderr@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	leaq	.L.str.7(%rip), %rsi
	leaq	32(%rsp), %rdx
	xorl	%eax, %eax
	movl	%r14d, %ecx
	callq	fprintf@PLT
	movl	$1, %edi
	callq	exit@PLT
.LBB9_248:
	callq	__stack_chk_fail@PLT
.LBB9_24:
.Ltmp10:
	movq	%rax, %r14
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_238
	jmp	.LBB9_241
.LBB9_8:
.Ltmp5:
	movq	%rax, %r14
	jmp	.LBB9_246
.LBB9_7:
.Ltmp2:
	movq	%rax, %r14
	movq	%r12, %rdi
	callq	_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_160:
.Ltmp35:
	movq	%rax, %r14
	testb	$1, (%r12)
	je	.LBB9_162
# %bb.161:
	movq	32(%rbp), %rdi
	callq	_ZdlPv@PLT
.LBB9_162:
	movq	%rbp, %rdi
	callq	_ZdlPv@PLT
	leaq	360(%rsp), %r12
	testb	$1, 32(%rsp)
	jne	.LBB9_197
	jmp	.LBB9_198
.LBB9_236:
.Ltmp23:
	movq	%rax, %r14
	movq	%rbx, %r12
	leaq	192(%rsp), %r15
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_238
	jmp	.LBB9_241
.LBB9_195:
.Ltmp32:
	movq	%rax, %r14
	leaq	360(%rsp), %r12
	leaq	192(%rsp), %r15
	testb	$1, 32(%rsp)
	je	.LBB9_198
.LBB9_197:
	movq	48(%rsp), %rdi
	callq	_ZdlPv@PLT
	testb	$1, 64(%rsp)
	je	.LBB9_237
	jmp	.LBB9_199
.LBB9_250:
.Ltmp29:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.LBB9_194:
.Ltmp26:
	movq	%rax, %r14
.LBB9_198:
	testb	$1, 64(%rsp)
	jne	.LBB9_199
.LBB9_237:
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	je	.LBB9_241
	.p2align	4, 0x90
.LBB9_238:                              # =>This Inner Loop Header: Depth=1
	movq	(%rbp), %rbx
	testb	$1, 16(%rbp)
	je	.LBB9_240
# %bb.239:                              #   in Loop: Header=BB9_238 Depth=1
	movq	32(%rbp), %rdi
	callq	_ZdlPv@PLT
.LBB9_240:                              #   in Loop: Header=BB9_238 Depth=1
	movq	%rbp, %rdi
	callq	_ZdlPv@PLT
	movq	%rbx, %rbp
	testq	%rbx, %rbx
	jne	.LBB9_238
.LBB9_241:
	movq	128(%rsp), %rdi
	movq	$0, 128(%rsp)
	testq	%rdi, %rdi
	je	.LBB9_243
# %bb.242:
	callq	_ZdlPv@PLT
.LBB9_243:
	testb	$1, 96(%rsp)
	je	.LBB9_245
# %bb.244:
	movq	112(%rsp), %rdi
	callq	_ZdlPv@PLT
.LBB9_245:
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24(%rip), %rax
	movq	%rax, 176(%rsp)
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64(%rip), %rax
	movq	%rax, 360(%rsp)
	movq	%r15, %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
.LBB9_246:
	leaq	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+8(%rip), %rsi
	leaq	176(%rsp), %rdi
	callq	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r12, %rdi
	callq	_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_199:
	movq	80(%rsp), %rdi
	callq	_ZdlPv@PLT
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_238
	jmp	.LBB9_241
.LBB9_249:
.Ltmp17:
	movq	%rax, %r14
	leaq	32(%rsp), %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_238
	jmp	.LBB9_241
.LBB9_34:
.Ltmp20:
	movq	%rax, %r14
	movq	144(%rsp), %rbp
	testq	%rbp, %rbp
	jne	.LBB9_238
	jmp	.LBB9_241
.Lfunc_end9:
	.size	main, .Lfunc_end9-main
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2
GCC_except_table9:
.Lexception0:
	.byte	255                     # @LPStart Encoding = omit
	.byte	155                     # @TType Encoding = indirect pcrel sdata4
	.ascii	"\314\001"              # @TType base offset
	.byte	3                       # Call site Encoding = udata4
	.ascii	"\303\001"              # Call site table length
	.long	.Ltmp0-.Lfunc_begin0    # >> Call Site 1 <<
	.long	.Ltmp1-.Ltmp0           #   Call between .Ltmp0 and .Ltmp1
	.long	.Ltmp2-.Lfunc_begin0    #     jumps to .Ltmp2
	.byte	0                       #   On action: cleanup
	.long	.Ltmp3-.Lfunc_begin0    # >> Call Site 2 <<
	.long	.Ltmp4-.Ltmp3           #   Call between .Ltmp3 and .Ltmp4
	.long	.Ltmp5-.Lfunc_begin0    #     jumps to .Ltmp5
	.byte	0                       #   On action: cleanup
	.long	.Ltmp8-.Lfunc_begin0    # >> Call Site 3 <<
	.long	.Ltmp9-.Ltmp8           #   Call between .Ltmp8 and .Ltmp9
	.long	.Ltmp10-.Lfunc_begin0   #     jumps to .Ltmp10
	.byte	0                       #   On action: cleanup
	.long	.Ltmp11-.Lfunc_begin0   # >> Call Site 4 <<
	.long	.Ltmp12-.Ltmp11         #   Call between .Ltmp11 and .Ltmp12
	.long	.Ltmp20-.Lfunc_begin0   #     jumps to .Ltmp20
	.byte	0                       #   On action: cleanup
	.long	.Ltmp13-.Lfunc_begin0   # >> Call Site 5 <<
	.long	.Ltmp16-.Ltmp13         #   Call between .Ltmp13 and .Ltmp16
	.long	.Ltmp17-.Lfunc_begin0   #     jumps to .Ltmp17
	.byte	0                       #   On action: cleanup
	.long	.Ltmp18-.Lfunc_begin0   # >> Call Site 6 <<
	.long	.Ltmp19-.Ltmp18         #   Call between .Ltmp18 and .Ltmp19
	.long	.Ltmp20-.Lfunc_begin0   #     jumps to .Ltmp20
	.byte	0                       #   On action: cleanup
	.long	.Ltmp21-.Lfunc_begin0   # >> Call Site 7 <<
	.long	.Ltmp22-.Ltmp21         #   Call between .Ltmp21 and .Ltmp22
	.long	.Ltmp23-.Lfunc_begin0   #     jumps to .Ltmp23
	.byte	0                       #   On action: cleanup
	.long	.Ltmp22-.Lfunc_begin0   # >> Call Site 8 <<
	.long	.Ltmp24-.Ltmp22         #   Call between .Ltmp22 and .Ltmp24
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp24-.Lfunc_begin0   # >> Call Site 9 <<
	.long	.Ltmp25-.Ltmp24         #   Call between .Ltmp24 and .Ltmp25
	.long	.Ltmp26-.Lfunc_begin0   #     jumps to .Ltmp26
	.byte	0                       #   On action: cleanup
	.long	.Ltmp27-.Lfunc_begin0   # >> Call Site 10 <<
	.long	.Ltmp28-.Ltmp27         #   Call between .Ltmp27 and .Ltmp28
	.long	.Ltmp29-.Lfunc_begin0   #     jumps to .Ltmp29
	.byte	1                       #   On action: 1
	.long	.Ltmp30-.Lfunc_begin0   # >> Call Site 11 <<
	.long	.Ltmp31-.Ltmp30         #   Call between .Ltmp30 and .Ltmp31
	.long	.Ltmp32-.Lfunc_begin0   #     jumps to .Ltmp32
	.byte	0                       #   On action: cleanup
	.long	.Ltmp31-.Lfunc_begin0   # >> Call Site 12 <<
	.long	.Ltmp33-.Ltmp31         #   Call between .Ltmp31 and .Ltmp33
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp33-.Lfunc_begin0   # >> Call Site 13 <<
	.long	.Ltmp34-.Ltmp33         #   Call between .Ltmp33 and .Ltmp34
	.long	.Ltmp35-.Lfunc_begin0   #     jumps to .Ltmp35
	.byte	0                       #   On action: cleanup
	.long	.Ltmp6-.Lfunc_begin0    # >> Call Site 14 <<
	.long	.Ltmp7-.Ltmp6           #   Call between .Ltmp6 and .Ltmp7
	.long	.Ltmp10-.Lfunc_begin0   #     jumps to .Ltmp10
	.byte	0                       #   On action: cleanup
	.long	.Ltmp7-.Lfunc_begin0    # >> Call Site 15 <<
	.long	.Lfunc_end9-.Ltmp7      #   Call between .Ltmp7 and .Lfunc_end9
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.byte	1                       # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                       #   No further actions
                                        # >> Catch TypeInfos <<
	.long	0                       # TypeInfo 1
	.p2align	2
                                        # -- End function
	.section	.text._ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev,"axG",@progbits,_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev,comdat
	.weak	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev # -- Begin function _ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.p2align	4, 0x90
	.type	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev,@function
_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev: # @_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24(%rip), %rax
	movq	%rax, (%rbx)
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64(%rip), %rax
	movq	%rax, 184(%rbx)
	leaq	16(%rbx), %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	leaq	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+8(%rip), %rsi
	leaq	184(%rbx), %r14
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmp	_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev@PLT # TAILCALL
.Lfunc_end10:
	.size	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev, .Lfunc_end10-_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.cfi_endproc
                                        # -- End function
	.section	.text.__clang_call_terminate,"axG",@progbits,__clang_call_terminate,comdat
	.hidden	__clang_call_terminate  # -- Begin function __clang_call_terminate
	.weak	__clang_call_terminate
	.p2align	4, 0x90
	.type	__clang_call_terminate,@function
__clang_call_terminate:                 # @__clang_call_terminate
# %bb.0:
	pushq	%rax
	callq	__cxa_begin_catch@PLT
	callq	_ZSt9terminatev@PLT
.Lfunc_end11:
	.size	__clang_call_terminate, .Lfunc_end11-__clang_call_terminate
                                        # -- End function
	.section	.text._ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev,"axG",@progbits,_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev,comdat
	.weak	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev # -- Begin function _ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.p2align	4, 0x90
	.type	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev,@function
_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev: # @_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	leaq	(%rdi,%rax), %rbx
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24(%rip), %rcx
	movq	%rcx, (%rdi,%rax)
	leaq	184(%rdi,%rax), %r14
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64(%rip), %rcx
	movq	%rcx, 184(%rdi,%rax)
	addq	%rax, %rdi
	addq	$16, %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	leaq	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+8(%rip), %rsi
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmp	_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev@PLT # TAILCALL
.Lfunc_end12:
	.size	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev, .Lfunc_end12-_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev,"axG",@progbits,_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev,comdat
	.weak	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev # -- Begin function _ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.p2align	4, 0x90
	.type	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev,@function
_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev: # @_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24(%rip), %rax
	movq	%rax, (%rbx)
	leaq	184(%rbx), %r14
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64(%rip), %rax
	movq	%rax, 184(%rbx)
	leaq	16(%rbx), %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	leaq	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+8(%rip), %rsi
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	callq	_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%rbx, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmp	_ZdlPv@PLT              # TAILCALL
.Lfunc_end13:
	.size	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev, .Lfunc_end13-_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev,"axG",@progbits,_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev,comdat
	.weak	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev # -- Begin function _ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.p2align	4, 0x90
	.type	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev,@function
_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev: # @_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.cfi_startproc
# %bb.0:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	leaq	(%rdi,%rax), %rbx
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24(%rip), %rcx
	movq	%rcx, (%rdi,%rax)
	leaq	184(%rdi,%rax), %r14
	leaq	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64(%rip), %rcx
	movq	%rcx, 184(%rdi,%rax)
	addq	%rax, %rdi
	addq	$16, %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	leaq	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+8(%rip), %rsi
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	callq	_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%rbx, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmp	_ZdlPv@PLT              # TAILCALL
.Lfunc_end14:
	.size	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev, .Lfunc_end14-_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
.Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception1
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	leaq	_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE+16(%rip), %rax
	movq	%rax, (%rbx)
	movq	120(%rbx), %r14
	testq	%r14, %r14
	je	.LBB15_5
# %bb.1:
.Ltmp36:
	movq	%rbx, %rdi
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv
.Ltmp37:
# %bb.2:
	movq	%r14, %rdi
	callq	fclose@PLT
	testl	%eax, %eax
	jne	.LBB15_5
# %bb.3:
	movq	$0, 120(%rbx)
.LBB15_5:
	cmpb	$0, 160(%rbx)
	je	.LBB15_8
# %bb.6:
	movq	64(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB15_8
# %bb.7:
	callq	_ZdaPv@PLT
.LBB15_8:
	cmpb	$0, 161(%rbx)
	je	.LBB15_11
# %bb.9:
	movq	104(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB15_11
# %bb.10:
	callq	_ZdaPv@PLT
.LBB15_11:
	movq	%rbx, %rdi
	popq	%rbx
	popq	%r14
	popq	%r15
	jmp	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev@PLT # TAILCALL
.LBB15_4:
.Ltmp38:
	movq	%rax, %r15
	movq	%r14, %rdi
	callq	fclose@PLT
	movq	%r15, %rdi
	callq	__cxa_begin_catch@PLT
.Ltmp39:
	callq	__cxa_end_catch@PLT
.Ltmp40:
	jmp	.LBB15_5
.LBB15_12:
.Ltmp41:
	movq	%rax, %r14
	movq	%rbx, %rdi
	callq	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	callq	__clang_call_terminate
.Lfunc_end15:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev, .Lfunc_end15-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2
GCC_except_table15:
.Lexception1:
	.byte	255                     # @LPStart Encoding = omit
	.byte	155                     # @TType Encoding = indirect pcrel sdata4
	.asciz	"\257\200"              # @TType base offset
	.byte	3                       # Call site Encoding = udata4
	.byte	39                      # Call site table length
	.long	.Ltmp36-.Lfunc_begin1   # >> Call Site 1 <<
	.long	.Ltmp37-.Ltmp36         #   Call between .Ltmp36 and .Ltmp37
	.long	.Ltmp38-.Lfunc_begin1   #     jumps to .Ltmp38
	.byte	1                       #   On action: 1
	.long	.Ltmp37-.Lfunc_begin1   # >> Call Site 2 <<
	.long	.Ltmp39-.Ltmp37         #   Call between .Ltmp37 and .Ltmp39
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp39-.Lfunc_begin1   # >> Call Site 3 <<
	.long	.Ltmp40-.Ltmp39         #   Call between .Ltmp39 and .Ltmp40
	.long	.Ltmp41-.Lfunc_begin1   #     jumps to .Ltmp41
	.byte	1                       #   On action: 1
	.byte	1                       # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                       #   No further actions
                                        # >> Catch TypeInfos <<
	.long	0                       # TypeInfo 1
	.p2align	2
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	callq	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	movq	%rbx, %rdi
	popq	%rbx
	jmp	_ZdlPv@PLT              # TAILCALL
.Lfunc_end16:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev, .Lfunc_end16-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movq	(%rbx), %rax
	callq	*48(%rax)
	movq	_ZNSt3__17codecvtIcc11__mbstate_tE2idE@GOTPCREL(%rip), %rsi
	movq	%r14, %rdi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
	movq	%rax, 128(%rbx)
	movq	(%rax), %rcx
	movzbl	162(%rbx), %ebp
	movq	%rax, %rdi
	callq	*56(%rcx)
	movb	%al, 162(%rbx)
	movzbl	%al, %ecx
	cmpl	%ecx, %ebp
	je	.LBB17_10
# %bb.1:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 48(%rbx)
	movups	%xmm0, 32(%rbx)
	movups	%xmm0, 16(%rbx)
	movb	160(%rbx), %cl
	testb	%al, %al
	je	.LBB17_6
# %bb.2:
	testb	%cl, %cl
	je	.LBB17_5
# %bb.3:
	movq	64(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB17_5
# %bb.4:
	callq	_ZdaPv@PLT
.LBB17_5:
	movb	161(%rbx), %al
	movb	%al, 160(%rbx)
	movq	104(%rbx), %rax
	movq	112(%rbx), %rcx
	movq	%rcx, 96(%rbx)
	movq	%rax, 64(%rbx)
	movb	$0, 161(%rbx)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 104(%rbx)
.LBB17_10:
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB17_6:
	testb	%cl, %cl
	je	.LBB17_7
.LBB17_9:
	movq	96(%rbx), %rdi
	movq	%rdi, 112(%rbx)
	callq	_Znam@PLT
	movq	%rax, 104(%rbx)
	movb	$1, 161(%rbx)
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB17_7:
	movq	64(%rbx), %rax
	leaq	88(%rbx), %rcx
	cmpq	%rcx, %rax
	je	.LBB17_9
# %bb.8:
	movq	96(%rbx), %rdi
	movq	%rdi, 112(%rbx)
	movq	%rax, 104(%rbx)
	movb	$0, 161(%rbx)
	callq	_Znam@PLT
	movq	%rax, 64(%rbx)
	movb	$1, 160(%rbx)
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end17:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE, .Lfunc_end17-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %r15
	movq	%rsi, %r14
	movq	%rdi, %rbx
	xorps	%xmm0, %xmm0
	movups	%xmm0, 48(%rbx)
	movups	%xmm0, 32(%rbx)
	movups	%xmm0, 16(%rbx)
	cmpb	$0, 160(%rbx)
	je	.LBB18_3
# %bb.1:
	movq	64(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB18_3
# %bb.2:
	callq	_ZdaPv@PLT
.LBB18_3:
	cmpb	$0, 161(%rbx)
	je	.LBB18_6
# %bb.4:
	movq	104(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB18_6
# %bb.5:
	callq	_ZdaPv@PLT
.LBB18_6:
	movq	%r15, 96(%rbx)
	cmpq	$9, %r15
	jb	.LBB18_12
# %bb.7:
	movb	162(%rbx), %bpl
	testq	%r14, %r14
	je	.LBB18_11
# %bb.8:
	testb	%bpl, %bpl
	je	.LBB18_11
# %bb.9:
	movq	%r14, 64(%rbx)
	movb	$0, 160(%rbx)
	jmp	.LBB18_10
.LBB18_12:
	leaq	88(%rbx), %rax
	movq	%rax, 64(%rbx)
	movq	$8, 96(%rbx)
	movb	$0, 160(%rbx)
	movb	162(%rbx), %bpl
	testb	%bpl, %bpl
	je	.LBB18_14
.LBB18_10:
	movb	$0, 161(%rbx)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 104(%rbx)
.LBB18_18:
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB18_11:
	movq	%r15, %rdi
	callq	_Znam@PLT
	movq	%rax, 64(%rbx)
	movb	$1, 160(%rbx)
	testb	%bpl, %bpl
	jne	.LBB18_10
.LBB18_14:
	cmpq	$7, %r15
	movl	$8, %edi
	cmovgq	%r15, %rdi
	movq	%rdi, 112(%rbx)
	testq	%r14, %r14
	je	.LBB18_17
# %bb.15:
	cmpq	$8, %rdi
	jb	.LBB18_17
# %bb.16:
	movq	%r14, 104(%rbx)
	movb	$0, 161(%rbx)
	jmp	.LBB18_18
.LBB18_17:
	callq	_Znam@PLT
	movq	%rax, 104(%rbx)
	movb	$1, 161(%rbx)
	jmp	.LBB18_18
.Lfunc_end18:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl, .Lfunc_end18-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%edx, %r15d
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	128(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB19_11
# %bb.1:
	movq	(%rdi), %rax
	callq	*48(%rax)
	movl	%eax, %r13d
	movq	$-1, %r14
	cmpq	$0, 120(%rbx)
	je	.LBB19_5
# %bb.2:
	testq	%r12, %r12
	je	.LBB19_6
# %bb.3:
	testl	%r13d, %r13d
	jg	.LBB19_6
.LBB19_5:
	xorl	%ebp, %ebp
.LBB19_10:
	movq	%rbp, %rax
	movq	%r14, %rdx
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB19_6:
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	callq	*48(%rax)
	xorl	%ebp, %ebp
	testl	%eax, %eax
	jne	.LBB19_10
# %bb.7:
	cmpl	$2, %r15d
	ja	.LBB19_10
# %bb.8:
	movq	120(%rbx), %rdi
	movslq	%r13d, %rax
	imulq	%rax, %r12
	xorl	%ebp, %ebp
	testl	%eax, %eax
	cmovleq	%rbp, %r12
	movq	%r12, %rsi
	movl	%r15d, %edx
	callq	fseeko@PLT
	testl	%eax, %eax
	jne	.LBB19_10
# %bb.9:
	movq	120(%rbx), %rdi
	callq	ftello@PLT
	movq	%rax, %r14
	movq	136(%rbx), %rbp
	jmp	.LBB19_10
.LBB19_11:
	movl	$8, %edi
	callq	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
	movq	%rbx, %rdi
	callq	_ZNSt8bad_castC1Ev@PLT
	movq	_ZTISt8bad_cast@GOTPCREL(%rip), %rsi
	movq	_ZNSt8bad_castD1Ev@GOTPCREL(%rip), %rdx
	movq	%rbx, %rdi
	callq	__cxa_throw@PLT
.Lfunc_end19:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj, .Lfunc_end19-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	$-1, %r14
	cmpq	$0, 120(%rbx)
	je	.LBB20_3
# %bb.1:
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	callq	*48(%rax)
	testl	%eax, %eax
	jne	.LBB20_3
# %bb.4:
	movq	120(%rbx), %rdi
	xorl	%edx, %edx
	movq	%r15, %rsi
	callq	fseeko@PLT
	testl	%eax, %eax
	je	.LBB20_6
.LBB20_3:
	xorl	%r12d, %r12d
.LBB20_7:
	movq	%r12, %rax
	movq	%r14, %rdx
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB20_6:
	movq	%r12, 136(%rbx)
	movq	%r15, %r14
	jmp	.LBB20_7
.Lfunc_end20:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj, .Lfunc_end20-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%fs:40, %rax
	movq	%rax, 16(%rsp)
	movq	%rdi, %r12
	xorl	%r13d, %r13d
	cmpq	$0, 120(%r12)
	je	.LBB21_24
# %bb.1:
	movq	128(%r12), %rdi
	testq	%rdi, %rdi
	je	.LBB21_27
# %bb.2:
	movl	156(%r12), %eax
	testb	$16, %al
	jne	.LBB21_6
# %bb.3:
	testb	$8, %al
	je	.LBB21_23
# %bb.4:
	movq	144(%r12), %rax
	movq	%rax, 8(%rsp)
	cmpb	$0, 162(%r12)
	je	.LBB21_13
# %bb.5:
	movq	32(%r12), %r14
	subq	24(%r12), %r14
	jmp	.LBB21_17
.LBB21_6:
	movq	48(%r12), %rax
	cmpq	40(%r12), %rax
	je	.LBB21_8
# %bb.7:
	movq	(%r12), %rax
	movl	$-1, %r13d
	movl	$-1, %esi
	movq	%r12, %rdi
	callq	*104(%rax)
	cmpl	$-1, %eax
	je	.LBB21_24
.LBB21_8:
	leaq	136(%r12), %r14
	leaq	8(%rsp), %r15
	movl	$-1, %r13d
	.p2align	4, 0x90
.LBB21_9:                               # =>This Inner Loop Header: Depth=1
	movq	64(%r12), %rdx
	movq	128(%r12), %rdi
	movq	96(%r12), %rcx
	addq	%rdx, %rcx
	movq	(%rdi), %rax
	movq	%r14, %rsi
	movq	%r15, %r8
	callq	*40(%rax)
	movl	%eax, %ebx
	movq	8(%rsp), %rbp
	movq	64(%r12), %rdi
	movq	120(%r12), %rcx
	subq	%rdi, %rbp
	movl	$1, %esi
	movq	%rbp, %rdx
	callq	fwrite@PLT
	cmpq	%rbp, %rax
	jne	.LBB21_24
# %bb.10:                               #   in Loop: Header=BB21_9 Depth=1
	cmpl	$1, %ebx
	je	.LBB21_9
# %bb.11:
	cmpl	$2, %ebx
	je	.LBB21_24
# %bb.12:
	movq	120(%r12), %rdi
	callq	fflush@PLT
	testl	%eax, %eax
	jne	.LBB21_24
	jmp	.LBB21_23
.LBB21_13:
	movq	(%rdi), %rax
	callq	*48(%rax)
	movq	72(%r12), %rcx
	movq	80(%r12), %r14
	subq	%rcx, %r14
	testl	%eax, %eax
	jle	.LBB21_15
# %bb.14:
	movq	32(%r12), %rcx
	subq	24(%r12), %rcx
	cltq
	imulq	%rax, %rcx
	addq	%rcx, %r14
.LBB21_17:
	xorl	%ebx, %ebx
.LBB21_18:
	movq	120(%r12), %rdi
	negq	%r14
	movl	$1, %edx
	movq	%r14, %rsi
	callq	fseeko@PLT
	testl	%eax, %eax
	je	.LBB21_20
# %bb.19:
	movl	$-1, %r13d
	movq	%fs:40, %rax
	cmpq	16(%rsp), %rax
	je	.LBB21_25
.LBB21_26:
	callq	__stack_chk_fail@PLT
.LBB21_20:
	testb	%bl, %bl
	je	.LBB21_22
# %bb.21:
	movq	8(%rsp), %rax
	movq	%rax, 136(%r12)
.LBB21_22:
	movq	64(%r12), %rax
	movq	%rax, 80(%r12)
	movq	%rax, 72(%r12)
	movl	$0, 156(%r12)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%r12)
	movq	$0, 32(%r12)
.LBB21_23:
	xorl	%r13d, %r13d
.LBB21_24:
	movq	%fs:40, %rax
	cmpq	16(%rsp), %rax
	jne	.LBB21_26
.LBB21_25:
	movl	%r13d, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB21_15:
	movq	24(%r12), %r8
	cmpq	32(%r12), %r8
	je	.LBB21_17
# %bb.16:
	movq	64(%r12), %rdx
	movq	128(%r12), %rdi
	subq	16(%r12), %r8
	movq	(%rdi), %rax
	leaq	8(%rsp), %rsi
	callq	*64(%rax)
	cltq
	addq	72(%r12), %r14
	subq	%rax, %r14
	subq	64(%r12), %r14
	movb	$1, %bl
	jmp	.LBB21_18
.LBB21_27:
	movl	$8, %edi
	callq	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
	movq	%rbx, %rdi
	callq	_ZNSt8bad_castC1Ev@PLT
	movq	_ZTISt8bad_cast@GOTPCREL(%rip), %rsi
	movq	_ZNSt8bad_castD1Ev@GOTPCREL(%rip), %rdx
	movq	%rbx, %rdi
	callq	__cxa_throw@PLT
.Lfunc_end21:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv, .Lfunc_end21-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv
	.cfi_startproc
# %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	movq	%fs:40, %rax
	movq	%rax, 16(%rsp)
	cmpq	$0, 120(%rbx)
	je	.LBB22_3
# %bb.1:
	testb	$8, 156(%rbx)
	jne	.LBB22_4
# %bb.2:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 40(%rbx)
	movq	$0, 56(%rbx)
	leaq	104(%rbx), %rax
	leaq	112(%rbx), %rcx
	leaq	64(%rbx), %rdx
	leaq	96(%rbx), %rsi
	cmpb	$0, 162(%rbx)
	cmoveq	%rcx, %rsi
	cmoveq	%rax, %rdx
	movq	(%rdx), %rax
	movq	(%rsi), %rsi
	addq	%rax, %rsi
	movq	%rax, 16(%rbx)
	movq	%rsi, 24(%rbx)
	movq	%rsi, 32(%rbx)
	movl	$8, 156(%rbx)
	movb	$1, %al
	testq	%rsi, %rsi
	je	.LBB22_11
.LBB22_5:
	testb	%al, %al
	je	.LBB22_12
.LBB22_6:
	movq	32(%rbx), %rax
	xorl	%r14d, %r14d
	cmpq	%rax, %rsi
	je	.LBB22_13
.LBB22_7:
	movzbl	(%rsi), %eax
	leaq	16(%rbx), %r15
	leaq	15(%rsp), %rcx
	cmpq	%rcx, (%r15)
	jne	.LBB22_9
.LBB22_8:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%rbx)
	movq	$0, 32(%rbx)
.LBB22_9:
	movq	%fs:40, %rcx
	cmpq	16(%rsp), %rcx
	jne	.LBB22_30
.LBB22_10:
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB22_3:
	movl	$-1, %eax
	movq	%fs:40, %rcx
	cmpq	16(%rsp), %rcx
	je	.LBB22_10
.LBB22_30:
	callq	__stack_chk_fail@PLT
.LBB22_4:
	movq	24(%rbx), %rsi
	xorl	%eax, %eax
	testq	%rsi, %rsi
	jne	.LBB22_5
.LBB22_11:
	leaq	16(%rsp), %rsi
	leaq	15(%rsp), %rcx
	movq	%rcx, 16(%rbx)
	movq	%rsi, 24(%rbx)
	movq	%rsi, 32(%rbx)
	testb	%al, %al
	jne	.LBB22_6
.LBB22_12:
	movq	32(%rbx), %rax
	movq	%rax, %rcx
	subq	16(%rbx), %rcx
	movq	%rcx, %rdx
	shrq	$63, %rdx
	addq	%rcx, %rdx
	sarq	%rdx
	cmpq	$4, %rdx
	movl	$4, %r14d
	cmovbq	%rdx, %r14
	cmpq	%rax, %rsi
	jne	.LBB22_7
.LBB22_13:
	leaq	16(%rbx), %r15
	movq	16(%rbx), %rdi
	subq	%r14, %rsi
	movq	%r14, %rdx
	callq	memmove@PLT
	cmpb	$0, 162(%rbx)
	je	.LBB22_16
# %bb.14:
	movq	16(%rbx), %rdi
	movq	32(%rbx), %rdx
	subq	%r14, %rdx
	subq	%rdi, %rdx
	addq	%r14, %rdi
	movq	120(%rbx), %rcx
	movl	$1, %esi
	callq	fread@PLT
	testq	%rax, %rax
	je	.LBB22_20
# %bb.15:
	movq	16(%rbx), %rcx
	leaq	(%rcx,%r14), %rdx
	movq	%rdx, 24(%rbx)
	addq	%rdx, %rax
	movq	%rax, 32(%rbx)
	movzbl	(%rcx,%r14), %eax
	leaq	15(%rsp), %rcx
	cmpq	%rcx, (%r15)
	jne	.LBB22_9
	jmp	.LBB22_8
.LBB22_16:
	movq	72(%rbx), %rsi
	movq	80(%rbx), %rdi
	movq	%rdi, %rdx
	subq	%rsi, %rdx
	je	.LBB22_18
# %bb.17:
	movq	64(%rbx), %rdi
	callq	memmove@PLT
	movq	72(%rbx), %rsi
	movq	80(%rbx), %rdi
.LBB22_18:
	subq	%rsi, %rdi
	movq	64(%rbx), %rdx
	addq	%rdx, %rdi
	movq	%rdi, 72(%rbx)
	leaq	88(%rbx), %rax
	cmpq	%rax, %rdx
	je	.LBB22_21
# %bb.19:
	movq	96(%rbx), %rax
	jmp	.LBB22_22
.LBB22_21:
	movl	$8, %eax
.LBB22_22:
	addq	%rax, %rdx
	movq	%rdx, 80(%rbx)
	movq	112(%rbx), %rax
	subq	%r14, %rax
	subq	%rdi, %rdx
	cmpq	%rax, %rdx
	cmovaeq	%rax, %rdx
	movq	120(%rbx), %rcx
	movq	136(%rbx), %rax
	movq	%rax, 144(%rbx)
	movl	$1, %esi
	callq	fread@PLT
	testq	%rax, %rax
	je	.LBB22_20
# %bb.23:
	movq	128(%rbx), %rdi
	testq	%rdi, %rdi
	je	.LBB22_31
# %bb.24:
	leaq	72(%rbx), %r8
	leaq	136(%rbx), %rsi
	addq	72(%rbx), %rax
	movq	%rax, 80(%rbx)
	movq	16(%rbx), %r10
	movq	64(%rbx), %rdx
	leaq	(%r10,%r14), %r9
	addq	112(%rbx), %r10
	movq	(%rdi), %r11
	movq	%rsp, %r12
	movq	%rax, %rcx
	pushq	%r12
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	callq	*32(%r11)
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	cmpl	$3, %eax
	jne	.LBB22_27
# %bb.25:
	movq	64(%rbx), %r14
	movq	80(%rbx), %rax
	movq	%r14, 16(%rbx)
	jmp	.LBB22_28
.LBB22_27:
	movq	(%rsp), %rax
	addq	(%r15), %r14
	cmpq	%r14, %rax
	je	.LBB22_20
.LBB22_28:
	movq	%r14, 24(%rbx)
	movq	%rax, 32(%rbx)
	movzbl	(%r14), %eax
	leaq	15(%rsp), %rcx
	cmpq	%rcx, (%r15)
	jne	.LBB22_9
	jmp	.LBB22_8
.LBB22_20:
	movl	$-1, %eax
	leaq	15(%rsp), %rcx
	cmpq	%rcx, (%r15)
	jne	.LBB22_9
	jmp	.LBB22_8
.LBB22_31:
	movl	$8, %edi
	callq	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
	movq	%rbx, %rdi
	callq	_ZNSt8bad_castC1Ev@PLT
	movq	_ZTISt8bad_cast@GOTPCREL(%rip), %rsi
	movq	_ZNSt8bad_castD1Ev@GOTPCREL(%rip), %rdx
	movq	%rbx, %rdi
	callq	__cxa_throw@PLT
.Lfunc_end22:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv, .Lfunc_end22-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi
	.cfi_startproc
# %bb.0:
	movl	$-1, %eax
	cmpq	$0, 120(%rdi)
	je	.LBB23_7
# %bb.1:
	movq	24(%rdi), %rcx
	cmpq	%rcx, 16(%rdi)
	jae	.LBB23_7
# %bb.2:
	cmpl	$-1, %esi
	je	.LBB23_3
# %bb.4:
	testb	$16, 152(%rdi)
	jne	.LBB23_6
# %bb.5:
	cmpb	%sil, -1(%rcx)
	jne	.LBB23_7
.LBB23_6:
	addq	$-1, %rcx
	movq	%rcx, 24(%rdi)
	movb	%sil, (%rcx)
	movl	%esi, %eax
.LBB23_7:
	retq
.LBB23_3:
	addq	$-1, %rcx
	movq	%rcx, 24(%rdi)
	xorl	%eax, %eax
	retq
.Lfunc_end23:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi, .Lfunc_end23-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%esi, %r14d
	movq	%rdi, %r13
	movq	%fs:40, %rax
	movq	%rax, 48(%rsp)
	cmpq	$0, 120(%r13)
	je	.LBB24_30
# %bb.1:
	testb	$16, 156(%r13)
	jne	.LBB24_2
# %bb.3:
	xorps	%xmm0, %xmm0
	movups	%xmm0, 16(%r13)
	movq	$0, 32(%r13)
	movq	96(%r13), %rax
	cmpq	$9, %rax
	jb	.LBB24_8
# %bb.4:
	cmpb	$0, 162(%r13)
	je	.LBB24_7
# %bb.5:
	movq	64(%r13), %rdi
	jmp	.LBB24_6
.LBB24_2:
	leaq	40(%r13), %rax
	movq	%rax, (%rsp)            # 8-byte Spill
	movq	40(%r13), %rdi
	movq	56(%r13), %r12
	leaq	56(%r13), %r15
	movq	%rdi, %rbx
	movq	48(%r13), %rbp
	cmpl	$-1, %r14d
	je	.LBB24_14
.LBB24_11:
	testq	%rbp, %rbp
	jne	.LBB24_13
# %bb.12:
	leaq	48(%rsp), %rax
	leaq	47(%rsp), %rbp
	movq	%rbp, 48(%r13)
	movq	%rbp, 40(%r13)
	movq	%rax, 56(%r13)
.LBB24_13:
	movb	%r14b, (%rbp)
	movq	40(%r13), %rdi
	movq	48(%r13), %rbp
	addq	$1, %rbp
	movq	%rbp, 48(%r13)
	subq	%rdi, %rbp
	jne	.LBB24_15
	jmp	.LBB24_18
.LBB24_8:
	leaq	40(%r13), %rax
	movq	%rax, (%rsp)            # 8-byte Spill
	movups	%xmm0, 40(%r13)
	movq	$0, 56(%r13)
	leaq	56(%r13), %r15
	xorl	%edi, %edi
	xorl	%r12d, %r12d
	xorl	%ebx, %ebx
	movl	$16, 156(%r13)
	movq	48(%r13), %rbp
	cmpl	$-1, %r14d
	jne	.LBB24_11
.LBB24_14:
	subq	%rdi, %rbp
	je	.LBB24_18
.LBB24_15:
	cmpb	$0, 162(%r13)
	je	.LBB24_19
# %bb.16:
	movq	120(%r13), %rcx
	movl	$1, %esi
	movq	%rbp, %rdx
	callq	fwrite@PLT
	movq	%rax, %rcx
	movl	$-1, %eax
	cmpq	%rbp, %rcx
	je	.LBB24_17
	jmp	.LBB24_31
.LBB24_19:
	movq	%rbx, 8(%rsp)           # 8-byte Spill
	movq	%r12, 16(%rsp)          # 8-byte Spill
	movq	64(%r13), %rax
	movq	%rax, 32(%rsp)
	movq	128(%r13), %rdi
	testq	%rdi, %rdi
	je	.LBB24_29
# %bb.20:
	leaq	136(%r13), %r12
	.p2align	4, 0x90
.LBB24_21:                              # =>This Inner Loop Header: Depth=1
	movq	40(%r13), %rdx
	movq	48(%r13), %rcx
	movq	64(%r13), %r9
	movq	96(%r13), %rax
	addq	%r9, %rax
	movq	(%rdi), %rbp
	movq	%r12, %rsi
	leaq	24(%rsp), %r8
	leaq	32(%rsp), %rbx
	pushq	%rbx
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	callq	*24(%rbp)
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	movl	%eax, %ebp
	movq	40(%r13), %rdi
	cmpq	%rdi, 24(%rsp)
	je	.LBB24_30
# %bb.22:                               #   in Loop: Header=BB24_21 Depth=1
	cmpl	$3, %ebp
	je	.LBB24_23
# %bb.25:                               #   in Loop: Header=BB24_21 Depth=1
	cmpl	$1, %ebp
	ja	.LBB24_30
# %bb.26:                               #   in Loop: Header=BB24_21 Depth=1
	movq	32(%rsp), %rbx
	movq	64(%r13), %rdi
	movq	120(%r13), %rcx
	subq	%rdi, %rbx
	movl	$1, %esi
	movq	%rbx, %rdx
	callq	fwrite@PLT
	cmpq	%rbx, %rax
	jne	.LBB24_30
# %bb.27:                               #   in Loop: Header=BB24_21 Depth=1
	cmpl	$1, %ebp
	jne	.LBB24_24
# %bb.28:                               #   in Loop: Header=BB24_21 Depth=1
	movq	24(%rsp), %rax
	movq	48(%r13), %rcx
	movq	(%rsp), %rdx            # 8-byte Reload
	movq	%rax, (%rdx)
	movq	%rcx, (%r15)
	movq	%rcx, 48(%r13)
	movq	128(%r13), %rdi
	testq	%rdi, %rdi
	jne	.LBB24_21
.LBB24_29:
	movl	$8, %edi
	callq	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
	movq	%rbx, %rdi
	callq	_ZNSt8bad_castC1Ev@PLT
	movq	_ZTISt8bad_cast@GOTPCREL(%rip), %rsi
	movq	_ZNSt8bad_castD1Ev@GOTPCREL(%rip), %rdx
	movq	%rbx, %rdi
	callq	__cxa_throw@PLT
.LBB24_7:
	movq	104(%r13), %rdi
	movq	112(%r13), %rax
.LBB24_6:
	leaq	(%rdi,%rax), %r12
	addq	$-1, %r12
	movq	%rdi, 48(%r13)
	movq	%rdi, 40(%r13)
	leaq	40(%r13), %rax
	movq	%rax, (%rsp)            # 8-byte Spill
	leaq	56(%r13), %r15
	movq	%r12, 56(%r13)
	movq	%rdi, %rbx
	movl	$16, 156(%r13)
	movq	48(%r13), %rbp
	cmpl	$-1, %r14d
	jne	.LBB24_11
	jmp	.LBB24_14
.LBB24_23:
	movq	48(%r13), %rbp
	movq	120(%r13), %rcx
	subq	%rdi, %rbp
	movl	$1, %esi
	movq	%rbp, %rdx
	callq	fwrite@PLT
	cmpq	%rbp, %rax
	jne	.LBB24_30
.LBB24_24:
	movq	16(%rsp), %r12          # 8-byte Reload
	movq	8(%rsp), %rbx           # 8-byte Reload
.LBB24_17:
	movq	%rbx, 48(%r13)
	movq	(%rsp), %rax            # 8-byte Reload
	movq	%rbx, (%rax)
	movq	%r12, (%r15)
.LBB24_18:
	xorl	%eax, %eax
	cmpl	$-1, %r14d
	cmovnel	%r14d, %eax
	movq	%fs:40, %rcx
	cmpq	48(%rsp), %rcx
	je	.LBB24_32
	jmp	.LBB24_33
.LBB24_30:
	movl	$-1, %eax
.LBB24_31:
	movq	%fs:40, %rcx
	cmpq	48(%rsp), %rcx
	jne	.LBB24_33
.LBB24_32:
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB24_33:
	callq	__stack_chk_fail@PLT
.Lfunc_end24:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi, .Lfunc_end24-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev,"axG",@progbits,_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev,comdat
	.weak	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev # -- Begin function _ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev
	.p2align	4, 0x90
	.type	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev,@function
_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev: # @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev
.Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception2
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %rbp, -16
	movq	%rdi, %rbx
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	callq	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEEC2Ev@PLT
	leaq	_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE+16(%rip), %rax
	movq	%rax, (%rbx)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 64(%rbx)
	movq	$0, 80(%rbx)
	movups	%xmm0, 144(%rbx)
	movups	%xmm0, 128(%rbx)
	movups	%xmm0, 112(%rbx)
	movb	$0, 162(%rbx)
	movups	%xmm0, 96(%rbx)
	movw	$0, 160(%rbx)
	leaq	8(%rbx), %r14
	movq	%rsp, %rbp
	movq	%rbp, %rdi
	movq	%r14, %rsi
	callq	_ZNSt3__16localeC1ERKS0_@PLT
.Ltmp42:
	movq	_ZNSt3__17codecvtIcc11__mbstate_tE2idE@GOTPCREL(%rip), %rsi
	movq	%rbp, %rdi
	callq	_ZNKSt3__16locale9has_facetERNS0_2idE@PLT
	movl	%eax, %ebp
.Ltmp43:
# %bb.1:
	movq	%rsp, %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	testb	%bpl, %bpl
	je	.LBB25_4
# %bb.2:
	movq	%rsp, %rbp
	movq	%rbp, %rdi
	movq	%r14, %rsi
	callq	_ZNSt3__16localeC1ERKS0_@PLT
.Ltmp45:
	movq	_ZNSt3__17codecvtIcc11__mbstate_tE2idE@GOTPCREL(%rip), %rsi
	movq	%rbp, %rdi
	callq	_ZNKSt3__16locale9use_facetERNS0_2idE@PLT
.Ltmp46:
# %bb.3:
	movq	%rax, 128(%rbx)
	movq	%rsp, %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movq	128(%rbx), %rdi
	movq	(%rdi), %rax
	callq	*56(%rax)
	movb	%al, 162(%rbx)
.LBB25_4:
	movq	(%rbx), %rax
.Ltmp48:
	xorl	%esi, %esi
	movl	$4096, %edx             # imm = 0x1000
	movq	%rbx, %rdi
	callq	*24(%rax)
.Ltmp49:
# %bb.5:
	movq	%fs:40, %rax
	cmpq	8(%rsp), %rax
	jne	.LBB25_9
# %bb.6:
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB25_9:
	callq	__stack_chk_fail@PLT
.LBB25_11:
.Ltmp47:
	movq	%rax, %r14
	movq	%rsp, %rdi
	callq	_ZNSt3__16localeD1Ev@PLT
	movq	%rbx, %rdi
	callq	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.LBB25_7:
.Ltmp50:
	movq	%rax, %r14
	movq	%rbx, %rdi
	callq	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.LBB25_10:
.Ltmp44:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.Lfunc_end25:
	.size	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev, .Lfunc_end25-_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2
GCC_except_table25:
.Lexception2:
	.byte	255                     # @LPStart Encoding = omit
	.byte	155                     # @TType Encoding = indirect pcrel sdata4
	.asciz	"\326\200\200"          # @TType base offset
	.byte	3                       # Call site Encoding = udata4
	.byte	78                      # Call site table length
	.long	.Lfunc_begin2-.Lfunc_begin2 # >> Call Site 1 <<
	.long	.Ltmp42-.Lfunc_begin2   #   Call between .Lfunc_begin2 and .Ltmp42
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp42-.Lfunc_begin2   # >> Call Site 2 <<
	.long	.Ltmp43-.Ltmp42         #   Call between .Ltmp42 and .Ltmp43
	.long	.Ltmp44-.Lfunc_begin2   #     jumps to .Ltmp44
	.byte	1                       #   On action: 1
	.long	.Ltmp45-.Lfunc_begin2   # >> Call Site 3 <<
	.long	.Ltmp46-.Ltmp45         #   Call between .Ltmp45 and .Ltmp46
	.long	.Ltmp47-.Lfunc_begin2   #     jumps to .Ltmp47
	.byte	0                       #   On action: cleanup
	.long	.Ltmp46-.Lfunc_begin2   # >> Call Site 4 <<
	.long	.Ltmp48-.Ltmp46         #   Call between .Ltmp46 and .Ltmp48
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp48-.Lfunc_begin2   # >> Call Site 5 <<
	.long	.Ltmp49-.Ltmp48         #   Call between .Ltmp48 and .Ltmp49
	.long	.Ltmp50-.Lfunc_begin2   #     jumps to .Ltmp50
	.byte	0                       #   On action: cleanup
	.long	.Ltmp49-.Lfunc_begin2   # >> Call Site 6 <<
	.long	.Lfunc_end25-.Ltmp49    #   Call between .Ltmp49 and .Lfunc_end25
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.byte	1                       # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                       #   No further actions
                                        # >> Catch TypeInfos <<
	.long	0                       # TypeInfo 1
	.p2align	2
                                        # -- End function
	.section	.text._ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_,"axG",@progbits,_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_,comdat
	.weak	_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_ # -- Begin function _ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_
	.p2align	4, 0x90
	.type	_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_,@function
_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_: # @_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_
.Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception3
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%edx, %r14d
	movq	%rsi, %rbp
	movq	%rdi, %r15
	movq	%fs:40, %rax
	movq	%rax, 16(%rsp)
.Ltmp51:
	leaq	8(%rsp), %rdi
	movl	$1, %edx
	movq	%r15, %rsi
	callq	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEE6sentryC1ERS3_b@PLT
.Ltmp52:
# %bb.1:
	cmpb	$0, 8(%rsp)
	je	.LBB26_14
# %bb.2:
	testb	$1, (%rbp)
	jne	.LBB26_3
# %bb.4:
	movw	$0, (%rbp)
	jmp	.LBB26_5
.LBB26_3:
	movq	16(%rbp), %rax
	movb	$0, (%rax)
	movq	$0, 8(%rbp)
.LBB26_5:
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB26_6:                               # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	movq	-24(%rax), %rax
	movq	40(%r15,%rax), %rdi
	movq	24(%rdi), %rax
	cmpq	32(%rdi), %rax
	je	.LBB26_7
# %bb.17:                               #   in Loop: Header=BB26_6 Depth=1
	leaq	1(%rax), %rcx
	movq	%rcx, 24(%rdi)
	movzbl	(%rax), %ecx
	cmpb	%r14b, %cl
	jne	.LBB26_20
	jmp	.LBB26_19
	.p2align	4, 0x90
.LBB26_7:                               #   in Loop: Header=BB26_6 Depth=1
	movq	(%rdi), %rax
.Ltmp54:
	callq	*80(%rax)
	movl	%eax, %ecx
.Ltmp55:
# %bb.8:                                #   in Loop: Header=BB26_6 Depth=1
	cmpl	$-1, %ecx
	je	.LBB26_9
# %bb.18:                               #   in Loop: Header=BB26_6 Depth=1
	cmpb	%r14b, %cl
	je	.LBB26_19
.LBB26_20:                              #   in Loop: Header=BB26_6 Depth=1
.Ltmp57:
	movsbl	%cl, %esi
	movq	%rbp, %rdi
	callq	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9push_backEc@PLT
.Ltmp58:
# %bb.21:                               #   in Loop: Header=BB26_6 Depth=1
	addq	$-1, %rbx
	testb	$1, (%rbp)
	je	.LBB26_6
# %bb.22:                               #   in Loop: Header=BB26_6 Depth=1
	cmpq	$-17, 8(%rbp)
	jne	.LBB26_6
# %bb.23:
	movl	$4, %esi
	jmp	.LBB26_10
.LBB26_19:
	xorl	%esi, %esi
	jmp	.LBB26_10
.LBB26_9:
	xorl	%eax, %eax
	testq	%rbx, %rbx
	sete	%al
	leal	2(,%rax,4), %esi
.LBB26_10:
	movq	(%r15), %rax
	movq	-24(%rax), %rax
	leaq	(%r15,%rax), %rdi
	orl	32(%r15,%rax), %esi
.Ltmp60:
	callq	_ZNSt3__18ios_base5clearEj@PLT
.Ltmp61:
.LBB26_14:
	movq	%fs:40, %rax
	cmpq	16(%rsp), %rax
	jne	.LBB26_29
.LBB26_15:
	movq	%r15, %rax
	addq	$24, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB26_25:
.Ltmp62:
	jmp	.LBB26_12
.LBB26_11:
.Ltmp53:
	jmp	.LBB26_12
.LBB26_16:
.Ltmp56:
	jmp	.LBB26_12
.LBB26_24:
.Ltmp59:
.LBB26_12:
	movq	%rax, %rdi
	movq	%r15, %rbp
	callq	__cxa_begin_catch@PLT
	movq	(%r15), %rax
	addq	-24(%rax), %rbp
.Ltmp63:
	movq	%rbp, %rdi
	callq	_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv@PLT
.Ltmp64:
# %bb.13:
	callq	__cxa_end_catch@PLT
	movq	%fs:40, %rax
	cmpq	16(%rsp), %rax
	je	.LBB26_15
.LBB26_29:
	callq	__stack_chk_fail@PLT
.LBB26_26:
.Ltmp65:
	movq	%rax, %rbx
.Ltmp66:
	callq	__cxa_end_catch@PLT
.Ltmp67:
# %bb.27:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB26_28:
.Ltmp68:
	movq	%rax, %rdi
	callq	__clang_call_terminate
.Lfunc_end26:
	.size	_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_, .Lfunc_end26-_ZNSt3__17getlineIcNS_11char_traitsIcEENS_9allocatorIcEEEERNS_13basic_istreamIT_T0_EES9_RNS_12basic_stringIS6_S7_T1_EES6_
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2
GCC_except_table26:
.Lexception3:
	.byte	255                     # @LPStart Encoding = omit
	.byte	155                     # @TType Encoding = indirect pcrel sdata4
	.byte	125                     # @TType base offset
	.byte	3                       # Call site Encoding = udata4
	.byte	117                     # Call site table length
	.long	.Ltmp51-.Lfunc_begin3   # >> Call Site 1 <<
	.long	.Ltmp52-.Ltmp51         #   Call between .Ltmp51 and .Ltmp52
	.long	.Ltmp53-.Lfunc_begin3   #     jumps to .Ltmp53
	.byte	1                       #   On action: 1
	.long	.Ltmp54-.Lfunc_begin3   # >> Call Site 2 <<
	.long	.Ltmp55-.Ltmp54         #   Call between .Ltmp54 and .Ltmp55
	.long	.Ltmp56-.Lfunc_begin3   #     jumps to .Ltmp56
	.byte	1                       #   On action: 1
	.long	.Ltmp57-.Lfunc_begin3   # >> Call Site 3 <<
	.long	.Ltmp58-.Ltmp57         #   Call between .Ltmp57 and .Ltmp58
	.long	.Ltmp59-.Lfunc_begin3   #     jumps to .Ltmp59
	.byte	1                       #   On action: 1
	.long	.Ltmp60-.Lfunc_begin3   # >> Call Site 4 <<
	.long	.Ltmp61-.Ltmp60         #   Call between .Ltmp60 and .Ltmp61
	.long	.Ltmp62-.Lfunc_begin3   #     jumps to .Ltmp62
	.byte	1                       #   On action: 1
	.long	.Ltmp61-.Lfunc_begin3   # >> Call Site 5 <<
	.long	.Ltmp63-.Ltmp61         #   Call between .Ltmp61 and .Ltmp63
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp63-.Lfunc_begin3   # >> Call Site 6 <<
	.long	.Ltmp64-.Ltmp63         #   Call between .Ltmp63 and .Ltmp64
	.long	.Ltmp65-.Lfunc_begin3   #     jumps to .Ltmp65
	.byte	0                       #   On action: cleanup
	.long	.Ltmp64-.Lfunc_begin3   # >> Call Site 7 <<
	.long	.Ltmp66-.Ltmp64         #   Call between .Ltmp64 and .Ltmp66
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp66-.Lfunc_begin3   # >> Call Site 8 <<
	.long	.Ltmp67-.Ltmp66         #   Call between .Ltmp66 and .Ltmp67
	.long	.Ltmp68-.Lfunc_begin3   #     jumps to .Ltmp68
	.byte	1                       #   On action: 1
	.long	.Ltmp67-.Lfunc_begin3   # >> Call Site 9 <<
	.long	.Lfunc_end26-.Ltmp67    #   Call between .Ltmp67 and .Lfunc_end26
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.byte	1                       # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                       #   No further actions
                                        # >> Catch TypeInfos <<
	.long	0                       # TypeInfo 1
	.p2align	2
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function _ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm
.LCPI27_0:
	.long	1593835520              # float 9.22337203E+18
	.section	.text._ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm,"axG",@progbits,_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm,comdat
	.weak	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm
	.p2align	4, 0x90
	.type	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm,@function
_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm: # @_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rbx
	movq	%rdi, %r14
	cmpq	$1, %rbx
	jne	.LBB27_2
# %bb.1:
	movl	$2, %ebx
	movq	8(%r14), %r15
	cmpq	%r15, %rbx
	ja	.LBB27_18
	jmp	.LBB27_5
.LBB27_2:
	leaq	-1(%rbx), %rax
	testq	%rbx, %rax
	je	.LBB27_4
# %bb.3:
	movq	%rbx, %rdi
	callq	_ZNSt3__112__next_primeEm@PLT
	movq	%rax, %rbx
.LBB27_4:
	movq	8(%r14), %r15
	cmpq	%r15, %rbx
	jbe	.LBB27_5
.LBB27_18:
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm # TAILCALL
.LBB27_5:
	jae	.LBB27_17
# %bb.6:
	cmpq	$3, %r15
	jb	.LBB27_7
# %bb.8:
	leaq	-1(%r15), %rax
	testq	%r15, %rax
	sete	%bpl
	movq	24(%r14), %rax
	testq	%rax, %rax
	jns	.LBB27_11
.LBB27_10:
	movq	%rax, %rcx
	shrq	%rcx
	andl	$1, %eax
	orq	%rcx, %rax
	cvtsi2ssq	%rax, %xmm0
	addss	%xmm0, %xmm0
	jmp	.LBB27_12
.LBB27_7:
	xorl	%ebp, %ebp
	movq	24(%r14), %rax
	testq	%rax, %rax
	js	.LBB27_10
.LBB27_11:
	cvtsi2ssq	%rax, %xmm0
.LBB27_12:
	divss	32(%r14), %xmm0
	callq	ceilf@PLT
	movss	.LCPI27_0(%rip), %xmm1  # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm2
	subss	%xmm1, %xmm2
	cvttss2si	%xmm2, %rax
	movabsq	$-9223372036854775808, %rcx # imm = 0x8000000000000000
	xorq	%rax, %rcx
	cvttss2si	%xmm0, %rax
	ucomiss	%xmm1, %xmm0
	cmovaeq	%rcx, %rax
	testb	%bpl, %bpl
	je	.LBB27_15
# %bb.13:
	cmpq	$2, %rax
	jb	.LBB27_16
# %bb.14:
	addq	$-1, %rax
	bsrq	%rax, %rcx
	xorl	$192, %ecx
	addl	$65, %ecx
	movl	$1, %eax
                                        # kill: def %cl killed %cl killed %rcx
	shlq	%cl, %rax
	cmpq	%rax, %rbx
	cmovbq	%rax, %rbx
	cmpq	%r15, %rbx
	jb	.LBB27_18
	jmp	.LBB27_17
.LBB27_15:
	movq	%rax, %rdi
	callq	_ZNSt3__112__next_primeEm@PLT
.LBB27_16:
	cmpq	%rax, %rbx
	cmovbq	%rax, %rbx
	cmpq	%r15, %rbx
	jb	.LBB27_18
.LBB27_17:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end27:
	.size	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm, .Lfunc_end27-_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE6rehashEm
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm,"axG",@progbits,_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm,comdat
	.weak	_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm # -- Begin function _ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm
	.p2align	4, 0x90
	.type	_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm,@function
_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm: # @_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	cmpq	$32, %rdx
	ja	.LBB28_10
# %bb.1:
	cmpq	$16, %rdx
	ja	.LBB28_8
# %bb.2:
	cmpq	$9, %rdx
	jb	.LBB28_4
# %bb.3:
	movq	-8(%rsi,%rdx), %rdi
	leaq	(%rdi,%rdx), %rax
	movl	%edx, %ecx
	shrdq	%cl, %rax, %rax
	movq	(%rsi), %rcx
	xorq	%rax, %rcx
	movabsq	$-7070675565921424023, %rdx # imm = 0x9DDFEA08EB382D69
	imulq	%rdx, %rcx
	movq	%rcx, %rsi
	shrq	$47, %rsi
	xorq	%rax, %rcx
	xorq	%rsi, %rcx
	imulq	%rdx, %rcx
	movq	%rcx, %rax
	shrq	$47, %rax
	xorq	%rcx, %rax
	imulq	%rdx, %rax
	xorq	%rdi, %rax
	jmp	.LBB28_16
.LBB28_10:
	cmpq	$64, %rdx
	ja	.LBB28_12
# %bb.11:
	movq	16(%rsi), %rbp
	movq	24(%rsi), %rax
	movq	-16(%rsi,%rdx), %r9
	leaq	(%r9,%rdx), %rbx
	movabsq	$-4348849565147123417, %r8 # imm = 0xC3A5C85C97CB3127
	imulq	%r8, %rbx
	addq	(%rsi), %rbx
	leaq	(%rbx,%rax), %r10
	rolq	$12, %r10
	movq	%rbx, %rdi
	rolq	$27, %rdi
	addq	8(%rsi), %rbx
	movq	%rbx, %rcx
	rolq	$57, %rcx
	addq	%rdi, %rcx
	addq	%rbp, %rbx
	movq	%rbx, %r11
	rolq	$33, %r11
	addq	%r10, %rcx
	addq	%rcx, %r11
	addq	-32(%rsi,%rdx), %rbp
	addq	%rax, %rbx
	addq	-8(%rsi,%rdx), %rax
	leaq	(%rax,%rbp), %rcx
	rolq	$12, %rcx
	movq	%rbp, %rdi
	rolq	$27, %rdi
	addq	-24(%rsi,%rdx), %rbp
	movq	%rbp, %rdx
	rolq	$57, %rdx
	addq	%r9, %rbp
	addq	%rbp, %rax
	rolq	$33, %rbp
	addq	%rbx, %rdi
	addq	%rdx, %rdi
	addq	%rcx, %rdi
	addq	%rbp, %rdi
	movabsq	$-7286425919675154353, %rcx # imm = 0x9AE16A3B2F90404F
	imulq	%rcx, %rdi
	addq	%r11, %rax
	imulq	%r8, %rax
	addq	%rdi, %rax
	movq	%rax, %rdx
	shrq	$47, %rdx
	xorq	%rax, %rdx
	imulq	%r8, %rdx
	addq	%r11, %rdx
	jmp	.LBB28_9
.LBB28_8:
	movabsq	$-5435081209227447693, %rax # imm = 0xB492B66FBE98F273
	imulq	(%rsi), %rax
	movq	8(%rsi), %r8
	movq	-8(%rsi,%rdx), %rdi
	movabsq	$-7286425919675154353, %rbp # imm = 0x9AE16A3B2F90404F
	imulq	%rdi, %rbp
	movabsq	$-4348849565147123417, %rbx # imm = 0xC3A5C85C97CB3127
	movq	%rax, %rcx
	subq	%r8, %rcx
	rolq	$21, %rcx
	imulq	-16(%rsi,%rdx), %rbx
	addq	%rbx, %rcx
	addq	%rdx, %rax
	subq	%rbp, %rax
	shrq	$30, %rbp
	movabsq	$-4737503975807385600, %rdx # imm = 0xBE41013C00000000
	imulq	%rdi, %rdx
	orq	%rbp, %rdx
	movabsq	$-3942382747735136937, %rsi # imm = 0xC949D7C7509E6557
	xorq	%r8, %rsi
	rolq	$44, %rsi
	addq	%rcx, %rdx
	addq	%rsi, %rax
	xorq	%rax, %rdx
	movabsq	$-7070675565921424023, %rcx # imm = 0x9DDFEA08EB382D69
	imulq	%rcx, %rdx
	movq	%rdx, %rsi
	shrq	$47, %rsi
	xorq	%rax, %rdx
	xorq	%rsi, %rdx
	imulq	%rcx, %rdx
.LBB28_9:
	movq	%rdx, %rax
	shrq	$47, %rax
	xorq	%rdx, %rax
	imulq	%rcx, %rax
	jmp	.LBB28_16
.LBB28_12:
	movabsq	$-5435081209227447693, %r12 # imm = 0xB492B66FBE98F273
	movabsq	$-7070675565921424023, %rbp # imm = 0x9DDFEA08EB382D69
	movq	-40(%rsi,%rdx), %rax
	movq	-16(%rsi,%rdx), %r8
	movq	-48(%rsi,%rdx), %r10
	leaq	(%r10,%rdx), %rcx
	movq	-24(%rsi,%rdx), %rdi
	xorq	%rdi, %rcx
	imulq	%rbp, %rcx
	movq	%rcx, %rbx
	shrq	$47, %rbx
	xorq	%rdi, %rcx
	xorq	%rbx, %rcx
	imulq	%rbp, %rcx
	movq	%rcx, %r9
	shrq	$47, %r9
	xorq	%rcx, %r9
	imulq	%rbp, %r9
	movq	-64(%rsi,%rdx), %rbx
	addq	%rdx, %rbx
	leaq	(%rax,%rbx), %rbp
	addq	%r9, %rbp
	rolq	$43, %rbp
	movq	-56(%rsi,%rdx), %rcx
	leaq	(%rbx,%rcx), %r14
	leaq	(%rcx,%r8), %rcx
	addq	%r10, %r14
	movq	%r14, %r10
	rolq	$20, %r10
	addq	%rbx, %r10
	addq	%rbp, %r10
	movq	-32(%rsi,%rdx), %rbp
	addq	%rcx, %rbp
	movq	-8(%rsi,%rdx), %r11
	addq	%r12, %rbp
	leaq	(%rax,%rbp), %r15
	addq	%r11, %r15
	rolq	$43, %r15
	addq	%rbp, %rdi
	addq	%r8, %rdi
	movq	%rdi, %rbx
	rolq	$20, %rbx
	addq	%rax, %r14
	addq	%r11, %rdi
	addq	%rbp, %rbx
	addq	%r15, %rbx
	imulq	%r12, %rax
	movq	(%rsi), %rbp
	movq	%rbp, -16(%rsp)         # 8-byte Spill
	addq	%rbp, %rax
	addq	$-1, %rdx
	andq	$-64, %rdx
	movl	$64, %ebp
	subq	%rdx, %rbp
	movq	%rbp, -8(%rsp)          # 8-byte Spill
	addq	$64, %rsi
	movabsq	$-5435081209227447693, %r15 # imm = 0xB492B66FBE98F273
	jmp	.LBB28_13
	.p2align	4, 0x90
.LBB28_14:                              #   in Loop: Header=BB28_13 Depth=1
	movq	(%rsi), %rbp
	movq	%rbp, -16(%rsp)         # 8-byte Spill
	addq	$64, %rdx
	movq	%rdx, -8(%rsp)          # 8-byte Spill
	addq	$64, %rsi
.LBB28_13:                              # =>This Inner Loop Header: Depth=1
	movq	%r9, %r11
	addq	%r14, %rax
	addq	%rcx, %rax
	movq	-56(%rsi), %r8
	addq	%r8, %rax
	rolq	$27, %rax
	movq	-48(%rsi), %rdx
	imulq	%r15, %rax
	addq	%r10, %rcx
	movq	-16(%rsi), %r13
	addq	%r13, %rcx
	rolq	$22, %rcx
	movq	%rcx, %r12
	imulq	%r15, %r12
	movq	%rax, %r9
	xorq	%rbx, %r9
	movq	-24(%rsi), %rbp
	addq	%rbp, %r14
	movq	%r14, %rcx
	addq	%r12, %rcx
	addq	%rdi, %r11
	rolq	$31, %r11
	movq	%r11, %rax
	imulq	%r15, %rax
	imulq	%r15, %r10
	addq	-16(%rsp), %r10         # 8-byte Folded Reload
	movq	-40(%rsi), %r11
	addq	%r10, %rdi
	addq	%r11, %rdi
	addq	%r9, %rdi
	rolq	$43, %rdi
	addq	%r10, %r8
	addq	%rdx, %r8
	movq	%r8, %r14
	rolq	$20, %r8
	addq	%r11, %r14
	addq	%r8, %r10
	addq	%rdi, %r10
	addq	%rax, %rbx
	addq	%rcx, %rdx
	movq	-8(%rsi), %r8
	addq	-32(%rsi), %rbx
	addq	%rbx, %rdx
	addq	%r8, %rdx
	rolq	$43, %rdx
	addq	%rbx, %rbp
	addq	%r13, %rbp
	movq	%rbp, %rdi
	rolq	$20, %rbp
	addq	%r8, %rdi
	addq	%rbp, %rbx
	addq	%rdx, %rbx
	movq	-8(%rsp), %rdx          # 8-byte Reload
	testq	%rdx, %rdx
	jne	.LBB28_14
# %bb.15:
	xorq	%rdi, %r14
	movabsq	$-7070675565921424023, %rbp # imm = 0x9DDFEA08EB382D69
	imulq	%rbp, %r14
	movq	%r14, %rdx
	shrq	$47, %rdx
	xorq	%rdi, %r14
	xorq	%rdx, %r14
	imulq	%rbp, %r14
	movq	%r14, %rsi
	shrq	$47, %rsi
	xorq	%r14, %rsi
	imulq	%rbp, %rsi
	movq	%rcx, %rdx
	shrq	$47, %rdx
	xorq	%rcx, %rdx
	movabsq	$-5435081209227447693, %rcx # imm = 0xB492B66FBE98F273
	imulq	%rcx, %rdx
	addq	%r9, %rdx
	addq	%rsi, %rdx
	xorq	%rbx, %r10
	imulq	%rbp, %r10
	movq	%r10, %rcx
	shrq	$47, %rcx
	xorq	%rbx, %r10
	xorq	%rcx, %r10
	imulq	%rbp, %r10
	movq	%r10, %rcx
	shrq	$47, %rcx
	xorq	%r10, %rcx
	imulq	%rbp, %rcx
	addq	%rax, %rcx
	xorq	%rcx, %rdx
	imulq	%rbp, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	xorq	%rcx, %rdx
	xorq	%rax, %rdx
	imulq	%rbp, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	xorq	%rdx, %rax
	imulq	%rbp, %rax
.LBB28_16:
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB28_4:
	cmpq	$4, %rdx
	jb	.LBB28_6
# %bb.5:
	movl	(%rsi), %ecx
	shll	$3, %ecx
	addq	%rdx, %rcx
	movl	-4(%rsi,%rdx), %eax
	xorq	%rax, %rcx
	movabsq	$-7070675565921424023, %rdx # imm = 0x9DDFEA08EB382D69
	imulq	%rdx, %rcx
	movq	%rcx, %rsi
	shrq	$47, %rsi
	xorq	%rax, %rcx
	xorq	%rsi, %rcx
	imulq	%rdx, %rcx
	movq	%rcx, %rax
	shrq	$47, %rax
	xorq	%rcx, %rax
	imulq	%rdx, %rax
	jmp	.LBB28_16
.LBB28_6:
	movabsq	$-7286425919675154353, %rax # imm = 0x9AE16A3B2F90404F
	testq	%rdx, %rdx
	je	.LBB28_16
# %bb.7:
	movq	%rdx, %rcx
	shrq	%rcx
	movzbl	(%rsi), %edi
	movzbl	(%rsi,%rcx), %ecx
	shlq	$8, %rcx
	orq	%rdi, %rcx
	movzbl	-1(%rsi,%rdx), %esi
	leal	(%rdx,%rsi,4), %edx
	imulq	%rax, %rcx
	movabsq	$-3942382747735136937, %rsi # imm = 0xC949D7C7509E6557
	imulq	%rdx, %rsi
	xorq	%rcx, %rsi
	movq	%rsi, %rcx
	shrq	$47, %rcx
	xorq	%rsi, %rcx
	imulq	%rcx, %rax
	jmp	.LBB28_16
.Lfunc_end28:
	.size	_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm, .Lfunc_end28-_ZNSt3__121__murmur2_or_cityhashImLm64EEclEPKvm
	.cfi_endproc
                                        # -- End function
	.section	.text._ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm,"axG",@progbits,_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm,comdat
	.weak	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm # -- Begin function _ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm
	.p2align	4, 0x90
	.type	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm,@function
_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm: # @_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm
.Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, DW.ref.__gxx_personality_v0
	.cfi_lsda 27, .Lexception4
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movq	%rdi, %r12
	testq	%r14, %r14
	je	.LBB29_6
# %bb.1:
	movq	%r14, %rax
	shrq	$61, %rax
	jne	.LBB29_61
# %bb.2:
	leaq	(,%r14,8), %rdi
	callq	_Znwm@PLT
	movq	(%r12), %rdi
	movq	%rax, (%r12)
	testq	%rdi, %rdi
	je	.LBB29_4
# %bb.3:
	callq	_ZdlPv@PLT
.LBB29_4:
	movq	%r14, 8(%r12)
	leaq	-1(%r14), %rdi
	movl	%r14d, %eax
	andl	$3, %eax
	cmpq	$3, %rdi
	jae	.LBB29_9
# %bb.5:
	xorl	%ecx, %ecx
	testq	%rax, %rax
	jne	.LBB29_12
	jmp	.LBB29_14
.LBB29_6:
	movq	(%r12), %rdi
	movq	$0, (%r12)
	testq	%rdi, %rdi
	je	.LBB29_8
# %bb.7:
	callq	_ZdlPv@PLT
.LBB29_8:
	movq	$0, 8(%r12)
	jmp	.LBB29_60
.LBB29_9:
	movq	%r14, %rdx
	subq	%rax, %rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB29_10:                              # =>This Inner Loop Header: Depth=1
	movq	(%r12), %rsi
	movq	$0, (%rsi,%rcx,8)
	movq	(%r12), %rsi
	movq	$0, 8(%rsi,%rcx,8)
	movq	(%r12), %rsi
	movq	$0, 16(%rsi,%rcx,8)
	movq	(%r12), %rsi
	movq	$0, 24(%rsi,%rcx,8)
	addq	$4, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB29_10
# %bb.11:
	testq	%rax, %rax
	je	.LBB29_14
.LBB29_12:
	negq	%rax
	.p2align	4, 0x90
.LBB29_13:                              # =>This Inner Loop Header: Depth=1
	movq	(%r12), %rdx
	movq	$0, (%rdx,%rcx,8)
	addq	$1, %rcx
	addq	$1, %rax
	jne	.LBB29_13
.LBB29_14:
	movq	16(%r12), %rsi
	testq	%rsi, %rsi
	je	.LBB29_60
# %bb.15:
	leaq	16(%r12), %rbp
	movq	8(%rsi), %rcx
	testq	%r14, %rdi
	je	.LBB29_18
# %bb.16:
	cmpq	%r14, %rcx
	jb	.LBB29_19
# %bb.17:
	xorl	%edx, %edx
	movq	%rcx, %rax
	divq	%r14
	movq	%rdx, %rcx
	jmp	.LBB29_19
.LBB29_18:
	andq	%rdi, %rcx
.LBB29_19:
	movq	(%r12), %rax
	movq	%rbp, (%rax,%rcx,8)
	movq	(%rsi), %rbp
	testq	%rbp, %rbp
	je	.LBB29_60
# %bb.20:
	movq	%r14, 16(%rsp)          # 8-byte Spill
	movq	%rdi, 8(%rsp)           # 8-byte Spill
	.p2align	4, 0x90
.LBB29_21:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB29_46 Depth 2
                                        #     Child Loop BB29_53 Depth 2
                                        #     Child Loop BB29_33 Depth 2
                                        #       Child Loop BB29_41 Depth 3
	movq	8(%rbp), %rbx
	testq	%r14, %rdi
	je	.LBB29_26
# %bb.22:                               #   in Loop: Header=BB29_21 Depth=1
	cmpq	%r14, %rbx
	jb	.LBB29_24
# %bb.23:                               #   in Loop: Header=BB29_21 Depth=1
	xorl	%edx, %edx
	movq	%rbx, %rax
	divq	%r14
	movq	%rdx, %rbx
.LBB29_24:                              #   in Loop: Header=BB29_21 Depth=1
	cmpq	%rcx, %rbx
	jne	.LBB29_27
.LBB29_25:                              #   in Loop: Header=BB29_21 Depth=1
	movq	%rbp, %rsi
	movq	(%rsi), %rbp
	testq	%rbp, %rbp
	jne	.LBB29_21
	jmp	.LBB29_60
	.p2align	4, 0x90
.LBB29_26:                              #   in Loop: Header=BB29_21 Depth=1
	andq	%rdi, %rbx
	cmpq	%rcx, %rbx
	je	.LBB29_25
.LBB29_27:                              #   in Loop: Header=BB29_21 Depth=1
	movq	(%r12), %rax
	cmpq	$0, (%rax,%rbx,8)
	je	.LBB29_44
# %bb.28:                               #   in Loop: Header=BB29_21 Depth=1
	movq	%rcx, 24(%rsp)          # 8-byte Spill
	movq	%rsi, 32(%rsp)          # 8-byte Spill
	movq	(%rbp), %rcx
	movq	%rbp, %r14
	testq	%rcx, %rcx
	je	.LBB29_58
# %bb.29:                               #   in Loop: Header=BB29_21 Depth=1
	movb	16(%rbp), %dl
	movl	%edx, %eax
	shrb	%al
	movzbl	%al, %eax
	movq	%rax, %r13
	testb	$1, %dl
	je	.LBB29_31
# %bb.30:                               #   in Loop: Header=BB29_21 Depth=1
	movq	24(%rbp), %r13
.LBB29_31:                              #   in Loop: Header=BB29_21 Depth=1
	jne	.LBB29_45
# %bb.32:                               #   in Loop: Header=BB29_21 Depth=1
	movq	%rbp, %rdi
.LBB29_33:                              #   Parent Loop BB29_21 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB29_41 Depth 3
	movq	%rcx, %r14
	movb	16(%r14), %dl
	testb	$1, %dl
	je	.LBB29_38
# %bb.34:                               #   in Loop: Header=BB29_33 Depth=2
	movq	24(%r14), %rsi
	cmpq	%rsi, %r13
	jne	.LBB29_57
.LBB29_35:                              #   in Loop: Header=BB29_33 Depth=2
	testq	%r13, %r13
	je	.LBB29_43
# %bb.36:                               #   in Loop: Header=BB29_33 Depth=2
	testb	$1, %dl
	je	.LBB29_39
# %bb.37:                               #   in Loop: Header=BB29_33 Depth=2
	movq	32(%r14), %rcx
	jmp	.LBB29_40
	.p2align	4, 0x90
.LBB29_38:                              #   in Loop: Header=BB29_33 Depth=2
	movl	%edx, %ecx
	shrb	%cl
	movzbl	%cl, %esi
	cmpq	%rsi, %r13
	je	.LBB29_35
	jmp	.LBB29_57
	.p2align	4, 0x90
.LBB29_39:                              #   in Loop: Header=BB29_33 Depth=2
	leaq	16(%r14), %rcx
	addq	$1, %rcx
.LBB29_40:                              #   in Loop: Header=BB29_33 Depth=2
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB29_41:                              #   Parent Loop BB29_21 Depth=1
                                        #     Parent Loop BB29_33 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzbl	17(%rbp,%rsi), %edx
	cmpb	(%rcx,%rsi), %dl
	jne	.LBB29_57
# %bb.42:                               #   in Loop: Header=BB29_41 Depth=3
	addq	$1, %rsi
	cmpq	%rsi, %rax
	jne	.LBB29_41
.LBB29_43:                              #   in Loop: Header=BB29_33 Depth=2
	movq	(%r14), %rcx
	movq	%r14, %rdi
	testq	%rcx, %rcx
	jne	.LBB29_33
	jmp	.LBB29_58
.LBB29_44:                              #   in Loop: Header=BB29_21 Depth=1
	movq	%rsi, (%rax,%rbx,8)
	movq	%rbp, %rsi
	movq	%rbx, %rcx
	movq	(%rsi), %rbp
	testq	%rbp, %rbp
	jne	.LBB29_21
	jmp	.LBB29_60
.LBB29_45:                              #   in Loop: Header=BB29_21 Depth=1
	movq	%rbp, %r14
	testq	%r13, %r13
	je	.LBB29_53
	.p2align	4, 0x90
.LBB29_46:                              #   Parent Loop BB29_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, %r15
	movzbl	16(%r15), %eax
	testb	$1, %al
	je	.LBB29_51
# %bb.47:                               #   in Loop: Header=BB29_46 Depth=2
	movq	24(%r15), %rcx
	cmpq	%rcx, %r13
	jne	.LBB29_58
.LBB29_48:                              #   in Loop: Header=BB29_46 Depth=2
	movq	32(%rbp), %rdi
	testb	$1, %al
	je	.LBB29_52
# %bb.49:                               #   in Loop: Header=BB29_46 Depth=2
	movq	32(%r15), %rsi
	movq	%r13, %rdx
	callq	memcmp@PLT
	testl	%eax, %eax
	je	.LBB29_50
	jmp	.LBB29_58
	.p2align	4, 0x90
.LBB29_51:                              #   in Loop: Header=BB29_46 Depth=2
	movl	%eax, %ecx
	shrb	%cl
	movzbl	%cl, %ecx
	cmpq	%rcx, %r13
	je	.LBB29_48
	jmp	.LBB29_58
	.p2align	4, 0x90
.LBB29_52:                              #   in Loop: Header=BB29_46 Depth=2
	leaq	16(%r15), %rsi
	addq	$1, %rsi
	movq	%r13, %rdx
	callq	memcmp@PLT
	testl	%eax, %eax
	jne	.LBB29_58
.LBB29_50:                              #   in Loop: Header=BB29_46 Depth=2
	movq	(%r15), %rcx
	movq	%r15, %r14
	testq	%rcx, %rcx
	jne	.LBB29_46
	jmp	.LBB29_58
	.p2align	4, 0x90
.LBB29_53:                              #   Parent Loop BB29_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rcx, %rax
	movzbl	16(%rax), %ecx
	testb	$1, %cl
	je	.LBB29_55
# %bb.54:                               #   in Loop: Header=BB29_53 Depth=2
	movq	24(%rax), %rcx
	testq	%rcx, %rcx
	je	.LBB29_56
	jmp	.LBB29_58
	.p2align	4, 0x90
.LBB29_55:                              #   in Loop: Header=BB29_53 Depth=2
	shrb	%cl
	movzbl	%cl, %ecx
	testq	%rcx, %rcx
	jne	.LBB29_58
.LBB29_56:                              #   in Loop: Header=BB29_53 Depth=2
	movq	(%rax), %rcx
	movq	%rax, %r14
	testq	%rcx, %rcx
	jne	.LBB29_53
	jmp	.LBB29_58
.LBB29_57:                              #   in Loop: Header=BB29_21 Depth=1
	movq	%rdi, %r14
.LBB29_58:                              #   in Loop: Header=BB29_21 Depth=1
	movq	(%r14), %rax
	movq	32(%rsp), %rsi          # 8-byte Reload
	movq	%rax, (%rsi)
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %rax
	movq	(%rax), %rax
	movq	%rax, (%r14)
	movq	(%r12), %rax
	movq	(%rax,%rbx,8), %rax
	movq	%rbp, (%rax)
	movq	16(%rsp), %r14          # 8-byte Reload
	movq	8(%rsp), %rdi           # 8-byte Reload
	movq	24(%rsp), %rcx          # 8-byte Reload
	movq	(%rsi), %rbp
	testq	%rbp, %rbp
	jne	.LBB29_21
.LBB29_60:
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB29_61:
	movl	$16, %edi
	callq	__cxa_allocate_exception@PLT
	movq	%rax, %rbx
.Ltmp69:
	leaq	.L.str.9(%rip), %rsi
	movq	%rbx, %rdi
	callq	_ZNSt11logic_errorC2EPKc@PLT
.Ltmp70:
# %bb.62:
	movq	_ZTVSt12length_error@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rax, (%rbx)
	movq	_ZTISt12length_error@GOTPCREL(%rip), %rsi
	movq	_ZNSt12length_errorD1Ev@GOTPCREL(%rip), %rdx
	movq	%rbx, %rdi
	callq	__cxa_throw@PLT
.LBB29_63:
.Ltmp71:
	movq	%rax, %r14
	movq	%rbx, %rdi
	callq	__cxa_free_exception@PLT
	movq	%r14, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end29:
	.size	_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm, .Lfunc_end29-_ZNSt3__112__hash_tableINS_17__hash_value_typeINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEtEENS_22__unordered_map_hasherIS7_S8_NS_4hashIS7_EELb1EEENS_21__unordered_map_equalIS7_S8_NS_8equal_toIS7_EELb1EEENS5_IS8_EEE8__rehashEm
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2
GCC_except_table29:
.Lexception4:
	.byte	255                     # @LPStart Encoding = omit
	.byte	155                     # @TType Encoding = indirect pcrel sdata4
	.byte	41                      # @TType base offset
	.byte	3                       # Call site Encoding = udata4
	.byte	39                      # Call site table length
	.long	.Lfunc_begin4-.Lfunc_begin4 # >> Call Site 1 <<
	.long	.Ltmp69-.Lfunc_begin4   #   Call between .Lfunc_begin4 and .Ltmp69
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.long	.Ltmp69-.Lfunc_begin4   # >> Call Site 2 <<
	.long	.Ltmp70-.Ltmp69         #   Call between .Ltmp69 and .Ltmp70
	.long	.Ltmp71-.Lfunc_begin4   #     jumps to .Ltmp71
	.byte	0                       #   On action: cleanup
	.long	.Ltmp70-.Lfunc_begin4   # >> Call Site 3 <<
	.long	.Lfunc_end29-.Ltmp70    #   Call between .Ltmp70 and .Lfunc_end29
	.long	0                       #     has no landing pad
	.byte	0                       #   On action: cleanup
	.p2align	2
                                        # -- End function
	.type	directives,@object      # @directives
	.data
	.globl	directives
	.p2align	4
directives:
	.asciz	"align\000\000"
	.asciz	"ascii\000\000"
	.asciz	"byte\000\000\000"
	.asciz	"comm\000\000\000"
	.asciz	"data\000\000\000"
	.asciz	"extern\000"
	.asciz	"globl\000\000"
	.asciz	"hword\000\000"
	.asciz	"space\000\000"
	.asciz	"text\000\000\000"
	.asciz	"word\000\000\000"
	.size	directives, 88

	.type	instr,@object           # @instr
	.globl	instr
	.p2align	4
instr:
	.asciz	"adc\000"
	.byte	0                       # 0x0
	.byte	1                       # 0x1
	.byte	0                       # 0x0
	.asciz	"add\000"
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.byte	0                       # 0x0
	.asciz	"adci"
	.byte	4                       # 0x4
	.byte	17                      # 0x11
	.byte	0                       # 0x0
	.asciz	"addi"
	.byte	4                       # 0x4
	.byte	16                      # 0x10
	.byte	0                       # 0x0
	.asciz	"and\000"
	.byte	0                       # 0x0
	.byte	5                       # 0x5
	.byte	0                       # 0x0
	.asciz	"andi"
	.byte	0                       # 0x0
	.byte	21                      # 0x15
	.byte	0                       # 0x0
	.asciz	"b\000\000\000"
	.byte	6                       # 0x6
	.byte	63                      # 0x3f
	.byte	0                       # 0x0
	.asciz	"bc\000\000"
	.byte	6                       # 0x6
	.byte	62                      # 0x3e
	.byte	0                       # 0x0
	.asciz	"beq\000"
	.byte	5                       # 0x5
	.byte	56                      # 0x38
	.byte	0                       # 0x0
	.asciz	"bg\000\000"
	.byte	5                       # 0x5
	.byte	60                      # 0x3c
	.byte	0                       # 0x0
	.asciz	"bge\000"
	.byte	5                       # 0x5
	.byte	61                      # 0x3d
	.byte	0                       # 0x0
	.asciz	"bgeu"
	.byte	5                       # 0x5
	.byte	59                      # 0x3b
	.byte	0                       # 0x0
	.asciz	"bgu\000"
	.byte	5                       # 0x5
	.byte	58                      # 0x3a
	.byte	0                       # 0x0
	.asciz	"bne\000"
	.byte	5                       # 0x5
	.byte	57                      # 0x39
	.byte	0                       # 0x0
	.asciz	"bx\000\000"
	.byte	3                       # 0x3
	.byte	63                      # 0x3f
	.byte	2                       # 0x2
	.asciz	"call"
	.byte	5                       # 0x5
	.byte	63                      # 0x3f
	.byte	1                       # 0x1
	.asciz	"lb\000\000"
	.byte	7                       # 0x7
	.byte	34                      # 0x22
	.byte	0                       # 0x0
	.asciz	"lbu\000"
	.byte	7                       # 0x7
	.byte	36                      # 0x24
	.byte	0                       # 0x0
	.asciz	"lh\000\000"
	.byte	7                       # 0x7
	.byte	33                      # 0x21
	.byte	0                       # 0x0
	.asciz	"lhu\000"
	.byte	7                       # 0x7
	.byte	35                      # 0x23
	.byte	0                       # 0x0
	.asciz	"lw\000\000"
	.byte	7                       # 0x7
	.byte	32                      # 0x20
	.byte	0                       # 0x0
	.asciz	"mul\000"
	.byte	0                       # 0x0
	.byte	9                       # 0x9
	.byte	0                       # 0x0
	.asciz	"muli"
	.byte	4                       # 0x4
	.byte	25                      # 0x19
	.byte	0                       # 0x0
	.asciz	"or\000\000"
	.byte	0                       # 0x0
	.byte	4                       # 0x4
	.byte	0                       # 0x0
	.asciz	"ori\000"
	.byte	0                       # 0x0
	.byte	20                      # 0x14
	.byte	0                       # 0x0
	.asciz	"sar\000"
	.byte	0                       # 0x0
	.byte	8                       # 0x8
	.byte	128                     # 0x80
	.asciz	"sari"
	.byte	4                       # 0x4
	.byte	24                      # 0x18
	.byte	128                     # 0x80
	.asciz	"sb\000\000"
	.byte	8                       # 0x8
	.byte	54                      # 0x36
	.byte	0                       # 0x0
	.asciz	"sbb\000"
	.byte	0                       # 0x0
	.byte	3                       # 0x3
	.byte	0                       # 0x0
	.asciz	"sbbi"
	.byte	4                       # 0x4
	.byte	19                      # 0x13
	.byte	0                       # 0x0
	.asciz	"seb\000"
	.byte	2                       # 0x2
	.byte	7                       # 0x7
	.byte	0                       # 0x0
	.asciz	"seh\000"
	.byte	2                       # 0x2
	.byte	7                       # 0x7
	.byte	1                       # 0x1
	.asciz	"sh\000\000"
	.byte	8                       # 0x8
	.byte	53                      # 0x35
	.byte	0                       # 0x0
	.asciz	"shl\000"
	.byte	0                       # 0x0
	.byte	8                       # 0x8
	.byte	0                       # 0x0
	.asciz	"shli"
	.byte	4                       # 0x4
	.byte	24                      # 0x18
	.byte	0                       # 0x0
	.asciz	"shr\000"
	.byte	0                       # 0x0
	.byte	8                       # 0x8
	.byte	64                      # 0x40
	.asciz	"shri"
	.byte	4                       # 0x4
	.byte	24                      # 0x18
	.byte	64                      # 0x40
	.asciz	"sub\000"
	.byte	0                       # 0x0
	.byte	2                       # 0x2
	.byte	0                       # 0x0
	.asciz	"subi"
	.byte	4                       # 0x4
	.byte	18                      # 0x12
	.byte	0                       # 0x0
	.asciz	"seti"
	.byte	6                       # 0x6
	.byte	42                      # 0x2a
	.byte	0                       # 0x0
	.asciz	"sw\000\000"
	.byte	8                       # 0x8
	.byte	52                      # 0x34
	.byte	0                       # 0x0
	.asciz	"xor\000"
	.byte	0                       # 0x0
	.byte	6                       # 0x6
	.byte	0                       # 0x0
	.asciz	"xori"
	.byte	4                       # 0x4
	.byte	22                      # 0x16
	.byte	0                       # 0x0
	.size	instr, 344

	.type	.L.str.1,@object        # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"Error no input file specified\nUsage: %s <inputfile>\n"
	.size	.L.str.1, 53

	.type	.L.str.2,@object        # @.str.2
.L.str.2:
	.asciz	"Error input file could not be opened\n"
	.size	.L.str.2, 38

	.type	.L.str.3,@object        # @.str.3
.L.str.3:
	.asciz	"Error max line length execeeded at line %d\n"
	.size	.L.str.3, 44

	.type	.L.str.4,@object        # @.str.4
.L.str.4:
	.asciz	"line %d : label %.*s found\n"
	.size	.L.str.4, 28

	.type	.L.str.5,@object        # @.str.5
.L.str.5:
	.asciz	"line %d : directive %d found\n"
	.size	.L.str.5, 30

	.type	.L.str.6,@object        # @.str.6
.L.str.6:
	.asciz	"line %d : instruction %s found of type : %d\n"
	.size	.L.str.6, 45

	.type	.L.str.7,@object        # @.str.7
.L.str.7:
	.asciz	"Error invalid instruction %s at line %d\n"
	.size	.L.str.7, 41

	.type	.L.str.8,@object        # @.str.8
.L.str.8:
	.asciz	"%08X\n"
	.size	.L.str.8, 6

	.type	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,@object # @_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.section	.data.rel.ro._ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,"aGw",@progbits,_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,comdat
	.weak	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.p2align	3
_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE:
	.quad	184
	.quad	0
	.quad	_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.quad	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.quad	_ZNSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.quad	-184
	.quad	-184
	.quad	_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.quad	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED1Ev
	.quad	_ZTv0_n24_NSt3__114basic_ifstreamIcNS_11char_traitsIcEEED0Ev
	.size	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE, 80

	.type	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,@object # @_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.section	.data.rel.ro._ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,"aGw",@progbits,_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,comdat
	.weak	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.p2align	4
_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE:
	.quad	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+24
	.quad	_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE+24
	.quad	_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE+64
	.quad	_ZTVNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE+64
	.size	_ZTTNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE, 32

	.type	_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE,@object # @_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE
	.section	.data.rel.ro._ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE,"aGw",@progbits,_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE,comdat
	.weak	_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE
	.p2align	4
_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE:
	.quad	184
	.quad	0
	.quad	_ZTINSt3__113basic_istreamIcNS_11char_traitsIcEEEE
	.quad	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED1Ev
	.quad	_ZNSt3__113basic_istreamIcNS_11char_traitsIcEEED0Ev
	.quad	-184
	.quad	-184
	.quad	_ZTINSt3__113basic_istreamIcNS_11char_traitsIcEEEE
	.quad	_ZTv0_n24_NSt3__113basic_istreamIcNS_11char_traitsIcEEED1Ev
	.quad	_ZTv0_n24_NSt3__113basic_istreamIcNS_11char_traitsIcEEED0Ev
	.size	_ZTCNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE0_NS_13basic_istreamIcS2_EE, 80

	.type	_ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,@object # @_ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.section	.rodata._ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,"aG",@progbits,_ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,comdat
	.weak	_ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.p2align	4
_ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE:
	.asciz	"NSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE"
	.size	_ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE, 48

	.type	_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,@object # @_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.section	.data.rel.ro._ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,"aGw",@progbits,_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE,comdat
	.weak	_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.p2align	4
_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTSNSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE
	.quad	_ZTINSt3__113basic_istreamIcNS_11char_traitsIcEEEE
	.size	_ZTINSt3__114basic_ifstreamIcNS_11char_traitsIcEEEE, 24

	.type	_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE,@object # @_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.section	.data.rel.ro._ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE,"aGw",@progbits,_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE,comdat
	.weak	_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.p2align	3
_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE:
	.quad	0
	.quad	_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv
	.quad	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE9showmanycEv
	.quad	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE6xsgetnEPcl
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv
	.quad	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5uflowEv
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi
	.quad	_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE6xsputnEPKcl
	.quad	_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi
	.size	_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE, 128

	.type	_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE,@object # @_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.section	.rodata._ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE,"aG",@progbits,_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE,comdat
	.weak	_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.p2align	4
_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE:
	.asciz	"NSt3__113basic_filebufIcNS_11char_traitsIcEEEE"
	.size	_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE, 47

	.type	_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE,@object # @_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.section	.data.rel.ro._ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE,"aGw",@progbits,_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE,comdat
	.weak	_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.p2align	4
_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE
	.quad	_ZTINSt3__115basic_streambufIcNS_11char_traitsIcEEEE
	.size	_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE, 24

	.type	.L.str.9,@object        # @.str.9
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.9:
	.asciz	"allocator<T>::allocate(size_t n) 'n' exceeds maximum supported size"
	.size	.L.str.9, 68

	.type	.L.str.12,@object       # @.str.12
.L.str.12:
	.asciz	"r"
	.size	.L.str.12, 2

	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.DW.ref.__gxx_personality_v0,"aGw",@progbits,DW.ref.__gxx_personality_v0,comdat
	.p2align	3
	.type	DW.ref.__gxx_personality_v0,@object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0

	.ident	"clang version 6.0.0 (tags/RELEASE_600/final)"
	.section	".note.GNU-stack","",@progbits
