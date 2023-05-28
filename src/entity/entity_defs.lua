ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['idle-right'] = {
                frames = {1, 2, 3, 4, 5},
                interval = 0.15,
                texture = 'player_idle'
            },
            ['idle-left'] = {
                frames = {6, 7, 8, 9, 10},
                interval = 0.15,
                texture = 'player_idle'
            },
            ['walk-right'] = {
                frames = {1, 2, 3, 4, 5, 6},
                interval = 0.15,
                texture = 'player_walk'
            },
            ['walk-left'] = {
                frames = {7, 8, 9, 10, 11, 12},
                interval = 0.15,
                texture = 'player_walk'
            },
            ['jump-right'] = {
                frames = {1, 2, 3},
                interval = 0.15,
                texture = 'player_jump',
                looping = false
            },
            ['jump-left'] = {
                frames = {4, 5, 6},
                interval = 0.15,
                texture = 'player_jump',
                looping = false
            },
        }
    },
}