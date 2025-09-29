# Basic windowing controls
{ modifier }: let
        directions = [ "Left" "Right" "Up" "Down" ];
        tabs = builtins.genList (x: x) 10;
        bind = keys: action: { keys = modifier ++ keys; inherit action; };
    in {
        normal =
            # Move focus
            (map (direction:
                bind [ direction ] { type = "moveFocus"; inherit direction; }
            ) directions) ++
            # Move window
            (map (direction:
                bind [ "Shift" direction ] { type = "moveWindow"; inherit direction; }
            ) directions) ++
            # Move focus tab
            (map (tab:
                bind [ tab ] { type = "moveFocusTab"; inherit tab; }
            ) tabs) ++
            # Move window tab
            (map (tab:
                bind [ "Shift" tab ] { type = "moveWindowTab"; inherit tab; }
            ) tabs) ++
            [
                # Fullscreen
                (bind [ "f" ] { type = "fullscreen"; })
                # Kill focused
                (bind [ "Shift" "q" ] { type = "killFocused"; })
                # Modes
                (bind [ "r" ] { type = "mode"; mode = "resize"; })
            ];
        resize = [
            (bind [ "Left" ] { type = "resize"; axis = "width"; direction = "grow"; })
            (bind [ "Right" ] { type = "resize"; axis = "width"; direction = "shrink"; })
            (bind [ "Up" ] { type = "resize"; axis = "height"; direction = "shrink"; })
            (bind [ "Down" ] { type = "resize"; axis = "height"; direction = "grow"; })
            (bind [ "Escape" ] { type = "mode"; mode = "normal"; })
        ];
    }
