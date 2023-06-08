return {
    ['map'] = 'assets/tiled/maps/test_map.lua',

    ['gravity'] = {
        x = 0,
        y = 1000
    },

    ['player'] = {
        type = 'player',
        x = 0,
        y = 0,
        width = PLAYER_IMAGE_SIZE,
        height = PLAYER_IMAGE_SIZE,
        direction = RIGHT,
        dx = 150,
        dy = PLAYER_JUMP_IMPULSE,
        colliderHeightDifference = 6,
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

    },
}