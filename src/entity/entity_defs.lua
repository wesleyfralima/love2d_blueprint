ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['idle'] = {
                {
                    framesCol = '1-5',
                    interval = 0.1,
                    texture = 'player_idle-right'
                },
                {
                    framesCol = '1-5',
                    interval = 0.1,
                    texture = 'player_idle-left'
                },
                {
                    framesCol = '1-5',
                    interval = 0.1,
                    texture = 'player.idle[1]'
                },
                {
                    framesCol = '1-5',
                    interval = 0.1,
                    texture = 'player_sword-idle-left'
                },
            },
            ['walk'] = {
                {
                    framesCol = '1-6',
                    interval = 0.1,
                    texture = 'player_walk-right'
                },
                {
                    framesCol = '1-6',
                    interval = 0.1,
                    texture = 'player_walk-left'
                },
                {
                    framesCol = '1-6',
                    interval = 0.1,
                    texture = 'player_sword-walk-right'
                },
                {
                    framesCol = '1-6',
                    interval = 0.1,
                    texture = 'player_sword-walk-left'
                },
            },
            ['jump'] = {
                {
                    framesCol = '1-3',
                    interval = 0.1,
                    texture = 'player_jump-right',
                    onloop = 'pauseAtEnd'
                },
                {
                    framesCol = '1-3',
                    interval = 0.1,
                    texture = 'player_jump-left',
                    onloop = 'pauseAtEnd'
                },
                {
                    framesCol = '1-3',
                    interval = 0.1,
                    texture = 'player_jump-right',
                    onloop = 'pauseAtEnd'
                },
                {
                    framesCol = '1-3',
                    interval = 0.1,
                    texture = 'player_jump-left',
                    onloop = 'pauseAtEnd'
                },
            },
            ['fall'] = {
                {
                    framesCol = 1,
                    interval = 0.1,
                    texture = 'player_fall-right'
                },
                {
                    framesCol = 1,
                    interval = 0.1,
                    texture = 'player_fall-left'
                },
                {
                    framesCol = 1,
                    interval = 0.1,
                    texture = 'player_fall-right'
                },
                {
                    framesCol = 1,
                    interval = 0.1,
                    texture = 'player_fall-left'
                },
            }
        }
    },
}