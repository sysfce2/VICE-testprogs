
XPETOPTS+=" -default"
#XPETOPTS+=" -VICIIfilter 0"
#XPETOPTS+=" -VICIIextpal"
#XPETOPTS+=" -VICIIpalette pepto-pal.vpl"
XPETOPTS+=" -warp"
#XPETOPTS+=" -console"
XPETOPTS+=" -debugcart"

# extra options for the different ways tests can be run
# FIXME: the emulators may crash when making screenshots when emu was started
#        with -console
XPETOPTSEXITCODE+=" -console"
XPETOPTSSCREENSHOT+=" -minimized"

# X and Y offsets for saved screenshots. when saving a screenshot in the
# computers reset/startup screen, the offset gives the top left pixel of the
# top left character on screen.
XPETSXO=32
XPETSYO=35

XPETREFSXO=32
XPETREFSYO=35

function xpet_check_environment
{
    XPET="$EMUDIR"xpet
}

# $1  option
# $2  test path
function xpet_get_options
{
#    echo xpet_get_options "$1" "$2"
    exitoptions=""
    case "$1" in
        "default")
                exitoptions=""
            ;;
        "crtc-pal")
                exitoptions="-pal"
                testprogvideotype="PAL"
            ;;
        "crtc-ntsc")
                exitoptions="-ntsc"
                testprogvideotype="NTSC"
            ;;
        "crtc-ntscold")
                exitoptions="-ntscold"
                testprogvideotype="NTSCOLD"
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
function xpet_get_cmdline_options
{
#    echo xpet_get_cmdline_options "$1" "$2"
    exitoptions=""
    case "$1" in
        "PAL")
                exitoptions="-pal"
            ;;
        "NTSC")
                exitoptions="-ntsc"
            ;;
    esac
}

# called once before any tests run
function xpet_prepare
{
}

################################################################################
# reset
# run test program
# exit when write to $8bff occurs - the value written determines success (=$00) or fail (=$ff)
# exit after $timeout cycles (exitcode=$01)
# save a screenshot at exit - success or failure is determined by comparing screenshots

# $1  test path
# $2  test program name
# $3  timeout cycles
# $4  test full path+name (may be empty)
# $5- extra options for the emulator
function xpet_run_screenshot
{
    mkdir -p "$1"/".testbench"
    rm -f "$1"/.testbench/"$2"-xpet.png
    if [ $verbose == "1" ]; then
        echo $XPET $XPETOPTS $XPETOPTSSCREENSHOT ${@:5} "-limitcycles" "$3" "-exitscreenshot" "$1"/.testbench/"$2"-xpet.png "$4"
    fi
    $XPET $XPETOPTS $XPETOPTSSCREENSHOT ${@:5} "-limitcycles" "$3" "-exitscreenshot" "$1"/.testbench/"$2"-xpet.png "$4" 1> /dev/null 2> /dev/null
    exitcode=$?
    if [ $exitcode -ne 0 ]
    then
        if [ $exitcode -ne 1 ]
        then
            if [ $exitcode -ne 255 ]
            then
                echo -ne "\nerror: call to $XPET failed.\n"
                exit -1
            fi
        fi
    fi
    if [ -f "$refscreenshotname" ]
    then
        ./cmpscreens "$refscreenshotname" "$XPETREFSXO" "$XPETREFSYO" "$1"/.testbench/"$2"-xpet.png "$XPETSXO" "$XPETSYO"
        exitcode=$?
    else
        echo -ne "reference screenshot missing - "
        exitcode=255
    fi
}

################################################################################
# reset
# run test program
# exit when write to $8bff occurs - the value written determines success (=$00) or fail (=$ff)
# exit after $timeout cycles (exitcode=$01)

# $1  test path
# $2  test program name
# $3  timeout cycles
# $4  test full path+name (may be empty)
# $5- extra options for the emulator
function xpet_run_exitcode
{
    if [ $verbose == "1" ]; then
        echo $XPET $XPETOPTS $XPETOPTSEXITCODE ${@:5} "-limitcycles" "$3" "$4"
    fi
    $XPET $XPETOPTS $XPETOPTSEXITCODE ${@:5} "-limitcycles" "$3" "$4" 1> /dev/null 2> /dev/null
    exitcode=$?
#    echo "exited with: " $exitcode
}
