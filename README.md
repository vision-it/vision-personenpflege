# vision-personenpflege

[![Build Status](https://travis-ci.org/vision-it/vision-personenpflege.svg?branch=production)](https://travis-ci.org/vision-it/vision-personenpflege)

## Parameter

## Usage

Include in the *Puppetfile*:

```
mod 'vision_personenpflege',
    :git => 'https://github.com/vision-it/vision-personenpflege.git,
    :ref => 'production'
```

Include in a role/profile:

```puppet
contain ::vision_personenpflege
```

