return {
    ['map'] = 'assets/tiled/maps/test_map.lua',

    ['gravity'] = {
        x = 0,
        y = 1000
    },

    ['player'] = {
        type = 'player',
        x = 200,
        y = 479,
        width = 12,
        height = 20,
        direction = RIGHT,
        dx = 150,
        dy = PLAYER_JUMP_IMPULSE,
        holding = NOTHING,
        state = 'idle'
    },

    ['backgrounds'] = {
        {
            xSpeed = 60,
            ySpeed = 5,
            image = 'bg_yellow',
            x = 0,
            y = 300
        },
        {
            xSpeed = 100,
            ySpeed = 10,
            image = 'bg_brown',
            x = 0,
            y = 450,
        },
        {
            xSpeed = 150,
            ySpeed = 15,
            image = 'bg_blue',
            x = 0,
            y = 500,
        },
    },

    ['objects'] = {

    },

    ['enemys'] = {
        {
            type = 'pinkyStar',
            x = 250,
            y = 479,
            width = 16,
            height = 22,
            direction = LEFT,
            dx = 150,
            dy = 150,
            holding = NOTHING,
            state = 'idle'
        },
    },
}