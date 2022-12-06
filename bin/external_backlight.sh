#!/bin/bash

for bus in {0..20}
do
    ddcutil setvcp \
            0x10 \
            $1 \
            $2 \
            --bus $bus \
            --maxtries 1,1,1 \
            --sleep-multiplier 0.03 \
            --async \
            >/dev/null 2>&1 &
done
