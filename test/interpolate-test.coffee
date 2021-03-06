require 'es6-shim'
vows = require 'vows'
assert = require 'assert'
chroma = require '../chroma'


vows
    .describe('Some tests for chroma.color()')

    .addBatch

        'hsv interpolation white <-> red':
            topic: chroma('white').interpolate(0.5, 'red', 'hsv')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff8080'

        'use mix as alias':
            topic: chroma('white').mix(0.5, 'red', 'hsv')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff8080'

        'alternative mix syntax':
            topic: chroma.mix('red', 'blue', 0.25)
            'works': (topic) -> assert.deepEqual topic.hex(), '#bf003f'

        'hsl interpolation white <-> red':
            topic: chroma('white').interpolate(0.5, 'red', 'hsl')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff8080'

        'rgb interpolation white <-> red':
            topic: chroma('white').interpolate(0.5, 'red', 'rgb')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff7f7f'

        'hsv interpolation red <-> white':
            topic: chroma('red').interpolate(0.5, 'white', 'hsv')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff8080'

        'hsl interpolation red <-> white':
            topic: chroma('red').interpolate(0.5, 'white', 'hsl')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff8080'

        'rgb interpolation red <-> white':
            topic: chroma('red').interpolate(0.5, 'white', 'rgb')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff7f7f'

        'interpolation short function':
            topic:
                f: (t) -> chroma.interpolate('#ff0000', '#ffffff', t, 'hsv').hex()
            'starts at red': (topic) -> assert.equal topic.f(0), '#ff0000'
            'goes over light red': (topic) -> assert.equal topic.f(0.5), '#ff8080'
            'ends at white': (topic) -> assert.equal topic.f(1), '#ffffff'

        'num interpolation white <-> red':
            topic: chroma(0xffffff).interpolate(0.5, 0xff0000, 'num')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff7f7f'

        'num interpolation red <-> white':
            topic: chroma(0xff0000).interpolate(0.5, 0xffffff, 'num')
            'works': (topic) -> assert.deepEqual topic.hex(), '#ff7f7f'

        'interpolation short function with num provided':
            topic:
                f: (t) -> chroma.interpolate(0xff0000, 0xffffff, t, 'num').hex()
            'starts at red': (topic) -> assert.equal topic.f(0), '#ff0000'
            'goes over light red': (topic) -> assert.equal topic.f(0.5), '#ff7f7f'
            'ends at white': (topic) -> assert.equal topic.f(1), '#ffffff'


    .export(module)
