# Constants
const
    MEMORY_SIZE* = 4096
    DISPLAY_WIDTH* = 64
    DISPLAY_HEIGHT* = 32
    DISPLAY_SIZE* = DISPLAY_WIDTH * DISPLAY_HEIGHT
    SPRITE_WIDTH* = 8
    SPRITE_HEIGHT* = 15 # This is just the typical maximum height of a sprite, but not necessarily always true. It's usually determined by n in the draw opcode
    PIXEL_WIDTH* = 10
    PIXEL_HEIGHT* = 10
    OPCODES_PER_FRAME* = 8
    PROGRAM_START* = 0x200
    FONTSET_START* = 0x000
    FONTSET_WIDTH* = 5
    FONTSET_HEIGHT* = 8

const FONTSET*: array[80, uint8] = [
    0xF0'u8, 0x90, 0x90, 0x90, 0xF0, # 0
    0x20, 0x60, 0x20, 0x20, 0x70, # 1
    0xF0, 0x10, 0xF0, 0x80, 0xF0, # 2
    0xF0, 0x10, 0xF0, 0x10, 0xF0, # 3
    0x90, 0x90, 0xF0, 0x10, 0x10, # 4
    0xF0, 0x80, 0xF0, 0x10, 0xF0, # 5
    0xF0, 0x80, 0xF0, 0x90, 0xF0, # 6
    0xF0, 0x10, 0x20, 0x40, 0x40, # 7
    0xF0, 0x90, 0xF0, 0x90, 0xF0, # 8
    0xF0, 0x90, 0xF0, 0x10, 0xF0, # 9
    0xF0, 0x90, 0xF0, 0x90, 0x90, # A
    0xE0, 0x90, 0xE0, 0x90, 0xE0, # B
    0xF0, 0x80, 0x80, 0x80, 0xF0, # C
    0xE0, 0x90, 0x90, 0x90, 0xE0, # D
    0xF0, 0x80, 0xF0, 0x80, 0xF0, # E
    0xF0, 0x80, 0xF0, 0x80, 0x80  # F
]