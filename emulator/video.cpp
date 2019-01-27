// Copyright(c) 2018 <Cees Wolfs>
#include "video.h"

Video::Video() {}
Video::~Video() {}

namespace vidHelpers {
inline uint32_t getBits(uint32_t val, const uint8_t upperbit,
                        const uint8_t lowerbit) {
  return (val >> lowerbit) & ((1 << ((upperbit + 1) - lowerbit)) - 1);
}

inline bool getBit(uint32_t val, const uint8_t bit) { return val >> bit & 0x1; }
}  // namespace vidHelpers

static const uint32_t getColour(uint8_t colour) {
  switch (colour & 0xf) {
    case 0:
      return 0x000000;
    case 1:
      return 0x0b0a0d;
    case 2:
      return 0x161524;
    case 3:
      return 0x222640;
    case 4:
      return 0x2b4057;
    case 5:
      return 0x306566;
    case 6:
      return 0x34a870;
    case 7:
      return 0x49f25a;
    case 8:
      return 0xa4ff63;
    case 9:
      return 0xfff240;
    case 10:
      return 0xf2a53f;
    case 11:
      return 0xcc7a47;
    case 12:
      return 0xf54025;
    case 13:
      return 0xa63a3a;
    case 14:
      return 0x995348;
    case 15:
      return 0xffffff;
    case 16:
      return 0x4d2a49;
    case 17:
      return 0x46346a;
    case 18:
      return 0x8c2eb8;
    case 19:
      return 0xf261da;
    case 20:
      return 0xffa8d4;
    case 21:
      return 0xb3dfff;
    case 22:
      return 0x70a5fa;
    case 23:
      return 0x407cff;
    case 24:
      return 0x1f50cc;
    case 25:
      return 0x213ea6;
    case 26:
      return 0x272f66;
    case 27:
      return 0x414558;
    case 28:
      return 0x6d7078;
    case 29:
      return 0x898b8c;
    case 30:
      return 0xbbbdbf;
    case 31:
      return 0x733758;
  }
  return 0x0000000;
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
  for (size_t i = 0; i < CEESPU_SCREEN_WIDTH * CEESPU_SCREEN_HEIGHT; i++) {
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
  uint8_t pallete = (ascii & 0x80) >> 3;

  uint32_t bg_colour = getColour(pallete + (colour_data >> 4));
  uint32_t fg_colour = getColour(pallete + (colour_data & 0xf));

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
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 6, y * 16 + i)] =
        (pixeldata & 64) ? fg_colour : bg_colour;
    this->framebuffer[TEXTURE_PIXEL(x * 8 + 7, y * 16 + i)] =
        (pixeldata & 128) ? fg_colour : bg_colour;
  }
  this->drawOccured = true;
}

void Video::drawSprites(const Ceespu& cpu) {
  for (int i = 31; i >= 0; i--) {
    uint32_t sprite = cpu.getWord(CEESPU_SPRITE_OFFSET + 4 * i);
    uint16_t sprite_y = vidHelpers::getBits(sprite, 8, 0);
    uint16_t sprite_x = vidHelpers::getBits(sprite, 18, 9);
    uint8_t sprite_offset = vidHelpers::getBits(sprite, 28, 24);
    uint8_t sprite_pallete = vidHelpers::getBits(sprite, 23, 20);
    bool size = vidHelpers::getBit(sprite, 19);
    int h = size ? 32 : 16;
    for (int row = 0; row < h; row++) {
      uint8_t sprites_on_line = 0;
      int16_t y = sprite_y + row;
      for (int other = i; other >= 0; other--) {
        uint32_t other_sprite = cpu.getWord(CEESPU_SPRITE_OFFSET + 4 * other);
        int16_t other_y = vidHelpers::getBits(other_sprite, 8, 0);
        bool other_size = vidHelpers::getBit(sprite, 19);
        int other_h = other_size ? 32 : 16;
        if (y - other_y >= 0 && y - other_y < other_h) {
          // lower priority sprite drawn on same scanline
          sprites_on_line++;
          if (sprites_on_line >= 8) {
            // more than 8 sprites lines on scanline skip
            goto next_row;
          }
        }
      }
      // draw current scanline
      for (int x = 0; x < h; x++) {
        uint8_t pixel =
            cpu.getByte(CEESPU_SPRITE_TEXTURE_OFFSET + (sprite_offset << 3) +
                        (x / 4) + ((x % 4) & 0x3));
        if (pixel != 0) {
          this->framebuffer[TEXTURE_PIXEL(sprite_x + x, y)] = cpu.getWord(
              CEESPU_SPRITE_PALLETE_OFFSET + (sprite_pallete << 2) + pixel);
        }
      }
    next_row:
      continue;
    }
  }
}

void Video::update(const Ceespu& cpu) {
  if (this->spritesChanged) {
    this->drawSprites(cpu);
    this->drawOccured = true;
    this->spritesChanged = false;
  }
  if (this->drawOccured) {
    SDL_UpdateTexture(texture, NULL, this->framebuffer,
                      CEESPU_SCREEN_WIDTH * sizeof(uint32_t));
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, NULL, NULL);
    SDL_RenderPresent(renderer);
    // SDL_Delay(1);
    this->drawOccured = false;
  }
}