// Copyright(c) 2018 <Cees Wolfs>

#include "receive.h"
#include <termios.h>

#ifdef __linux__
static struct termios oldt;

void restore_terminal_settings(void) {
  tcsetattr(0, TCSANOW, &oldt); /* Apply saved settings */
}

void disable_waiting_for_enter(void) {
  struct termios newt;

  /* Make terminal read 1 char at a time */
  tcgetattr(0, &oldt);               /* Save terminal settings */
  newt = oldt;                       /* Init new settings */
  newt.c_lflag &= ~(ICANON | ECHO);  /* Change settings */
  tcsetattr(0, TCSANOW, &newt);      /* Apply settings */
  atexit(restore_terminal_settings); /* Make sure settings will be restored when
                                        program ends  */
}

#endif
void receive_input(Ceespu* cpu) {
  char ch;
#ifdef __linux__
  disable_waiting_for_enter();
  while (cpu->running) {
    ch = getchar();
    if (cpu->running) {
      cpu->recieveInterrupt(ch);
    }
  }
  restore_terminal_settings();
#endif
#ifdef __WIN32__
  while (running) {
    char c = _getch();
    if (running) {
      cpu.receiveInterrupt(c);
    }
  }
#endif
}
