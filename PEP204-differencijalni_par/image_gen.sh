#!/usr/bin/env bash

kicad-cli sch export svg *.kicad_sch --output sch.svg
kicad-cli pcb export vrml --output "board.wrl" *.kicad_pcb

head -1 "board.wrl" > "board.front.wrl"
cat <<EOF >> "board.front.wrl"
Transform {
    children [
        DirectionalLight {
            on TRUE
            intensity 0.15
            ambientIntensity 0.21
            color 1.0 1.0 1.0
            direction 0.1 -0.1 -1
        }
EOF
cat "board.wrl" >> "board.front.wrl"
echo "] }" >> "board.front.wrl"

~/Downloads/rayhunter/rayhunter classic 7 1600 1600 \
    "board.front.wrl" \
    "pcb.png" \
    --camera-pos 0 0 2 \
    --camera-dir 0 0 -1 \
    --scene-bg-color 1 1 1
