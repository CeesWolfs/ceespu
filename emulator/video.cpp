// Copyright(c) 2018 <Cees Wolfs>
#include "video.h"

Video::Video() {}
Video::~Video() {}

static uint32_t getColour(uint8_t colour) {
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
  memset(this->framebuffer, getColour(2), 640 * 480 * sizeof(uint32_t));
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
  memset(this->framebuffer, 0, CEESPU_SCREEN_WIDTH * CEESPU_SCREEN_HEIGHT);
  SDL_UpdateTexture(texture, NULL, this->framebuffer, CEESPU_SCREEN_WIDTH);
  /* Render the texture. */
  SDL_RenderClear(renderer);
  SDL_RenderCopy(renderer, texture, NULL, NULL);
  SDL_RenderPresent(renderer);
}

void Video::drawChar(const Ceespu& cpu, uint8_t x, uint8_t y) {
  uint8_t colour_data = cpu.getByte(CEESPU_COLOUR_MEMORY_OFFSET + y * 80 + x);
  uint8_t ascii = cpu.getByte(CEESPU_TEXT_MEMORY_OFFSET + y * 80 + x);
  uint32_t bg_colour = getColour(colour_data >> 4);
  uint32_t fg_colour = getColour(colour_data & 0xf);

  for (int i = 0; i < 16; ++i) {
    uint8_t pixeldata = cpu.getByte(CEESPU_FONT_MEMORY_OFFSET + ascii * 16 + i);
    this->framebuffer[y * 16 + i][x * 8] =
        (pixeldata & 1) ? fg_colour : bg_colour;
    this->framebuffer[y * 16 + i][x * 8 + 1] =
        (pixeldata & 2) ? fg_colour : bg_colour;
    this->framebuffer[y * 16 + i][x * 8 + 2] =
        (pixeldata & 4) ? fg_colour : bg_colour;
    this->framebuffer[y * 16 + i][x * 8 + 3] =
        (pixeldata & 8) ? fg_colour : bg_colour;
    this->framebuffer[y * 16 + i][x * 8 + 4] =
        (pixeldata & 16) ? fg_colour : bg_colour;
    this->framebuffer[y * 16 + i][x * 8 + 5] =
        (pixeldata & 32) ? fg_colour : bg_colour;
    this->framebuffer[y * 16 + i][x * 8 + 6] =
        (pixeldata & 64) ? fg_colour : bg_colour;
    this->framebuffer[y * 16 + i][x * 8 + 7] =
        (pixeldata & 128) ? fg_colour : bg_colour;
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
