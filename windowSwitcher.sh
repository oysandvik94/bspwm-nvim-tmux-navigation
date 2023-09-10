#!/bin/bash

# Get the direction from the parameter
direction=$1
case $direction in
    west)
        tmuxPaneDirection="left"
        tmuxDirection="L"
        ;;
    east)
        tmuxPaneDirection="right"
        tmuxDirection="R"
        ;;
    north)
        tmuxPaneDirection="top"
        tmuxDirection="U"
        ;;
    south)
        tmuxPaneDirection="bottom"
        tmuxDirection="D"
        ;;
    *)
        echo "Invalid direction"
        exit 1
        ;;
esac

window=$(xdotool getwindowfocus getwindowname)
is_tmux=$(echo "$window" | grep -i "tmux ~")

if [ -n "$is_tmux" ]
then
    pane_command=$(tmux display -p "#{pane_current_command}")
    is_vim=$(echo "$pane_command" | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$')

    if [ -n "$is_vim" ]; then
        case $direction in
            west)
                tmux send-keys C-h
                ;;
            east)
                tmux send-keys C-l
                ;;
            north)
                tmux send-keys C-k
                ;;
            south)
                tmux send-keys C-j
                ;;
        esac
    else
        # Get the pane specification for the given direction
        pane_spec=$(tmux display -p "#{pane_at_$tmuxPaneDirection}")

        # Check if the pane exists
        if [ "$pane_spec" = "1" ]; then
            bspc node -f $direction
        else
            tmux select-pane -$tmuxDirection
        fi

    fi
else
    bspc node -f $direction
fi

