#pragma once
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ceespu_cas.h"

struct entry_s {
  char *key;
  uint16_t value;
  struct entry_s *next;
};

typedef struct entry_s entry_t;

struct hashtable_s {
  int size;
  struct entry_s **table;
};

typedef struct hashtable_s hashtable_t;

hashtable_t *ht_create(int size);

int ht_hash(hashtable_t *hashtable, char *key);

entry_t *ht_newpair(char *key, uint16_t value);

int ht_set(hashtable_t *hashtable, char *key, uint16_t value);

int ht_get(hashtable_t *hashtable, char *key, uint16_t *value);
