#pragma once
#include "ceespu_cas.h"
#include "hashtable.h"

void semantic_analysis(instr* instr_array, int num_instr,
                       label_to_be_replaced* replace_labels,
                       hashtable_t* symbols, char* binary);
