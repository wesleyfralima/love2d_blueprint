ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['idle-right'] = {
                framesCol = '1-5',
                framesRow = 1,
                interval = 0.1,
                texture = 'player_idle'
            },
            ['idle-left'] = {
                framesCol = '1-5',
                framesRow = 2,
                interval = 0.1,
                texture = 'player_idle'
            },
            ['walk-right'] = {
                framesCol = '1-6',
                framesRow = 1,
                interval = 0.1,
                texture = 'player_walk'
            },
            ['walk-left'] = {
                framesCol = '1-6',
                framesRow = 2,
                interval = 0.1,
                texture = 'player_walk'
            },
            ['jump-right'] = {
                framesCol = '1-3',
                framesRow = 1,
                interval = 0.1,
                texture = 'player_jump',
                onloop = 'pauseAtEnd'
            },
            ['jump-left'] = {
                framesCol = '1-3',
                framesRow = 2,
                interval = 0.1,
                texture = 'player_jump',
                onloop = 'pauseAtEnd'
            },
            ['fall-right'] = {
                framesCol = 1,
                framesRow = 1,
                interval = 0.1,
                texture = 'player_fall'
            },
            ['fall-left'] = {
                framesCol = 1,
                framesRow = 2,
                interval = 0.1,
                texture = 'player_fall'
            },
        }
    },
}