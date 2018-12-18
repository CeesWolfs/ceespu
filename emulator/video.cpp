// Copyright(c) 2018 <Cees Wolfs>
#include "video.h"

Video::Video() {}
Video::~Video() {}

static const uint32_t getColour(uint8_t colour) {
  switch (colour & 0xf) {
    case 0:
      return 0x140c1c;
    case 1:
      return 0x442434;
    case 2:
      return 0x30346d;
    case 3:
      return 0x4e4a4e;
    case 4:
      return 0x854c30;
    case 5:
      return 0x346524;
    case 6:
      return 0xd04648;
    case 7:
      return 0x757161;
    case 8:
      return 0x597dce;
    case 9:
      return 0xd27d2c;
    case 10:
      return 0x8595a1;
    case 11:
      return 0x6daa2c;
    case 12:
      return 0xd2aa99;
    case 13:
      return 0x6dc2ca;
    case 14:
      return 0xdad45e;
    case 15:
      return 0xdeeed6;
  }
}

void Video::init() {
  this->drawOccured = false;
  SDL_Init(SDL_INIT_EVERYTHING);
  this->window = SDL_CreateWindow("Ceespu Emulator", SDL_WINDOWPOS_CENTERED,
                                  SDL_WINDOWPOS_CENTERED, CEESPU_SCREEN_WIDTH,
                                  CEESPU_SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
  this->renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
  this->texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB888,
                                    SDL_TEXTUREACCESS_STATIC,
                                    CEESPU_SCREEN_WIDTH, CEESPU_SCREEN_HEIGHT);
  this->reset();
}

void Video::reset() {
  for (size_t i = 0; i < CEESPU_SCREEN_WIDTH * CEESPU_SCREEN_HEIGHT; i++)
  {
	  this->framebuffer[i] = getColour(0);
  }
  SDL_UpdateTexture(texture, NULL, this->framebuffer, CEESPU_SCREEN_WIDTH);
  /* Render the texture. */
  SDL_RenderClear(renderer);
  SDL_RenderCopy(renderer, texture, NULL, NULL);
  SDL_RenderPresent(renderer);
}

void Video::drawChar(const Ceespu& cpu, uint8_t x, uint8_t y) {
  uint8_t colour_data = cpu.getByte(CEESPU_VRAM_OFFSET + y * 160 + x * 2 + 1);
  uint8_t ascii = cpu.getByte(CEESPU_VRAM_OFFSET + y * 160 + x * 2);

  uint32_t bg_colour = getColour(colour_data >> 4);
  uint32_t fg_colour = getColour(colour_data & 0xf);

  for (int i = 0; i < 16; ++i) {
    uint8_t pixeldata = cpu.getByte(CEESPU_FONT_MEMORY_OFFSET + ascii * 16 + i);
    this->framebuffer[TEXTURE_PIXEL(x * 8, y * 16 + i)] =
        (pixeldata & 1) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 1, y * 16 + i)] =
        (pixeldata & 2) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 2, y * 16 + i)] =
        (pixeldata & 4) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 3, y * 16 + i)] =
        (pixeldata & 8) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 4, y * 16 + i)] =
        (pixeldata & 16) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 5, y * 16 + i)] =
        (pixeldata & 32) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x*8 + 6, y*16 + i)] =
        (pixeldata & 64) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 7, y * 16 + i)] =
        (pixeldata & 128) ? fg_colour : bg_colour;

  }
  this->drawOccured = true;
}

void Video::update() {
  if (this->drawOccured) {
    SDL_UpdateTexture(texture, NULL, this->framebuffer, CEESPU_SCREEN_WIDTH*sizeof(uint32_t));
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, NULL, NULL);
    SDL_RenderPresent(renderer);
    //SDL_Delay(1);
    this->drawOccured = false;
  }
}
