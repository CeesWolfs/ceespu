#ifndef EMULATOR_VIDEO_H
#define EMULATOR_VIDEO_H

#include "include/SDL.h"
#include "ceespu.h"

#define CEESPU_SCREEN_WIDTH 640
#define CEESPU_SCREEN_HEIGHT 480
#define CEESPU_VRAM_OFFSET 0xf000
#define CEESPU_SPRITE_OFFSET 0xe000
#define CEESPU_FONT_MEMORY_OFFSET 0xe800
#define CEESPU_SPRITE_PALLETE_OFFSET CEESPU_SPRITE_OFFSET - 4 * 4
#define CEESPU_SPRITE_TEXTURE_OFFSET 0xe100

#define TEXTURE_PIXEL(x, y) (640 * (y) + (x))

class Video {
 public:
  Video();
  ~Video();
  void init();
  void reset();
  void drawChar(const Ceespu& cpu, uint8_t x, uint8_t y);
  void drawSprites(const Ceespu& cpu);
  void update(const Ceespu& cpu);

 private:
  uint32_t framebuffer[480 * 640];
  bool drawOccured;
  bool spritesChanged;
  SDL_Window* window = NULL;
  SDL_Renderer* renderer = NULL;
  SDL_Texture* texture = NULL;
};

#endif  // EMULATOR_VIDEO_H