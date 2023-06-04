ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['idle-right'] = {
                framesCol = '1-5',
                interval = 0.1,
                texture = 'player_idle-right'
            },
            ['idle-left'] = {
                framesCol = '1-5',
                interval = 0.1,
                texture = 'player_idle-left'
            },
            ['sword-idle-right'] = {
                framesCol = '1-5',
                interval = 0.1,
                texture = 'player_sword-idle-right'
            },
            ['sword-idle-left'] = {
                framesCol = '1-5',
                interval = 0.1,
                texture = 'player_sword-idle-left'
            },
            ['walk-right'] = {
                framesCol = '1-6',
                interval = 0.1,
                texture = 'player_walk-right'
            },
            ['walk-left'] = {
                framesCol = '1-6',
                interval = 0.1,
                texture = 'player_walk-left'
            },
            ['jump-right'] = {
                framesCol = '1-3',
                interval = 0.1,
                texture = 'player_jump-right',
                onloop = 'pauseAtEnd'
            },
            ['jump-left'] = {
                framesCol = '1-3',
                interval = 0.1,
                texture = 'player_jump-left',
                onloop = 'pauseAtEnd'
            },
            ['fall-right'] = {
                framesCol = 1,
                interval = 0.1,
                texture = 'player_fall-right'
            },
            ['fall-left'] = {
                framesCol = 1,
                interval = 0.1,
                texture = 'player_fall-left'
            },
        }
    },
}