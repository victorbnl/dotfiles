#!/bin/bash

mons $@ && printf -- "$*\n" > ~/.config/mons/last
