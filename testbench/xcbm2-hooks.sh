
XCBM2OPTS+=" -default"
XCBM2OPTS+=" -model 610"
XCBM2OPTS+=" -virtualdev"
XCBM2OPTS+=" +truedrive"
#XCBM2OPTS+=" -VICIIfilter 0"
#XCBM2OPTS+=" -VICIIextpal"
#XCBM2OPTS+=" -VICIIpalette pepto-pal.vpl"
XCBM2OPTS+=" -warp"
XCBM2OPTS+=" -debugcart"
#XCBM2OPTS+=" -console"

# extra options for the different ways tests can be run
# FIXME: the emulators may crash when making screenshots when emu was started
#        with -console
XCBM2OPTSEXITCODE+=" -console"
XCBM2OPTSSCREENSHOT+=""

# X and Y offsets for saved screenshots. when saving a screenshot in the
# computers reset/startup screen, the offset gives the top left pixel of the
# top left character on screen.
XCBM2SXO=32
XCBM2SYO=35

XCBM2REFSXO=32
XCBM2REFSYO=35

function xcbm2_check_environment
{
    XCBM2="$EMUDIR"xcbm2
}

# $1  option
# $2  test path
function xcbm2_get_options
{
#    echo xcbm2_get_options "$1" "$2"
    exitoptions=""
    case "$1" in
        "default")
                exitoptions=""
            ;;
        "vicii-pal")
                exitoptions="-pal"
                testprogvideotype="PAL"
            ;;
        "vicii-ntsc")
                exitoptions="-ntsc"
                testprogvideotype="NTSC"
            ;;
        "vicii-ntscold")
                exitoptions="-ntscold"
                testprogvideotype="NTSCOLD"
            ;;
        "cia-old")
                exitoptions="-ciamodel 0"
                new_cia_enabled=0
            ;;
        "cia-new")
                exitoptions="-ciamodel 1"
                new_cia_enabled=1
            ;;
        "sid-old")
                exitoptions="-sidenginemodel 256"
                new_sid_enabled=0
            ;;
        "sid-new")
                exitoptions="-sidenginemodel 257"
                new_sid_enabled=1
            ;;
        *)
                exitoptions=""
            ;;
    esac
}


# $1  option
# $2  test path
function xcbm2_get_cmdline_options
{
#    echo xcbm2_get_cmdline_options "$1" "$2"
    exitoptions=""
    case "$1" in
        "PAL")
                exitoptions="-pal"
            ;;
        "NTSC")
                exitoptions="-ntsc"
            ;;
        "NTSCOLD")
                exitoptions="-ntscold"
            ;;
        "6569") # "old" PAL
                exitoptions="-VICIImodel 6569"
            ;;
        "8565") # "new" PAL
                exitoptions="-VICIImodel 8565"
            ;;
        "8562") # "new" NTSC
                exitoptions="-VICIImodel 8562"
            ;;
        "6526") # "old" CIA
                exitoptions="-ciamodel 0"
            ;;
        "6526A") # "new" CIA
                exitoptions="-ciamodel 1"
            ;;
    esac
}

################################################################################
# reset
# run test program
# exit when write to $daff occurs - the value written determines success (=$00) or fail (=$ff)
# exit after $timeout cycles (exitcode=$01)
# save a screenshot at exit - success or failure is determined by comparing screenshots

# $1  test path
# $2  test program name
# $3  timeout cycles
function xcbm2_run_screenshot
{
    extraopts=""$4" "$5" "$6""
#    echo $XCBM2 "$1"/"$2"
    mkdir -p "$1"/".testbench"
    rm -f "$1"/.testbench/"$2"-xcbm2.png
#    echo $XCBM2 $XCBM2OPTS $XCBM2OPTSSCREENSHOT $extraopts "-limitcycles" "$3" "-exitscreenshot" "$1"/.testbench/"$2"-xcbm2.png "$1"/"$2" " 1> /dev/null 2> /dev/null"
    $XCBM2 $XCBM2OPTS $XCBM2OPTSSCREENSHOT $extraopts "-limitcycles" "$3" "-exitscreenshot" "$1"/.testbench/"$2"-xcbm2.png "$1"/"$2" 1> /dev/null 2> /dev/null
    exitcode=$?
    if [ $exitcode -ne 0 ]
    then
        if [ $exitcode -ne 1 ]
        then
            if [ $exitcode -ne 255 ]
            then
                echo -ne "\nerror: call to $XCBM2 failed.\n"
                exit -1
            fi
        fi
    fi
    if [ -f "$refscreenshotname" ]
    then
    
        # defaults for PAL
        XCBM2REFSXO=32
        XCBM2REFSYO=35
        XCBM2SXO=32
        XCBM2SYO=35
        
#        echo [ "${refscreenshotvideotype}" "${videotype}" ]
    
        if [ "${refscreenshotvideotype}" == "NTSC" ]; then
            XCBM2REFSXO=32
            XCBM2REFSYO=23
        fi
    
        # when either the testbench was run with --ntsc, or the test is ntsc-specific,
        # then we need the offsets on the NTSC screenshot
        if [ "${videotype}" == "NTSC" ] || [ "${testprogvideotype}" == "NTSC" ]; then
            XCBM2SXO=32
            XCBM2SYO=23
        fi
    
        ./cmpscreens "$refscreenshotname" "$XCBM2REFSXO" "$XCBM2REFSYO" "$1"/.testbench/"$2"-xcbm2.png "$XCBM2SXO" "$XCBM2SYO"
        exitcode=$?
    else
        echo -ne "reference screenshot missing - "
        exitcode=255
    fi
#    echo "exited with: " $exitcode
}

################################################################################
# reset
# run test program
# exit when write to $daff occurs - the value written determines success (=$00) or fail (=$ff)
# exit after $timeout cycles (exitcode=$01)

# $1  test path
# $2  test program name
# $3  timeout cycles
function xcbm2_run_exitcode
{
    extraopts=""$4" "$5" "$6""
#    echo $XCBM2 "$1"/"$2"
    $XCBM2 $XCBM2OPTS $XCBM2OPTSEXITCODE $extraopts "-limitcycles" "$3" "$1"/"$2" 1> /dev/null 2> /dev/null
    exitcode=$?
#    echo "exited with: " $exitcode
}
