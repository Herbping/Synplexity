#!/bin/sh
MONO_GC_PARAMS=nursery-size=16m mono src/bin/Debug/negation.exe $*
