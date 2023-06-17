#!/bin/bash

mons $@ && printf -- "$*\n" > ~/.cache/mons_last
