ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['attack'] = {
                    framesCol = '1-3',
                    interval = 0.1,
                    onloop = 'pauseAtEnd'
            },
            ['fall'] = {
                    framesCol = 1,
                    interval = 0.1,
            },
            ['hurt'] = {
                    framesCol = '1-4',
                    interval = 0.1,
                    onloop = 'pauseAtEnd'
            },
            ['idle'] = {
                    framesCol = '1-5',
                    interval = 0.1,
            },
            ['jump'] = {
                    framesCol = '1-3',
                    interval = 0.1,
                    onloop = 'pauseAtEnd'
            },
            ['land'] = {
                    framesCol = '1-2',
                    interval = 0.1,
                    onloop = 'pauseAtEnd'
            },
            ['walk'] = {
                    framesCol = '1-6',
                    interval = 0.1,
            },
        }
    },
    ['pinkyStar'] = {
        animations = {
            ['idle'] = {
                    framesCol = '1-8',
                    interval = 0.1,
            },
        }
    }
}