British Rail Class 158 Express Sprinter
=======================================

![Screenshot](./class158.jpg)

To-do list
----------

 - [ ] Add head and tail lights
 - [ ] Realistic internal layout
 - [ ] More liveries
 - [ ] More controls in the cab


Variants
--------

This train comes in the following variants:

Train ID       | Description              | Screenshot
---------------|--------------------------|------------
`class158`     | Default ScotRail livery  | ![metro](./class158_thumb.jpg)
`class158_gwr` | GWR livery               | ![metro](./class158_gwr_thumb.jpg)


Stations
--------

The door open and close animations take 18 seconds (4 seconds to open, 10
seconds open, 4 seconds to close), so a station stop should be about that time.

This train can accelerate at 0.8 m/s<sup>2</sup> according to [Wikipedia].

Therefore the recommended [station
sign](https://wiki.traincarts.net/p/TrainCarts/Signs/Station) would look
something like this:
```
[+train]
station .8m/ss
18
continue
```

[Animate signs](https://wiki.traincarts.net/p/TrainCarts/Signs/Animate)
placed under the front wheels of the train when stopped at a station activate
about 2 seconds prior to the train stopping, so the recommended sign text
placed at the platform side of the rail would look something like this at the
right end of a platform:
```
[+train:left]
animate reset
doors_r
1.0 2.0
```

or this at the left end of a platform:
```
[+train:right]
animate reset
doors_l
1.0 2.0
```

[Wikipedia]: https://en.wikipedia.org/wiki/British_Rail_Class_158
