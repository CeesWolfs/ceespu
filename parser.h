#pragma once

#include "ceespu_cas.h"
#include "hashtable.h"

int parse(token * tk_array, instr * instr_array, hashtable_t * labels, label_to_be_replaced * replace_labels, char * binary);