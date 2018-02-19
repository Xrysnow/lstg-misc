---
--- __init__.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


ASSETS      = {}

ASSETS.tex  = {
    pixel = ASSETS_PATH .. 'pixel.png',
}

ASSETS.font = {
    ascii1    = ASSETS_PATH .. 'font\\ascii_1.fnt',
    ascii2    = ASSETS_PATH .. 'font\\ascii_2.fnt',
    ascii3    = ASSETS_PATH .. 'font\\ascii_3.fnt',
    ascii4    = ASSETS_PATH .. 'font\\ascii_4.fnt',
    wqy       = ASSETS_PATH .. 'font\\WenQuanYiMicroHeiMono.ttf',
    uwrc      = ASSETS_PATH .. 'font\\urwclarendontwid_mono.TTF',
}

FONT_WQY    = ASSETS.font.wqy
FONT_URWC   = ASSETS.font.uwrc

FONT_ASCII1 = ASSETS.font.ascii1
FONT_ASCII2 = ASSETS.font.ascii2
FONT_ASCII3 = ASSETS.font.ascii3
FONT_ASCII4 = ASSETS.font.ascii4

LoadFont('asc1', FONT_ASCII1, true)
LoadFont('asc2', FONT_ASCII2, true)
LoadFont('asc3', FONT_ASCII3, true)
LoadFont('asc4', FONT_ASCII4, true)

