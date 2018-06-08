/*
Copyright (c) 2016 Cees Wolfs

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
*/

#include "stdio.h"
#include "stdlib.h"
#include "ceespu.h"
#include "video.h"

Ceespu::Ceespu() {}

Ceespu::~Ceespu() {}

void Ceespu::init(Video *screen)
{
	memset(this->memory, 0, 65536);
	memcpy(this->memory + CEESPU_FONT_MEMORY_OFFSET / 4, font, 2048);
	for (int i = 0; i < 4096; i += 2) {
		this->memory[(CEESPU_SCREEN_MEMORY_OFFSET + i) >> 2].hword[(CEESPU_SCREEN_MEMORY_OFFSET + i) & 2] = 0xff00;
	}
	this->pc = 0;
	this->carry = false;
	this->enable_interrupt = true;
	this->immidiate_valid = false;
	this->interrupt = false;
	for (size_t i = 0; i < 31; i++)
	{
		Regs[i] = 0;
	}
	this->screen = screen;
}

void Ceespu::emulate_cycle()
{
	uint64_t curtime;
	if (this->interrupt & this->enable_interrupt) {
		this->Regs[17] = this->pc + 4;
		this->pc = this->int_vector;
		this->enable_interrupt = false;
		this->interrupt = false;
	}
	else {
		uint8_t  rd, ra, rb, opcode;
		int32_t  immidiate;
		uint32_t instruction = this->memory[this->pc / 4].word;
		uint64_t result;
		this->pc += 4;
		immidiate = this->immidiate_valid ? (this->immidiate_reg << 16) | (instruction & 0xffff) : static_cast<int16_t>(instruction);
		this->immidiate_valid = false;
		opcode = (instruction >> 26) & 0x3f;
		rd = (instruction >> 21) & 0x1f;
		ra = (instruction >> 16) & 0x1f;
		rb = (instruction >> 11) & 0x1f;
		switch (opcode)
		{
		case 0:
			result = Regs[ra] + Regs[rb];
			this->carry = result < Regs[ra];
			Regs[rd] = result;
			break;
		case 1:
			result = Regs[ra] + Regs[rb] + this->carry;
			this->carry = result < Regs[ra];
			Regs[rd] = result;
		case 2:
			result = Regs[rb] - Regs[ra];
			this->carry = result > Regs[ra];
			Regs[rd] = result;
		case 3:
			result = Regs[rb] - Regs[ra] - this->carry;
			this->carry = result > Regs[ra];
			Regs[rd] = result;
			break;
		case 4:
			Regs[rd] = Regs[ra] | Regs[rb]; 
			break;
		case 5:
			Regs[rd] = Regs[ra] & Regs[rb];
			break;
		case 6:
			Regs[rd] = Regs[ra] ^ Regs[rb];
			break;
		case 7:
			Regs[rd] = (immidiate & 1) ? static_cast<int16_t>(Regs[ra]) : static_cast<int8_t>(Regs[ra]);
			break;
		case 8:
			switch (immidiate & 0xC000)
			{
			case 0: Regs[rd] = Regs[ra] << Regs[rb]; break;
			case 0x4000: Regs[rd] = Regs[ra] >> Regs[rb]; break;
			case 0x8000: Regs[rd] = static_cast<int32_t>(Regs[ra]) >> Regs[rb]; break;
			default: MessageBoxA(0, "Error in shift code", "Malformed instruction", 0);  break;
			}
			break;
		case 9:
			Regs[rd] = Regs[ra] * Regs[rb];
			break;
		case 16:
			result = Regs[ra] + immidiate;
			this->carry = result < Regs[ra];
			Regs[rd] = result;
			break;
		case 17:
			result = Regs[ra] + immidiate + this->carry;
			this->carry = result < Regs[ra];
			Regs[rd] = result;
		case 18:
			result = immidiate - Regs[ra];
			this->carry = result > immidiate;
			Regs[rd] = result;
		case 19:
			result = immidiate - Regs[ra] - this->carry;
			this->carry = result > immidiate;
			Regs[rd] = result;
			break;
		case 20:
			Regs[rd] = Regs[ra] | immidiate;
			break;
		case 21:
			Regs[rd] = Regs[ra] & immidiate;
			break;
		case 22:
			Regs[rd] = Regs[ra] ^ immidiate;
			break;
		case 24:
			switch (immidiate & 0xC000)
			{
			case 0: Regs[rd] = Regs[ra] << (immidiate & 31); break;
			case 0x4000: Regs[rd] = Regs[ra] >> (immidiate & 31); break;
			case 0x8000: Regs[rd] = static_cast<int32_t>(Regs[ra]) >> (immidiate & 31); break;
			default: MessageBoxA(0, "Error in shift code", "Malformed instruction", 0);  break;
			}
			break;
		case 25:
			Regs[rd] = Regs[ra] * immidiate;
			break;
		case 32:
			Regs[rd] = getWord(Regs[ra] + immidiate);
			break;
		case 33:
			Regs[rd] = static_cast<int32_t>(getHalfword(Regs[ra] + immidiate));
			break;
		case 34:
			Regs[rd] = static_cast<int32_t>(getByte(Regs[ra] + immidiate));
			break;
		case 35:
			Regs[rd] = getHalfword(Regs[ra] + immidiate);
			break;
		case 36:
			Regs[rd] = getByte(Regs[ra] + immidiate);
			break;
		case 42:
			this->immidiate_reg = (instruction & 0xffff);
			this->immidiate_valid = true;
			break;
		case 43:
			this->enable_interrupt = (instruction & 1);
			break;
		case 52:
			storeWord(Regs[ra] + immidiate, Regs[rd]);
			break;
		case 53:
			storeHalfword(Regs[ra] + immidiate, Regs[rd]);
			break;
		case 54:
			storeByte(Regs[ra] + immidiate, Regs[rd]);
			break;
		case 56:
			this->pc = (Regs[ra] == Regs[rd]) ? (static_cast<uint16_t>(immidiate)) : this->pc;
			break;
		case 57:
			this->pc = (Regs[ra] != Regs[rd]) ? (static_cast<uint16_t>(immidiate)) : this->pc;
			break;
		case 58:
			this->pc = (Regs[ra] > Regs[rd]) ? (static_cast<uint16_t>(immidiate)) : this->pc;
			break;
		case 59:
			this->pc = (Regs[ra] >= Regs[rd]) ? (static_cast<uint16_t>(immidiate)) : this->pc;
			break;
		case 60:
			this->pc = (static_cast<int32_t>(Regs[ra]) > static_cast<int32_t>(Regs[rd])) ? (static_cast<uint16_t>(immidiate)) : this->pc;
			break;
		case 61:
			this->pc = (static_cast<int32_t>(Regs[ra]) >= static_cast<int32_t>(Regs[rd])) ? (static_cast<uint16_t>(immidiate)) : this->pc;
			break;
		case 62:
			this->pc = (this->carry) ? (static_cast<uint16_t>(immidiate)) : this->pc;
			break;
		case 63:
			Regs[19] = (immidiate & 1) ? (this->pc + 4) : Regs[19];
			this->pc = (immidiate & 2) ? static_cast<uint16_t>(Regs[ra]) : static_cast<uint16_t>(immidiate);
			if (immidiate & 2 && ra == 17)
				this->enable_interrupt = true;
			break;
		default:
			MessageBoxA(0, "Error wrong opcode", "Error malformed instruction", 0);
			exit(-1);
			break;
		}
	}
}

