
#!/bin/bash

POSITIONAL_ARGS=()

rename_wa_images() {
    for i in $(find -maxdepth 1 -iname "*.jp*" -o -iname "*.mp4*"); do
        if [ -e $i ]; then
            new_name=$(echo "$i" | sed 's/IMG-\(.*\)/\1/')
            new_name=$(echo "$new_name" | sed 's/-WA/_WA/')
            #echo "Moving: $i -> ${new_name}"
            mv $i ${new_name}
        fi
    done
}

cleanup_feh_list() {
    # for each jpg file in the dirctory, check whether exists in feh-filelist
    # if no, delete it

    if [ -e feh_*_filelist ]; then
        PIC=$(find -iname "*.jpg" -o -iname "*.jpeg")
        for i in $PIC; do
            if ! grep -q "$i" feh_*_filelist; then
                echo "Deleting: $i"
                rm "$i"
            fi
        done
        rm feh_*_filelist
    else
        echo "cant find feh filelist. exiting"
    fi
}   

find_duplicates() {

    #DEST=~/winshare/photos/
    DEST="$1"

    # get full path of destination dir
    DEST_DIR="$(cd "$DEST"; pwd)"
    
    # check if files in SRC dir already present in DEST dir
    for i in $(find -maxdepth 1 -iname "*.jp*" -o -iname "*.mp4*"); do
        
        # filename without (optional) full path, IMG- and extention (explained in wiki)
        name=$(echo "$i" | sed -r 's/(.*\/)?(IMG-)?(.*)\..*/\3/') 
        #name=$(echo "$i" | sed 's/.*\/\(.*\)\..*/\1/') #filename without .jpg in the end

        RES=$(find "$DEST_DIR" -iname "*$name*")
        if [ -z "$RES" ]; then
            echo $name not found elsewhere
        else
            echo $name : "$RES"
            # iterate over lines inside $RES variable
            # while IFS= read -r line; do
            #     echo "$name : $line"
            # done <<< "$RES"
        fi
    done
}

print_usage() {
    printf "#########################
Usage: image_tools.sh <option>
Options:
    --rename_wa_images      cuts IMG prefix from filenames
    --cleanup_feh_list      delete all image files, that are NOT listed in feh-filelist
    --find_duplicates <dest> will try to find partial filename (date part) in <dest> directory
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
            --cleanup_feh_list)
                shift   # past argument
                cleanup_feh_list
                ;;
            --find_duplicates)
                DEST="$2"
                shift   # past argument
                shift   # past value
                if [ -z "$DEST" ]; then
                    printf "Error: <dest> is empty\n"
                    print_usage
                    exit 1
                fi
                find_duplicates "$DEST"
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
main_logic "$@"
exit 0
