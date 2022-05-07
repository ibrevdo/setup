
#!/bin/bash

POSITIONAL_ARGS=()

rename_wa_images() {
    for i in IMG-*.jpg; do
        if [ -e $i ]; then
            new_name=$(echo "$i" | sed 's/IMG-\(.*\)\.jpg$/\1/')
            #echo "Moving: $i -> ${new_name}.jpg"
            mv $i ${new_name}.jpg
        fi
    done
    for i in IMG-*.jpeg; do
        if [ -e $i ]; then
            new_name=$(echo "$i" | sed 's/IMG-\(.*\)\.jpeg$/\1/')
            #echo "Moving: $i -> ${new_name}.jpg"
            mv $i ${new_name}.jpeg
        fi
    done
}

print_usage() {
    printf "#########################
Usage: image_tools.sh <option>
Options:
    --rename_wa_images      cuts IMG prefix from filenames
"
}

main_logic() {

    if ! [[ $# -gt 0 ]]; then
        print_usage
        exit 1
    fi

    while [[ $# -gt 0 ]]; do
        case $1 in
            --rename_wa_images)
                shift   # past argument
                rename_wa_images
                ;;
            -*|--*)
                shift   # past argument
                print_usage
                exit 1
                ;;
            *)
                POSITIONAL_ARGS+=("$1") # save positional args
                shift   # past argument
                ;;
        esac
    done

    set -- "${POSITIONAL_ARGS[@]}" # resotore positional params
}

### START SCRIPT ####

WORKING_DIR="$(cd .; pwd)"
#echo "Working directory: $WORKING_DIR"
main_logic $@
exit 0
