#!/usr/bin/env bash

for FLAVOUR in default dark light; do
    echo "${FLAVOUR}"
    METACITY_DIR="../../../metacity/src/${FLAVOUR}/metacity-1"
    mkdir -p "${METACITY_DIR}"

    case ${FLAVOUR} in
        default)
            close_unfocused="636363"
            close_unfocused_glyphs="F7F7F7"
            focused_glyphs="F7F7F7"
            focused_normal="323030"
            focused_prelight="4F4F4F"
            focused_pressed="5C5C5C"
            unfocused_glyphs="A3A2A2"
            unfocused_normal="3F3C3C"
            unfocused_prelight="4F4F4F"
            unfocused_pressed="5C5C5C"
            ;;
        dark)
            close_unfocused="575757"
            close_unfocused_glyphs="D2D2D2"
            focused_glyphs="F7F7F7"
            focused_normal="2C2C2C"
            focused_prelight="4A4A4A"
            focused_pressed="5E5E5E"
            unfocused_glyphs="D2D2D2"
            unfocused_normal="3E3E3E"
            unfocused_prelight="5A5A5A"
            unfocused_pressed="5E5E5E"
            ;;
        light)
            close_unfocused="A3A3A3"
            close_unfocused_glyphs="f9f9f9"
            focused_glyphs="3D3D3D"
            focused_normal="DEDEDE"
            focused_prelight="C6C6C6"
            focused_pressed="B5B5B5"
            unfocused_glyphs="626262"
            unfocused_normal="F7F7F7"
            unfocused_prelight="dbdbdb"
            unfocused_pressed="B5B5B5"
            ;;
    esac

    for SVG_IN in unity/*.svg; do
        # Skip the files we don't need for Metacity
        SVG=$(basename "${SVG_IN}")

        # If the SVG has a short name, ignore it.
        if [[ $SVG != *"_"* ]]; then
            continue
        fi

        # Launchers are Unity specific. Ignore.
        if [[ $SVG == *"launcher"* ]]; then
            continue
        fi

        # Copy the original SVG to the new location
        cp "${SVG_IN}" "${METACITY_DIR}/"

        if [[ $SVG == *"close_focused_normal"* ]]; then
            continue
        fi

        if [[ $SVG == *"close_focused_prelight"* ]]; then
            continue
        fi

        if [[ $SVG == *"close_focused_pressed"* ]]; then
            continue
        fi

        if [[ $SVG == *"close_unfocused.svg"* ]]; then
            sed -i "s/636363/${close_unfocused}/g" "${METACITY_DIR}/${SVG}"
            sed -i "s/ffffff/${close_unfocused_glyphs}/g" "${METACITY_DIR}/${SVG}"
            continue
        fi

        if [[ $SVG == *"focused_normal"* ]]; then
            sed -i "s/323030/${focused_normal}/g" "${METACITY_DIR}/${SVG}"
            sed -i "s/ffffff/${focused_glyphs}/g" "${METACITY_DIR}/${SVG}"
            continue
        fi

        if [[ $SVG == *"_unfocused.svg"* ]]; then
            sed -i "s/323030/${unfocused_normal}/g" "${METACITY_DIR}/${SVG}"
            sed -i "s/ffffff/${unfocused_glyphs}/g" "${METACITY_DIR}/${SVG}"
            continue
        fi

        # This is a special case
        if [[ $SVG == *"close_unfocused_prelight"* ]]; then
            if [ "${FLAVOUR}" == "dark" ]; then
                sed -i "s/707070/636363/g" "${METACITY_DIR}/${SVG}"
                sed -i "s/ffffff/f5f5f5/g" "${METACITY_DIR}/${SVG}"
            elif [ "${FLAVOUR}" == "light" ]; then
                sed -i "s/707070/b0b0b0/g" "${METACITY_DIR}/${SVG}"
                sed -i "s/ffffff/f9f9f9/g" "${METACITY_DIR}/${SVG}"
            fi
            continue
        fi

        if [[ $SVG == *"unfocused_prelight"* ]]; then
            sed -i "s/505050/${unfocused_prelight}/g" "${METACITY_DIR}/${SVG}"
            sed -i "s/ffffff/${unfocused_glyphs}/g" "${METACITY_DIR}/${SVG}"
            continue
        fi

        if [[ $SVG == *"focused_prelight"* ]]; then
            sed -i "s/505050/${focused_prelight}/g" "${METACITY_DIR}/${SVG}"
            sed -i "s/ffffff/${focused_glyphs}/g" "${METACITY_DIR}/${SVG}"
            continue
        fi

        if [[ $SVG == *"unfocused_pressed"* ]]; then
            sed -i "s/5c5c5c/${unfocused_pressed}/g" "${METACITY_DIR}/${SVG}"
            if [[ $SVG == *"close_unfocused_pressed"* ]] && [ "${FLAVOUR}" == "light" ]; then
                sed -i "s/ffffff/f9f9f9/g" "${METACITY_DIR}/${SVG}"
            else
                sed -i "s/ffffff/${unfocused_glyphs}/g" "${METACITY_DIR}/${SVG}"
            fi
            continue
        fi

        if [[ $SVG == *"focused_pressed"* ]]; then
            sed -i "s/5c5c5c/${focused_pressed}/g" "${METACITY_DIR}/${SVG}"
            sed -i "s/ffffff/${focused_glyphs}/g" "${METACITY_DIR}/${SVG}"
            continue
        fi
    done
done
sync
