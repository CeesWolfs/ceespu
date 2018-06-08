#include "Video.h"

Video::Video() {};
Video::~Video() {};

void Video::init() {
	this->drawOccured = false;
	SDL_Init(SDL_INIT_EVERYTHING);
	this->window = SDL_CreateWindow("Ceespu Emulator",
            SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
            CEESPU_SCREEN_WIDTH, CEESPU_SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
	this->renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
	this->texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB332,
            SDL_TEXTUREACCESS_STATIC, CEESPU_SCREEN_WIDTH, CEESPU_SCREEN_HEIGHT);
	this->reset();
}

void Video::reset() {
	memset(this->framebuffer, 0, CEESPU_SCREEN_WIDTH * CEESPU_SCREEN_HEIGHT);
	SDL_UpdateTexture(texture, NULL, this->framebuffer, CEESPU_SCREEN_WIDTH);
    /* Render the texture. */
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, NULL, NULL);
    SDL_RenderPresent(renderer);
	
}

void Video::drawChar(Ceespu &cpu, uint8_t value, uint8_t fg_colour, uint8_t bg_colour ,uint8_t x, uint8_t y)  {
	for (int i = 0; i < 16; ++i)
	{
		unsigned char pixeldata = cpu.getByte(CEESPU_FONT_MEMORY_OFFSET + (value * 16) + i);
		this->framebuffer[y * 16 + i][x * 8] = (pixeldata & 1) ? fg_colour : bg_colour;
		this->framebuffer[y * 16 + i][x * 8 + 1] = (pixeldata & 2) ? fg_colour : bg_colour;
		this->framebuffer[y * 16 + i][x * 8 + 2] = (pixeldata & 4) ? fg_colour : bg_colour;
		this->framebuffer[y * 16 + i][x * 8 + 3] = (pixeldata & 8) ? fg_colour : bg_colour;
		this->framebuffer[y * 16 + i][x * 8 + 4] = (pixeldata & 16) ? fg_colour : bg_colour;
		this->framebuffer[y * 16 + i][x * 8 + 5] = (pixeldata & 32) ? fg_colour : bg_colour;
		this->framebuffer[y * 16 + i][x * 8 + 6] = (pixeldata & 64) ? fg_colour : bg_colour;
		this->framebuffer[y * 16 + i][x * 8 + 7] = (pixeldata & 128) ? fg_colour : bg_colour;
	}
	this->drawOccured = true;
}

void Video::update() {
	if (this->drawOccured) {
		SDL_UpdateTexture(texture, NULL, this->framebuffer, CEESPU_SCREEN_WIDTH);
		SDL_RenderClear(renderer);
		SDL_RenderCopy(renderer, texture, NULL, NULL);
		SDL_RenderPresent(renderer);
		SDL_Delay(1);
		this->drawOccured = false;
	}
}