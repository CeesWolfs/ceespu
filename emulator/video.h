#ifndef EMULATOR_VIDEO_H
#define EMULATOR_VIDEO_H

#include "include/SDL.h"
#include "ceespu.h"

#define CEESPU_SCREEN_WIDTH 640
#define CEESPU_SCREEN_HEIGHT 480
#define CEESPU_VRAM_OFFSET 0xf000
#define CEESPU_FONT_MEMORY_OFFSET 0xe000

#define TEXTURE_PIXEL(x, y) (640 * (y) + (x))

class Video {
 public:
  Video();
  ~Video();
  void init();
  void reset();
  void drawChar(const Ceespu& cpu, uint8_t x, uint8_t y);
  void update();

 private:
  uint32_t framebuffer[480 * 640];
  bool drawOccured;
  SDL_Window* window = NULL;
  SDL_Renderer* renderer = NULL;
  SDL_Texture* texture = NULL;
};

#endif  // EMULATOR_VIDEO_H