bool Ceespu::load(const char * file_path)
{
	FILE * rom = fopen(file_path, "rb");
	if (rom == NULL) {
		std::puts("Failed to open ROM");
		return false;
	}
	fseek(rom, 0, SEEK_END);
	long rom_size = ftell(rom);
	rewind(rom);
	fread(this->memory, sizeof(char), (size_t)rom_size, rom);
	fclose(rom);
	return true;
}

void Ceespu::timer_interrupt()
{
	this->interrupt = true;
	this->int_vector = 8;
}

uint32_t Ceespu::getWord(uint16_t location)
{
	return this->memory[location >> 2].word;
}

uint16_t Ceespu::getHalfword(uint16_t location)
{
	return this->memory[location >> 2].hword[location & 2];
}

uint8_t Ceespu::getByte(uint16_t location)
{
	return this->memory[location >> 2].byte[location & 3];
}

void Ceespu::storeWord(uint16_t location, uint32_t data)
{
	this->memory[location >> 2].word = data;
}

void Ceespu::storeHalfword(uint16_t location, uint16_t data)
{
	this->memory[location >> 2].hword[location & 2] = data;
	if (location >= CEESPU_COLOUR_MEMORY_OFFSET)
		this->screen->drawChar(*this, data & 0xff, data >> 8, (location - CEESPU_SCREEN_MEMORY_OFFSET) % 80, (location - CEESPU_SCREEN_MEMORY_OFFSET) / 80);
}

void Ceespu::storeByte(uint16_t location, uint8_t data)
{
	this->memory[location >> 2].byte[location & 3] = data;
	if (location >= CEESPU_SCREEN_MEMORY_OFFSET && location <= (CEESPU_SCREEN_MEMORY_OFFSET + 4096))

	if (location == 65528)
		std::putc(data, stdout);
}

int main(int argc, char ** argv)
{
	if (argc != 2) {
		std::puts("Usage: ceespu <ROM file>");
		return 1;
	}
	uint64_t timer_time;
	uint64_t fps_time;
	SDL_Event event;
	Ceespu cpu = Ceespu();
	Video screen = Video();
#ifdef _WIN32
	QueryUnbiasedInterruptTime(&timer_time);
	fps_time = timer_time;
	cpu.init(&screen);
	screen.init();
	cpu.load(argv[1]);
	for (;;)
	{
		uint64_t curtime;
		cpu.emulate_cycle();
		QueryUnbiasedInterruptTime(&curtime);
		if (SDL_PollEvent(&event)) {
			switch (event.type)
			{
			case SDL_QUIT:
				exit(0);
			default:
				break;
			}
		}
		if ((curtime - timer_time) > 10000) {
			timer_time = curtime;
			cpu.timer_interrupt();
		}
		if ((curtime - fps_time) >  200000) {
			fps_time = curtime;
			screen.update();
		}
	}
#endif
}